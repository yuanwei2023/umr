/*
 * Copyright © 2025 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sub license, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NON-INFRINGEMENT. IN NO EVENT SHALL THE COPYRIGHT HOLDERS, AUTHORS
 * AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
 * USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * The above copyright notice and this permission notice (including the
 * next paragraph) shall be included in all copies or substantial portions
 * of the Software.
 */
#include "imgui.h"
#include "panels.h"
#include "parson.h"
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <algorithm>
#include <cmath>

#include "kernel_trace_event.h"
#include "drawable_area.h"

#define IM_PI 3.14159265358979323846f

namespace HighlightStatus {
	enum Enum {
		Greyed = 0,
		Normal,
		YesIndirect,
		Yes,
		YesHighlight,
	};
}

namespace TracingStatus {
	enum Enum {
		Off = 0,
		Running,
		Stopping,
		PostProcessing,
		Error,
	};
}

namespace JobDurationMode {
	enum Enum {
		HardwareExecution,
		HardwareSubmit,
		Submit,
		WaitBeforeSubmit,
	};
	const char *Str[] {
		"Hardware Start Exec -> End Exec",
		"Hardware Submit -> End Exec",
		"UMD Submit -> End Exec",
		"UMD Submit -> Hardware Submit"
	};
}

namespace DrawStyle {
	enum Enum {
		None,
		Fill,
		Lines,
		Hatched
	};
}

namespace TimelineType {
	enum Enum {
		Hardware = 0,
		Kernel,
		Userspace
	};
}

/* Forward decl */
struct DrmSchedJob;
struct Timeline;
typedef std::vector<Timeline*> Timelines;

/* Helpers. */
static bool compute_job_rect(const DrawableArea& drawable_area,
							 float base_y, float row_size,
							 double start, double end, ImVec2& bl, ImVec2& tr);
static double get_job_duration(DrmSchedJob *job, enum JobDurationMode::Enum mode);

static const char *kernel_id_job_names[] = {
	"vm_update",
	"vm_update_pdes",
	"vm_update_range",
	"vm_pt_clear",
	"ttm_map_buffer",
	"ttm_access_memory_sdma",
	"ttm_copy_buffer",
	"clear_on_release",
	"move_blit",
	"ttm_clear_buffer",
	"cleaner_shader",
	"flush_gpu_tlb",
	"kfd_gart_map",
	"vcn_ring_test",
};

/* Struct representing a DmaFence. */
struct DmaFence {
	bool operator==(const DmaFence& f) const {
		return context == f.context && seqno == f.seqno;
	}
	void from_str(const char *s) {
		sscanf(s, "%" PRIu64 ":%" PRIu64, &context, &seqno);
	}

	struct {
		uint64_t context;
		uint64_t seqno;
	};
};

#define COLOR_TO_HEX(c) (((c) & 0xff) << 16) | ((c) & 0xff00) | (((c) >> 16) & 0xff)

/* Struct representing a single trace event. */
struct DrmEvent : public Event {
	DrmEvent(EventType::Enum t, double timestamp) : Event(t, timestamp) {
		memset(&u, 0, sizeof(u));
	}

	DrmEvent& operator=(const DrmEvent& evt) {
		_copy(evt);
		return *this;
	}

	DrmEvent(const DrmEvent& evt) : Event(evt.type, evt.timestamp) { _copy(evt); }

	~DrmEvent() {
		trim();
	}
	void trim() {
		if (type == EventType::DrmSchedJobRun) {
			free(u.drm_sched_job_run.ring);
			u.drm_sched_job_run.ring = NULL;
			free(u.drm_sched_job_run.device);
			u.drm_sched_job_run.device = NULL;
		}
	}

	const DmaFence& get_job_fence() const {
		switch (type) {
			case EventType::DrmSchedJobQueue:
				return u.drm_sched_job_queue.fence;
			case EventType::DrmSchedJobRun:
				return u.drm_sched_job_run.fence;
			case EventType::DrmSchedJobUnschedulable:
				return u.drm_sched_job_unschedulable.fence;
			case EventType::DrmSchedJobAddDep:
				return u.drm_sched_job_add_dep.fence;
			case EventType::DrmSchedJobDone:
				return u.drm_sched_job_done.signaled;
			default: {
				assert(false);
			}
		}
	}

	void handle_field(int field_idx, char *name, int name_len, char *value, int value_len) {
		switch (type) {
			case EventType::DrmSchedJobQueue: {
				if (str_is(name, "fence", name_len))
					u.drm_sched_job_run.fence.from_str(value);
				PARSE_INT(u.drm_sched_job_queue.sw_job_count, "job count", 10);
				PARSE_INT(u.drm_sched_job_queue.client_id, "client_id", 10);
				else if (str_is(name, "fence", name_len))
					u.drm_sched_job_queue.fence.from_str(value);
				break;
			}
			case EventType::DrmSchedJobRun: {
				if (str_is(name, "fence", name_len))
					u.drm_sched_job_run.fence.from_str(value);
				else if (str_is(name, "ring", name_len))
					u.drm_sched_job_run.ring = strndup(value, value_len);
				else if (str_is(name, "dev", name_len))
					u.drm_sched_job_run.device = strndup(value, value_len);
				PARSE_INT(u.drm_sched_job_run.hw_job_count, "hw job count", 10);
				PARSE_INT(u.drm_sched_job_run.client_id, "client_id", 10);
				break;
			}
			case EventType::DrmSchedJobDone: {
				if (str_is(name, "fence", name_len))
					u.drm_sched_job_done.signaled.from_str(value);
				break;
			}
			case EventType::DrmSchedJobAddDep: {
				if (str_is(name, "depends on fence", name_len))
					u.drm_sched_job_add_dep.dep_fence.from_str(value);
				else if (str_is(name, "fence", name_len))
					u.drm_sched_job_add_dep.fence.from_str(value);
				break;
			}
			case EventType::DrmSchedJobUnschedulable: {
				if (str_is(name, "depends on unsignaled fence", name_len))
					u.drm_sched_job_unschedulable.wait_fence.from_str(value);
				else if (str_is(name, "fence", name_len))
					u.drm_sched_job_unschedulable.fence.from_str(value);
				break;
			}
			default:
				/* Ignore other events. */
				break;
		}
	}

	union {
		struct {
			DmaFence fence;
			int sw_job_count;
			uint64_t client_id;
		} drm_sched_job_queue;
		struct {
			DmaFence fence;
			DmaFence wait_fence;
		} drm_sched_job_unschedulable;
		struct {
			DmaFence fence;
			char *ring;
			char *device;
			int16_t hw_job_count;
			uint64_t client_id;
		} drm_sched_job_run;
		struct {
			DmaFence signaled;
		} drm_sched_job_done;
		struct {
			DmaFence fence;
			DmaFence dep_fence;
		} drm_sched_job_add_dep;
	} u;

private:
	void _copy(const Event& _evt) {
		Event::_copy(_evt);

		const DrmEvent &evt = static_cast<const DrmEvent&>(_evt);

		u = evt.u;

		if (type == EventType::DrmSchedJobRun) {
			u.drm_sched_job_run.ring = strdup(evt.u.drm_sched_job_run.ring);
			u.drm_sched_job_run.device = strdup(evt.u.drm_sched_job_run.device);
		}
	}
};

/* A timeline contains all the information needed to describe a timeline (which GPU? which process, etc).
 * DrmSchedJob will reference them.
 * Timelines are displayed in 3 groups:
 *  - hardware: represents a hardware queue, where jobs execution happens
 *  - kernel: shows jobs submitted by the kernel (eg: page table update, memory clears, ...)
 *  - userspace: shows jobs submitted by userspace applications.
 */
struct Timeline {
	Timeline(const char *task_or_device, const char *process_or_ring, TimelineType::Enum _type,
			 int _pid, int _tgid,
			 uint64_t client_id, uint64_t context, double ts) : pid(_pid), tgid(_tgid) {
		if (_type == TimelineType::Userspace) {
			u.sw.task_name = (strcmp(task_or_device, "<...>") == 0) ? strdup(process_or_ring) : strdup(task_or_device);
			u.sw.process_name = strdup(process_or_ring);
			u.sw.drm_client_id = client_id;
			u.sw.drm_client_name = NULL;
		} else if (_type == TimelineType::Kernel) {
			u.kmd.task_name = (strcmp(task_or_device, "<...>") == 0) ? strdup(process_or_ring) : strdup(task_or_device);
			u.kmd.process_name = strdup(process_or_ring);
			u.kmd.kmd_id = client_id;
			u.kmd.context = context;
			u.kmd.umd_color = NULL;
		} else if (_type == TimelineType::Hardware) {
			u.hw.device = strdup(task_or_device);
			u.hw.ring = strdup(process_or_ring);
		}
		type = _type;
		minimized = false;
		collapsed = type == TimelineType::Kernel;
		visible = true;
		sibling_timeline = NULL;
	}
	virtual ~Timeline() {
		if (type == TimelineType::Userspace) {
			free((void*)u.sw.drm_client_name);
			free((void*)u.sw.task_name);
			free((void*)u.sw.process_name);
		} else if (type == TimelineType::Kernel) {
			free((void*)u.kmd.task_name);
			free((void*)u.kmd.process_name);
		} else if (type == TimelineType::Hardware) {
			free((void*)u.hw.device);
			free((void*)u.hw.ring);
		}
	}

	int lane_count() const {
		if (context_max_sw_queued.empty())
			return 1;

		int lanes = 0;
		for (const auto &c: context_max_sw_queued) {
			lanes += 1 + c.second;
		}
		return lanes;
	}

	int lane_index(uint64_t context) const {
		if (collapsed)
			return 0;

		int lanes = 0;
		for (const auto &c: context_max_sw_queued) {
			if (c.first == context)
				return lanes;

			lanes += 1 + c.second;
		}

		return 0;
	}

	static Timeline *find_timeline_for_event(Timelines& timelines, const EventBase& bp, const DrmEvent& event, JSON_Array *drm_clients);
	static void sort_timelines(Timelines& timelines, const std::set<DrmSchedJob*> * selected_jobs);

	union {
		struct {
			char *task_name;
			char *process_name;
			uint64_t drm_client_id;
			char *drm_client_name;
		} sw;
		struct {
			char *device;
			char *ring;
		} hw;
		struct {
			char *task_name;
			char *process_name;
			uint64_t kmd_id;
			uint64_t context;
			ImColor *umd_color;
		} kmd;
	} u;
	TimelineType::Enum type;
	int pid, tgid;

	/* For each fence context, the max number of jobs queued during the capture. */
	std::map<uint64_t, int> context_max_sw_queued;

	/* Hack for sw rings. */
	Timeline *sibling_timeline;

	/* Updated each frame. */
	ImColor color;
	float draw_y;
	double usage;

	/* Presentation attributes. */
	bool visible;
	bool minimized; /* Draw each context (userspace) / app (kernel) on a single line. */
	bool collapsed; /* Draw everything on a single line. */
};

/* DrmSchedJob represents a single job running on the GPU.
 * It contains all the events related to this job. A job has a submit timeline (either Kernel
 * or Userspace) and an execution timeline (Hardware).
 */
struct DrmSchedJob {
	DrmSchedJob(const DrmEvent& event) : fence(event.u.drm_sched_job_queue.fence) {
		assert(event.is(EventType::DrmSchedJobQueue));
		add_event(event);
	}

	void add_event(const DrmEvent& evt) {
		events.push_back(evt);
	}

	void postprocess(const std::vector<DrmSchedJob*>& jobs, int job_index, double last_ts) {
		_start_ts = start_ts();
		_end_ts = end_ts();

		/* hw_exec_begin */
		int hw_job_count = 0;
		for (const auto& e: events) {
			if (e.is(EventType::DrmSchedJobRun)) {
				hw_job_count = e.u.drm_sched_job_run.hw_job_count;
				_hw_submit_ts = e.timestamp;
				break;
			}
		}

		if (hw_job_count > 1 || (execute_timeline && execute_timeline->sibling_timeline)) {
			const double this_hw_submit_ts = hw_submit_ts();

			/* Find the previous job on the same timeline. */
			for (int j = 0; j < 2; j++) {
				const auto* timeline = j ? execute_timeline->sibling_timeline : execute_timeline;
				if (!timeline)
					break;

				for (int i = job_index - 1; i >= 0; i--) {
					const DrmSchedJob *j = jobs[i];

					/* Only consider jobs running on the same hw queue. */
					if (timeline != j->execute_timeline)
						continue;

					/* Events that end before we start aren't relevant. */
					if (j->end_ts() <= this_hw_submit_ts)
						break;

					if (j == 0 || (j->end_ts() > _hw_exec_ts))
						_hw_exec_ts = j->end_ts();
				}
			}
		}

		lane_offset = events[0].u.drm_sched_job_queue.sw_job_count;

		/* Dependencies */
		for (auto& evt: events) {
			DmaFence *fence_to_add;
			if (evt.is(EventType::DrmSchedJobUnschedulable)) {
				fence_to_add = &evt.u.drm_sched_job_unschedulable.wait_fence;
			} else if (evt.is(EventType::DrmSchedJobAddDep))  {
				fence_to_add = &evt.u.drm_sched_job_add_dep.dep_fence;
				if (fence_to_add->context == 0 && fence_to_add->seqno == 0) {
					/* This is a stub fence, so there's no need to add it to the
					 * real dependencies.
					 */
					continue;
				}
			} else {
				continue;
			}

			/* Don't add duplicates. */
			bool found = false;
			for (auto &d: dependencies) {
				if (d->fence == *fence_to_add) {
					found = true;
					break;
				}
			}
			if (!found) {
				for (int i = job_index - 1; i >= 0; i--) {
					const DrmSchedJob *job = jobs[i];
					if (job->fence == *fence_to_add) {
						dependencies.push_back(job);
						break;
					}
				}
			}
		}

		const Event& last_evt = events.back();
		if (!last_evt.is(EventType::DrmSchedJobDone)) {
			_end_ts = last_ts;

			if (last_evt.is(EventType::DrmSchedJobRun)) {
				/* This job didn't complete. */
			} else {
				/* This job wasn't scheduled. */
				_hw_submit_ts = _hw_exec_ts = _end_ts;
			}
		}
	}

	/* Timestamps helpers. */
	double start_ts() const {
		if (_start_ts > 0) return _start_ts;
		return events[0].timestamp;
	}
	double end_ts() const {
		if (_end_ts > 0) return _end_ts;
		return events.back().timestamp;
	}
	double hw_submit_ts() const {
		if (_hw_submit_ts > 0) return _hw_submit_ts;
		for (const auto& e: events) {
			if (e.is(EventType::DrmSchedJobRun))
				return e.timestamp;
		}
		return -1;
	}
	double hw_exec_ts() const {
		if (_hw_exec_ts < 0)
			return hw_submit_ts();

		return _hw_exec_ts;
	}

	DmaFence fence;
	Timeline *submit_timeline = NULL;
	Timeline *execute_timeline = NULL;
	std::vector<DrmEvent> events;
	std::vector<const DrmSchedJob*> dependencies;

	int lane_offset = 0;
	double _start_ts = -1, _hw_submit_ts = -1, _hw_exec_ts = -1, _end_ts = -1;

	/* Updated each frame. */
	bool drawn = false;

	/* Presentation attributes. */
	bool move_to_top = false;
};

static bool
compare_timelines(const std::set<DrmSchedJob*> * selected_jobs, Timeline* q, Timeline* p) {
	if (q->type != p->type) {
		return q->type < p->type;
	} else if (q->type == TimelineType::Hardware) {
		if (str_is(p->u.hw.device, q->u.hw.device))
			return strcmp(p->u.hw.ring, q->u.hw.ring) > 0;
		return strcmp(p->u.hw.device, q->u.hw.device) > 0;
	} else if (q->type == TimelineType::Kernel) {
		if (q->u.kmd.kmd_id != p->u.kmd.kmd_id)
			return q->u.kmd.kmd_id < p->u.kmd.kmd_id;
		return q->u.kmd.context < p->u.kmd.context;
	}

	if (selected_jobs) {
		bool p_found = false, q_found = false;
		for (const auto *j: *selected_jobs) {
			if (j->submit_timeline == p && j->move_to_top)
				p_found = true;
			else if (j->submit_timeline == q && j->move_to_top)
				q_found = true;

			if (p_found && q_found)
				break;
		}
		if (p_found != q_found)
			return q_found;
	}

	if (q->tgid != p->tgid) {
		return q->tgid < p->tgid;
	}
	if (q->u.sw.drm_client_id != p->u.sw.drm_client_id)
		return q->u.sw.drm_client_id < p->u.sw.drm_client_id;
	return q->pid < p->pid;
}

Timeline *Timeline::find_timeline_for_event(Timelines& timelines, const EventBase& bp, const DrmEvent& event, JSON_Array *drm_clients) {
	TimelineType::Enum type;
	const char *task_or_device, *process_or_ring;
	uint64_t context, client_id;

	if (event.is(EventType::DrmSchedJobQueue)) {
		type = (event.u.drm_sched_job_queue.client_id >= (UINT64_MAX - 16) || event.u.drm_sched_job_queue.client_id == 0) ?
			TimelineType::Kernel: TimelineType::Userspace;
		task_or_device = bp.task;
		process_or_ring = bp.process;
		client_id = event.u.drm_sched_job_queue.client_id;
		context = event.u.drm_sched_job_queue.fence.context;
	} else if (event.is(EventType::DrmSchedJobRun)) {
		type = TimelineType::Hardware;
		task_or_device = event.u.drm_sched_job_run.device;
		process_or_ring = event.u.drm_sched_job_run.ring;
		client_id = context = 0;
		client_id = event.u.drm_sched_job_queue.client_id;
	} else {
		return NULL;
	}

	/* Try to find an existing timeline... */
	for (auto *t: timelines) {
		if (t->type != type)
			continue;

		if (t->type == TimelineType::Hardware) {
			/* For hardware timeline, we want to match the GPU and the ring. */
			if (str_is(task_or_device, t->u.hw.device) && str_is(process_or_ring, t->u.hw.ring))
				return t;
		} else if (t->type == TimelineType::Kernel) {
			/* For kernel timeline, we want to match the context, the source (kmd_id) and the thread id.
			 * During display, the timelines will be aggregated by kmd_id, but we still want to be able
			 * to show the details properly.
			 */
			if (t->u.kmd.context == context && t->u.kmd.kmd_id == client_id && t->tgid == bp.tgid)
				return t;
		} else {
			/* For userspace, we match by client_id since it's unique per-process. */
			if (t->u.sw.drm_client_id != client_id)
				continue;

			if (t->pid == bp.pid)
				return t;
		}
	}

	/* Allocate a new timeline. */
	Timeline *timeline = new Timeline(task_or_device, process_or_ring, type, bp.pid, bp.tgid, client_id, context, event.timestamp);

	if (timeline->type == TimelineType::Userspace && drm_clients) {
		for (size_t i = 0; i < json_array_get_count(drm_clients); i++) {
			JSON_Object *obj = json_object(json_array_get_value(drm_clients, i));
			if (json_object_get_number(obj, "id") == client_id) {
				const char *name = json_object_get_string(obj, "name");
				if (name && strcmp(name, "<unset>"))
					timeline->u.sw.drm_client_name = strdup(name);
				break;
			}
		}
	}

	/* Insert the new timeline sorted. */
	const auto n = timelines.size();
	size_t i;
	for (i = 0; i < n; i++) {
		if (compare_timelines(NULL, timeline, timelines[i])) {
			timelines.insert(timelines.begin() + i, timeline);
			break;
		}
	}
	if (i == n)
		timelines.push_back(timeline);

	return timeline;
}

/* We want the timelines sorted: Hardware, then Kernel, then Userspace. */
void Timeline::sort_timelines(Timelines& timelines, const std::set<DrmSchedJob*> * selected_jobs) {
	std::sort(timelines.begin(), timelines.end(), [selected_jobs](Timeline* q, Timeline* p) {
		return compare_timelines(selected_jobs, q, p);
	});
}

/* Support multiple captures in a single run. To achieve this, the Capture struct
 * holds a list of DrmSchedJob.
 */
struct Capture {
	Capture() {
		ts_shift = -1;
	}
	~Capture() {
		for (auto j: sched_jobs)
			delete j;
	}
	float start_ts() const {
		if (sched_jobs.empty())
			return -1;
		return sched_jobs.front()->start_ts();
	}
	float end_ts() const {
		if (sched_jobs.empty())
			return -1;
		return sched_jobs.back()->end_ts();
	}

	std::vector<DrmSchedJob*> sched_jobs;

	float ts_shift;
};

static
HighlightStatus::Enum get_hightlight_status(DrmSchedJob* active_graphics_job, DrmSchedJob* current, uint64_t seqno,
											double min_dur, double max_dur, enum JobDurationMode::Enum tab_mode) {
	/* If no active job, everyone is normal. */
	if (seqno && (seqno == current->events[0].u.drm_sched_job_queue.fence.seqno)) {
		return HighlightStatus::YesHighlight;
	}

	if (min_dur != max_dur) {
		double duration = get_job_duration(current, tab_mode);
		if (min_dur <= duration && duration <= max_dur)
		return HighlightStatus::YesHighlight;
	}

	if (active_graphics_job == NULL)
		return HighlightStatus::Normal;

	if (active_graphics_job == current)
		return HighlightStatus::Yes;

	/* Is 'current' a dependency of active_graphics_job */
	for (auto *d: active_graphics_job->dependencies) {
		if (d == current)
			return HighlightStatus::YesIndirect;
	}

	/* If 'active_graphics_job' a dep of 'current' */
	for (auto &d: current->dependencies) {
		if (d == active_graphics_job)
			return HighlightStatus::YesIndirect;
	}

	return HighlightStatus::Greyed;
}

static void draw_rectangle(const ImVec2& bl, const ImVec2& tr, const ImColor& c, const ImColor& c2, DrawStyle::Enum style) {
	ImGui::PushClipRect(
		ImVec2(bl.x, bl.y - 1),
		ImVec2(tr.x + 1, tr.y + 1), true);

	switch (style) {
		case DrawStyle::Fill:
			ImGui::GetWindowDrawList()->AddRectFilled(bl, tr, c);
			ImGui::GetWindowDrawList()->AddRect(bl, tr, c2, 0, 0, 2);
			break;
		case DrawStyle::Lines:
		case DrawStyle::Hatched: {
			ImGui::GetWindowDrawList()->AddRect(bl, tr, c);

			if (style == DrawStyle::Lines)
				break;

			if (c != c2)
				ImGui::GetWindowDrawList()->AddRect(bl, tr, c2, 0, 0, 2);

			ImGui::PushClipRect(bl, tr, true);
			const float padding = 3 * ImGui::GetStyle().FramePadding.x;
			float off = sin(IM_PI / 3) * (tr.y - bl.y);
			int steps = 1 + (tr.x - bl.x) / padding;
			for (int i = -1; i < steps; i++) {
				ImVec2 top(bl.x + i * padding, bl.y);
				ImVec2 bot(top.x + off, tr.y);
				ImGui::GetWindowDrawList()->AddLine(top, bot, c, 1);
			}
			ImGui::PopClipRect();
			break;
		}
		case DrawStyle::None:
			break;
	}
	ImGui::PopClipRect();
}

static void draw_triangle(ImVec2 pos, float radius, ImColor color, float rotation) {
	ImVec2 p1, p2, p3;
	float pi_o_2 =  IM_PI / 2;
	float _2pi_o_3 = 2 * IM_PI / 3;
	p1.x = pos.x + radius * cos(rotation + pi_o_2);
	p1.y = pos.y + radius * sin(rotation + pi_o_2);
	p2.x = pos.x + radius * cos(rotation + pi_o_2 + _2pi_o_3);
	p2.y = pos.y + radius * sin(rotation + pi_o_2 + _2pi_o_3);
	p3.x = pos.x + radius * cos(rotation + pi_o_2 - _2pi_o_3);
	p3.y = pos.y + radius * sin(rotation + pi_o_2 - _2pi_o_3);
	ImGui::GetWindowDrawList()->AddTriangleFilled(p1, p2, p3, color);
}

static bool draw_job(const char *name, const ImVec2& timeline_graph_pos, ImVec2 bl, ImVec2 tr, double dt, ImColor color,
					 ImColor color2, HighlightStatus::Enum status, DrawStyle::Enum style) {
	if (style == DrawStyle::None || tr.x < timeline_graph_pos.x)
		return false;

	if (style == DrawStyle::Fill && status == HighlightStatus::YesHighlight) {
		float r = (tr.y - bl.y) * 0.25;
		ImVec2 p1((bl.x + tr.x) * 0.5, bl.y);
		ImVec2 p2(p1.x - r, p1.y - 2 * r);
		ImVec2 p3(p1.x + r, p1.y - 2 * r);
		ImGui::GetWindowDrawList()->AddTriangleFilled(p1, p2, p3, ImColor(1.0f, 0.0, 0.0));
	}

	if (status == HighlightStatus::Greyed)
		color.Value.w = color2.Value.w = 0.15;
	else if (status == HighlightStatus::YesIndirect)
		color.Value.w = color2.Value.w = 0.75;

	if (tr.x - bl.x >= 2) {
		if (status == HighlightStatus::YesHighlight)
			color2 = ImColor(1.0f, 0.0, 0.0);
		else if (style == DrawStyle::Fill && color == color2)
			color2 = ImColor(color.Value.x * 0.7, color.Value.y * 0.7, color.Value.z * 0.7, color.Value.w);
		draw_rectangle(bl, tr, color, color2, style);
	} else {
		tr.x = bl.x;
		ImGui::GetWindowDrawList()->AddLine(bl, tr, color);

		return false;
	}

	char duration[64];
	sprintf(duration, "%7s: %.3f ms ", name, dt * 1000.0);
	float w = ImGui::CalcTextSize(duration).x;
	if (w < (tr.x - bl.x) && status != HighlightStatus::Greyed) {
		ImGui::GetWindowDrawList()->AddText(
			ImVec2(bl.x + (tr.x - bl.x) * 0.5 - w * 0.5, bl.y),
			(style == DrawStyle::Fill) ? IM_COL32_BLACK : IM_COL32_WHITE,
			duration);
	}

	return (tr.x - bl.x > 3) && ImGui::IsMouseHoveringRect(bl, tr);
}

static void draw_dependency(const DrawableArea& drawable_area,
							float from_base_y,
							float row_size, float row_spacing,
							const DrmSchedJob *dependency, const ImVec2& to_bl, const ImVec2& to_tr,
							bool direct_dep)
{
	const float tri_size = row_size * 0.25;

	ImVec2 bl, tr;
	compute_job_rect(drawable_area, from_base_y, row_size,
					 dependency->hw_exec_ts(), dependency->end_ts(), bl, tr);

	float to_w = to_bl.x - tr.x;

	ImVec2 p[4];
	p[0] = ImVec2(tr.x, bl.y);
	p[3] = ImVec2(to_bl.x, to_bl.y);

	if (bl.y == to_bl.y) {
		float y_off = row_size * 0.5;
		p[1] = ImVec2(p[0].x + std::min(row_size, to_w * 0.15f), p[0].y - y_off);
		p[2] = ImVec2(std::max(p[0].x + to_w * 0.85f, p[3].x - row_size), p[1].y - y_off);
	} else if (bl.y < to_bl.y) {
		p[1] = ImVec2(p[0].x + to_w * 0.25, p[0].y - row_spacing * 0.5);
		p[2] = ImVec2(p[0].x + to_w * 0.75, p[1].y);
	} else {
		p[1] = ImVec2(p[0].x + to_w * 0.25, p[0].y - row_spacing * 0.5);
		p[2] = ImVec2(p[0].x + to_w * 0.75, p[1].y);
		p[3].y = to_tr.y;
	}

	ImColor col(IM_COL32_WHITE);
	if (!direct_dep)
		col.Value.w = 0.5;
	ImGui::GetWindowDrawList()->AddBezierCubic(p[0], p[1], p[2], p[3], col, 2);
}

static DrmSchedJob *
find_matching_sched_job(const DrmEvent& event, std::vector<DrmSchedJob*>& sched_jobs) {
	const int n_jobs = (int)sched_jobs.size();
	if (n_jobs == 0)
		return NULL;

	const DmaFence& fence = event.get_job_fence();

	/* Match by job entity / id */
	for (int i = n_jobs - 1; i >= 0; i--) {
		const DrmEvent &test_sched_evt = sched_jobs[i]->events[0];

		if (test_sched_evt.get_job_fence() == fence)
			return sched_jobs[i];
	}
	return NULL;
}

static double parse_raw_event_buffer(void *raw_data, unsigned raw_data_size,
								     std::vector<DrmSchedJob*>& sched_jobs,
								     Timelines& timelines,
								     JSON_Array *names, JSON_Array *drm_clients) {
	double timestamp;

	EventBase bp = { };
	unsigned consumed = 0;
	double max_fence_duration = -1;
	char *input = static_cast<char*>(raw_data);

	while (consumed < raw_data_size) {
		/* Find the next event. */
		int n = Event::parse_raw_event_buffer(
			input + consumed, raw_data_size - consumed, names, &bp);

		if (n < 0)
			break;
		consumed += n;

		switch (bp.type) {
		case EventType::DrmSchedJobQueue:
		case EventType::DrmSchedJobRun:
		case EventType::DrmSchedJobDone:
		case EventType::DrmSchedJobUnschedulable:
		case EventType::DrmSchedJobAddDep:
			break;
		default:
			continue;
		}

		DrmEvent event(bp.type, bp.timestamp);

		/* Parse the fields. */
		consumed += Event::parse_event_fields(input + consumed, &event);

		/* If this a gpu_scheduler event (except drm_sched_job_done that is handled below)? */
		if (event.is(EventType::DrmSchedJobQueue) || event.is(EventType::DrmSchedJobUnschedulable) ||
			event.is(EventType::DrmSchedJobRun) || event.is(EventType::DrmSchedJobAddDep)) {
			/* drm_sched_job is the first event of every job. */
			if (event.is(EventType::DrmSchedJobQueue)) {
				TimelineType::Enum type = event.u.drm_sched_job_queue.client_id >= (UINT64_MAX - 16) ?
					TimelineType::Kernel : TimelineType::Userspace;
				uint64_t client_id_or_ctx = type == TimelineType::Userspace ?
					event.u.drm_sched_job_queue.client_id : event.u.drm_sched_job_queue.fence.context;

				DrmSchedJob *job = new DrmSchedJob(event);
				job->submit_timeline = Timeline::find_timeline_for_event(timelines, bp, event, drm_clients);

				sched_jobs.push_back(job);

				job->submit_timeline->context_max_sw_queued[event.u.drm_sched_job_queue.fence.context] = std::max(
					job->submit_timeline->context_max_sw_queued[event.u.drm_sched_job_queue.fence.context], event.u.drm_sched_job_queue.sw_job_count);
			} else {
				/* Other events are follow up events (except drm_sched_job_done) */
				DrmSchedJob *matching = find_matching_sched_job(event, sched_jobs);
				if (matching) {
					matching->add_event(event);

					if (event.is(EventType::DrmSchedJobRun)) {
						matching->execute_timeline = Timeline::find_timeline_for_event(timelines, bp, event, drm_clients);
					}
				} else {
					continue;
				}
			}
		} else if (event.is(EventType::DrmSchedJobDone)) {
			if (event.u.drm_sched_job_done.signaled.context == 0 && event.u.drm_sched_job_done.signaled.seqno == 0) {
				/* stub fence, ignore. */
				continue;
			}

			/* drm_sched_job_done is the last event. It's equivalent to dma_fence_signaled. */
			DrmSchedJob *matching = find_matching_sched_job(event, sched_jobs);
			if (matching) {
				matching->add_event(event);
				max_fence_duration = std::max(max_fence_duration, event.timestamp - matching->hw_submit_ts());
			}
		}
	}

	return max_fence_duration;
}

class ActivityPanel : public Panel {
public:
	ActivityPanel(struct umr_asic *asic) : Panel(asic), drawable_area(1) {
		last_reply_parsed = false;
		tracing_status = TracingStatus::Off;
		active_graphics_job = NULL;

		capture_rolling_window = 0;
		absolute_scanout_req = true;
		absolute_timestamps = true;
		highlight_by_duration.min = highlight_by_duration.max = 0;
		job_duration_tab.mode = JobDurationMode::HardwareExecution;
	}

	~ActivityPanel() {
		clear_state();
	}

	void clear_state() {
		for (auto t: timelines)
				delete t;
		for (auto c: captures)
			delete c;
		captures.clear();
		timelines.clear();
		selected_jobs.clear();
	}

	static void *post_process_capture_thread(void *data) {
		ActivityPanel *panel = static_cast<ActivityPanel*> (data);
		panel->post_process_capture(panel->captures.back());

		pthread_mutex_lock(&mtx);
		panel->tracing_status = TracingStatus::Off;
		pthread_mutex_unlock(&mtx);

		return NULL;
	}

	/* Called once at the end of the capture process. */
	void kick_off_post_processing() {
		tracing_status = TracingStatus::PostProcessing;
		cancel_post_processing = false;

		pthread_create(&post_processing_thread, NULL, post_process_capture_thread, this);
	}

	pthread_t post_processing_thread;
	bool cancel_post_processing;

	struct PostProcessArgs {
		ActivityPanel *panel;
		int first_job, last_job;
		double last_ts;
		Capture *capture;
	};

	static void *timeline_post_proc_dma_fences(void *in) {
		PostProcessArgs *args = static_cast<PostProcessArgs*>(in);

		for (int i = args->first_job; i <= args->last_job; i++) {
			Capture *capture = args->capture;
			capture->sched_jobs[i]->postprocess(capture->sched_jobs, i, args->last_ts);
		}

		delete args;
		return NULL;
	}

	void post_process_capture(Capture *capture) {
		for (auto *t: timelines) {
			if (t->type == TimelineType::Kernel) {
				/* Find out the matching userspace timeline. */
				for (auto *tl2: timelines) {
					if (tl2->type != TimelineType::Userspace)
						continue;
					if (tl2->tgid != t->tgid)
						continue;
					t->u.kmd.umd_color = &tl2->color;
					break;
				}
				continue;
			}
			if (t->type != TimelineType::Hardware)
				continue;
			if (t->sibling_timeline)
				continue;
			if (str_is(t->u.hw.ring, "gfx_low")) {
				for (auto *t2: timelines) {
					if (t2->type != t->type)
						continue;
					if (strstr(t2->u.hw.ring, "gfx_high")) {
						t2->sibling_timeline = t;
						t->sibling_timeline = t2;
						break;
					}
				}
			}
		}

		auto& sched_jobs = capture->sched_jobs;
		/* Sort jobs by completion timestamp. */
		std::sort(sched_jobs.begin(), sched_jobs.end(), [] (const DrmSchedJob *a, const DrmSchedJob *b) {
			return a->end_ts() < b->end_ts();
		});

		int job_count = sched_jobs.size();
		if (job_count) {
			int step = job_count / 10;
			std::vector<pthread_t> pp_thread;
			for (int i = 0; i < 10; i++) {
				PostProcessArgs *args = new PostProcessArgs();
				args->panel = this;
				args->first_job = i * step;
				args->last_job = std::min(args->first_job + step, job_count) - 1;
				args->last_ts = sched_jobs.back()->events.back().timestamp;
				args->capture = capture;

				pthread_t th;
				pthread_create(&th, NULL, timeline_post_proc_dma_fences, args);
				pp_thread.push_back(th);
			}

			for (pthread_t t: pp_thread) {
				pthread_join(t, NULL);
			}
		}

		std::map<Timeline*, double*> tl_lane_free_ts;
		for (auto *t: timelines) {
			double *d = new double[t->lane_count()];
			memset(d, 0, t->lane_count() * sizeof(double));
			tl_lane_free_ts[t] = d;
		}
		for (int i = 0; i < job_count; i++) {
			auto *job = sched_jobs[i];

			if (!job->submit_timeline)
				continue;

			auto* tl = job->submit_timeline;
			const size_t n_lanes_per_context = tl->context_max_sw_queued[job->fence.context] + 1;
			const int lane_idx = tl->lane_index(job->fence.context);
			const double start_ts = job->start_ts();

			double* lane_free_ts = tl_lane_free_ts[job->submit_timeline];

			for (size_t j = 0; j < n_lanes_per_context; j++) {
				int global_lane_idx = lane_idx + j;
				if (lane_free_ts[global_lane_idx] <= start_ts) {
					job->lane_offset = j;
					lane_free_ts[global_lane_idx] = job->hw_submit_ts();
					break;
				}
			}

			job->submit_timeline->context_max_sw_queued[job->fence.context] =
				std::max(job->submit_timeline->context_max_sw_queued[job->fence.context], job->lane_offset);
		}
		for (auto it: tl_lane_free_ts)
			delete[] it.second;
	}

	void stop_capture() {
		JSON_Value *req = json_value_init_object();
		json_object_set_string(json_object(req), "command", "tracing");
		json_object_set_number(json_object(req), "mode", 0);
		send_request(req);
		tracing_status = TracingStatus::Stopping;
	}

	void process_server_message(JSON_Object *response, void *raw_data, unsigned raw_data_size) {
		JSON_Value *error = json_object_get_value(response, "error");
		if (error) {
			tracing_status = TracingStatus::Error;
			return;
		}

		JSON_Object *request = json_object(json_object_get_value(response, "request"));
		JSON_Value *answer = json_object_get_value(response, "answer");
		const char *command = json_object_get_string(request, "command");

		if (str_is(command, "tracing")) {
			if (json_object_get_number(request, "mode") == 1) {
				/* This can happen when replaying a trace with multiple captures. */
				if (tracing_status == TracingStatus::PostProcessing) {
					cancel_post_processing = true;
					pthread_join(post_processing_thread, NULL);
				}
				captures.push_back(new Capture());

				tracing_status = TracingStatus::Running;
			} else {
				drawable_area.reset();
				kick_off_post_processing();
			}
		} else if (str_is(command, "read-trace-buffer")) {
			if (raw_data_size > 0) {
				assert(!captures.empty());
				auto *active_capture = captures.back();

				double max_fence_duration = parse_raw_event_buffer(
					raw_data, raw_data_size, active_capture->sched_jobs, timelines,
					json_object_get_array(json_object(answer), "names"),
					json_object_get_array(json_object(answer), "drm_clients"));

				if (tracing_status == TracingStatus::Running && autostop.fence.enabled && max_fence_duration > 0 &&
					max_fence_duration >= (autostop.fence.ms / 1000.0f)) {
					stop_capture();
				}

				if (!active_capture->sched_jobs.empty() && capture_rolling_window > 0) {
					int nsec = capture_rolling_window;
					auto& sched_jobs = captures.back()->sched_jobs;
					double last_ts = sched_jobs.back()->events.back().timestamp;
					int drop_count = 0;
					do {
						double first_ts = sched_jobs[drop_count]->events.front().timestamp;
						if ((last_ts - first_ts) > nsec) {
							delete sched_jobs[drop_count++];
						} else {
							break;
						}
					} while (true);
					if (drop_count > 0) {
						sched_jobs.erase(sched_jobs.begin(), sched_jobs.begin() + drop_count);
					}
				}
			}
			last_reply_parsed = true;
		}
	}

	bool display(float dt, const ImVec2& avail, bool can_send_request) {
		const float gui_scale = get_gui_scale();
		const float padding = ImGui::GetStyle().FramePadding.x;
		const float row_size = 15 * gui_scale;
		char label[256];

		if (tracing_status == TracingStatus::Error) {
			ImGui::Text("Error starting the traces (maybe your kernel is too old?)");
			return false;
		}

		if (tracing_status == TracingStatus::Running) {
			/* If the previous request was parsed, request new data. */
			if (last_reply_parsed && can_send_request) {
				JSON_Value *req = json_value_init_object();
				json_object_set_string(json_object(req), "command", "read-trace-buffer");
				send_request(req);
				last_reply_parsed = false;
			}
		}

		if (tracing_status == TracingStatus::Running ||
			tracing_status == TracingStatus::Stopping) {
			ImGui::BeginDisabled(tracing_status == TracingStatus::Stopping);
			if (ImGui::Button("Stop"))
				stop_capture();
			if (tracing_status == TracingStatus::Running && autostop.duration.enabled && !captures.empty()) {
				auto& sched_jobs = captures.back()->sched_jobs;

				if (!sched_jobs.empty() &&
						sched_jobs.back()->end_ts() - sched_jobs[0]->start_ts() >= autostop.duration.seconds) {
					stop_capture();
				}
			}
			ImGui::EndDisabled();
		} else if (tracing_status == TracingStatus::PostProcessing) {
			ImGui::BeginDisabled(cancel_post_processing);
			if (ImGui::Button("Processing")) {
				cancel_post_processing = true;
			}
			if (!cancel_post_processing && ImGui::IsItemHovered()) {
				ImGui::BeginTooltip();
				ImGui::Text("Click to stop post-processing");
				ImGui::EndTooltip();
			}
			ImGui::EndDisabled();
		} else {
			/* Capture options window. */
			if (ImGui::BeginPopupModal("Capture", NULL, ImGuiWindowFlags_AlwaysAutoResize | ImGuiWindowFlags_NoResize)) {
				static bool debug_mode, rolling_window, clear_data;

				ImGui::Text("Options");
				ImGui::Separator();

				#if DEBUG
				ImGui::Checkbox("Debug", &debug_mode);
				#endif
				ImGui::NewLine();

				ImGui::Text("Auto-stop when:");
				ImGui::Indent();
				ImGui::Checkbox("Total duration", &autostop.duration.enabled);
				ImGui::SameLine();
				ImGui::BeginDisabled(!autostop.duration.enabled);
				if (ImGui::InputInt("Duration (sec)", &autostop.duration.seconds, 0, 0) && autostop.duration.seconds < 1)
					autostop.duration.seconds = 1;
				ImGui::EndDisabled();
				ImGui::Checkbox("Fence duration exceeds", &autostop.fence.enabled);
				ImGui::SameLine();
				ImGui::BeginDisabled(!autostop.fence.enabled);
				if (ImGui::InputInt("Duration (ms)", &autostop.fence.ms, 0, 0) && autostop.fence.ms < 1)
					autostop.fence.ms = 1;
				ImGui::EndDisabled();
				ImGui::Unindent();

				ImGui::Checkbox("Drop older events", &rolling_window);
				ImGui::BeginDisabled(!rolling_window);
				if (capture_rolling_window <= 0)
					capture_rolling_window = 0;
				ImGui::InputInt("Rolling window duration (sec)", &capture_rolling_window, 0, 0);
				ImGui::EndDisabled();
				ImGui::BeginDisabled(!rolling_window);
				if (capture_rolling_window <= 0)
					capture_rolling_window = 0;
				ImGui::EndDisabled();

				if (!captures.empty()) {
					ImGui::Checkbox("Clear existing data", &clear_data);
				}

				ImGui::NewLine();
				if (ImGui::Button("  Go!  ")) {
					if (clear_data)
						clear_state();

					JSON_Value *req = json_value_init_object();
					json_object_set_string(json_object(req), "command", "tracing");
					json_object_set_boolean(json_object(req), "verbose", debug_mode);
					json_object_set_number(json_object(req), "mode", 1);
					send_request(req);
					last_reply_parsed = true;
					tracing_status = TracingStatus::Running;

					drawable_area.reset();
					ImGui::CloseCurrentPopup();
				}
				ImGui::SameLine();
				if (ImGui::Button("Cancel"))
					ImGui::CloseCurrentPopup();

				ImGui::EndPopup();
			}

			if (ImGui::Button("Capture")) {
				ImGui::OpenPopup("Capture");
			}
		}

		const float u64_input_size = ImGui::CalcTextSize("00000000000000000").x;
		double min_ts = FLT_MAX, max_ts = -1;
		for (auto &capture: captures) {
			if (capture->sched_jobs.empty())
				continue;
			min_ts = std::min(min_ts, capture->sched_jobs.front()->start_ts());
			max_ts = std::max(max_ts, capture->sched_jobs.back()->end_ts());
		}

		double total = min_ts < max_ts ? max_ts - min_ts : 0;
		const double displayed_duration = drawable_area.compute_visible_duration(total);

		float options_w = ImGui::CalcTextSize("Display Options").x + 2 * padding;
		float lookup_w = ImGui::CalcTextSize("Lookup").x + 2 * padding;
		float clear_w = ImGui::CalcTextSize("Clear").x + 2 * padding;
		float input_w = u64_input_size + 2 * padding;
		float seqno_w = ImGui::CalcTextSize("Seqno/job id:").x + 2 * padding;

		ImGui::SameLine();
		ImGui::SetCursorPosX(ImGui::GetCursorPosX() + (ImGui::GetContentRegionAvail().x -
			(lookup_w + seqno_w + input_w)) * 0.5);
		ImGui::Text("Sequence number:");
		ImGui::SameLine();
		ImGui::SetNextItemWidth(u64_input_size);
		ImGui::InputScalar("", ImGuiDataType_U64, &seqno_lookup, NULL, NULL, "%ld");
		ImGui::SameLine();
		if (seqno_lookup) {
			DrmSchedJob *lj = NULL;
			for (auto *capture: captures) {
				for (auto *job: capture->sched_jobs) {
					if (job->events[0].u.drm_sched_job_queue.fence.seqno == seqno_lookup) {
						lj = job;
						break;
					}
				}
			}
			ImGui::BeginDisabled(lj == NULL);
			if (ImGui::Button("Lookup"))
				drawable_area.center_on_timestamp(min_ts, total, lj->events[0].timestamp);
			ImGui::EndDisabled();
			ImGui::SameLine();
			if (ImGui::Button("Clear"))
				seqno_lookup = 0;
		}
		ImGui::SameLine();
		ImGui::SetCursorPosX(ImGui::GetCursorPosX() + ImGui::GetContentRegionAvail().x -
			(options_w));

		ImGui::SameLine();
		ImGui::Button("Timeline Visibility");
		if (ImGui::BeginPopupContextItem("Timeline Visibility", ImGuiPopupFlags_MouseButtonLeft)) {
			TimelineType::Enum prev = TimelineType::Userspace;
			for (auto *tl: timelines) {
				if (tl->type != prev) {
					prev = tl->type;
					switch (prev) {
						case TimelineType::Hardware:
							ImGui::TextUnformatted("Hardware");
							break;
						case TimelineType::Kernel:
							ImGui::TextUnformatted("Kernel");
							break;
						case TimelineType::Userspace:
							ImGui::TextUnformatted("Userspace");
							break;
					}
				}
				sprintf(label, "%s (%d)", tl->u.sw.process_name, tl->tgid);
				ImGui::PushID(tl);
				ImGui::Checkbox(label, &tl->visible);
				ImGui::PopID();
			}
			ImGui::EndPopup();
			drawable_area.mouse_interaction = false;
		} else {
			drawable_area.mouse_interaction = true;
		}
		ImGui::SameLine();
		ImGui::Button("Display Options");
		if (ImGui::BeginPopupContextItem("Options", ImGuiPopupFlags_MouseButtonLeft)) {
			ImGui::Checkbox("Abolute timestamps", &absolute_timestamps);
			ImGui::Checkbox("Show pid/tid", &show_tgid_pid);

			ImGui::EndPopup();
		}

		ImGui::Separator();

		if (captures.empty())
			return tracing_status != TracingStatus::Off;

		DrmSchedJob *new_active_job = NULL;

		ImGui::SetMouseCursor(ImGuiMouseCursor_Arrow);

		const float row_spacing = 12 * gui_scale;
		const float timeline_height = row_size + row_spacing;
		const float row_size_with_spacing = row_size + row_spacing * 0.15;

		/* Top-left position of the legend_pos. */
		float graph_v_spacing_top = ImGui::GetTextLineHeight();
		const ImVec2 legend_pos =
			ImVec2(ImGui::GetCursorScreenPos().x, ImGui::GetCursorScreenPos().y);

		const ImVec2 drawable_area_dim(avail.x, avail.y - legend_pos.y - ImGui::GetTextLineHeight());

		/* We want the graph to be scrollable independently. Using Begin instead of BeginChild
		 * also allow to resize it.
		 */
		ImGui::SetNextWindowPos(ImVec2(legend_pos.x, legend_pos.y));
		/* Only allow vertical resizing. */
		ImGui::SetNextWindowSizeConstraints(ImVec2(drawable_area_dim.x, 0), drawable_area_dim, NULL, NULL);
		ImGui::BeginChild("graph", ImVec2(0, 0), false, ImGuiWindowFlags_NoScrollbar);
		const float hw_queue_h_off = 2 * ImGui::CalcTextSize("G").x;
		ImVec2 cursor(legend_pos);
		Timeline *previous_tl = NULL;

		int proc_idx = 0, task_idx = 0;
		char *previous_hw_device = NULL;

		const ImColor hw_timeline_bg(255, 255, 255, 75);
		const ImColor kernel_timeline_bg(255, 255, 255, 125);
		const float triangle_size = ImGui::GetTextLineHeight() * 0.35;

		float first_tl_y[3] = { FLT_MAX, FLT_MAX, FLT_MAX };
		float last_tl_y[3] = { FLT_MAX, FLT_MAX, FLT_MAX };

		ImVec2 foldable_triangle_center;
		ImVec4 gpu_timelines_area(
			legend_pos.x + hw_queue_h_off, cursor.y,
			legend_pos.x + hw_queue_h_off + drawable_area_dim.x, -1);

		ImGui::PushClipRect(
			ImVec2(0, gpu_timelines_area.w),
			ImVec2(gpu_timelines_area.z, drawable_area.get_row_split_y()), true);

		job_duration_tab.max_job_duration = job_duration_tab.min_job_duration = 0;

		/* 1. Draw timeline legend */
		bool offset_applied = false;
		for (auto *tl: timelines) {
			tl->usage = 0;

			if (!tl->visible)
				continue;

			/* The hardware timelines are always displayed at the top,
			 * so apply scrolling offset to the first non-hw timeline.
			 */
			if (tl->type != TimelineType::Hardware && !offset_applied) {
				gpu_timelines_area.w = cursor.y;

				cursor.y -= drawable_area.get_top_row_y_offset();
				offset_applied = true;

				/* Clip to avoid drawing kernel/userspace timelines on top
				 * of hardware timelines.
				 */
				ImGui::PushClipRect(
					ImVec2(0, gpu_timelines_area.w),
					ImVec2(gpu_timelines_area.z, drawable_area.get_row_split_y()), true);
			}

			/* This is the base position for the timeline's legend.
			 * It may be shifted right later (eg: for per context display)
			 */
			ImVec2 pos(legend_pos.x + hw_queue_h_off, cursor.y);
			const float y = pos.y;
			/* We need to remember the width of the title, so we can reserve the appropriate
			 * amount of space for the legend to fit.
			 */
			ImVec2 title_size;

			tl->draw_y = 0;

			if (tl->type == TimelineType::Hardware) {
				bool new_instance = false;
				if (!previous_hw_device || strcmp(previous_hw_device, tl->u.hw.device) != 0) {
					new_instance = true;
					/* Add a bit of spacing to the previous device. */
					pos.y += row_size * 0.2 + graph_v_spacing_top;
					previous_hw_device = tl->u.hw.device;
				}

				/* Add a dark grey background. */
				ImGui::GetWindowDrawList()->AddRectFilled(
					ImVec2(legend_pos.x, pos.y - new_instance * graph_v_spacing_top),
					ImVec2(drawable_area_dim.x, pos.y + timeline_height),
					hw_timeline_bg);
				last_tl_y[tl->type] = pos.y + timeline_height;

				if (new_instance)
					ImGui::GetWindowDrawList()->AddText(ImVec2(legend_pos.x, pos.y - row_size), IM_COL32_BLACK, tl->u.hw.device);

				/* Title will be drawn later, including correct %. For now we're only
				 * interested in reserving enough space.
				 */
				sprintf(label, "%s 100 %%", tl->u.hw.ring);
				title_size = ImGui::CalcTextSize(label);
				title_size.x += 3 * padding;

				tl->draw_y = pos.y;
				first_tl_y[tl->type] = std::min(first_tl_y[tl->type], tl->draw_y);

				pos.y += timeline_height;
			} else {
				bool group_with_previous = false;
				/* Regroup timelines:
				 *   - userspace timelines are grouped by process (tgid)
				 *   - kernel timeline are grouped by (fake) client id (kid)
				 */
				if (previous_tl && tl->type == previous_tl->type) {
					if (tl->type == TimelineType::Userspace)
						group_with_previous = tl->tgid == previous_tl->tgid;
					else
						group_with_previous = tl->u.kmd.kmd_id == previous_tl->u.kmd.kmd_id;
				}

				if (!group_with_previous) {
					tl->draw_y = pos.y;
					const float tl_end_y = tl->draw_y + timeline_height;

					/* Assign a color to the timeline. */
					proc_idx++;
					task_idx = 0;
					tl->color = block_palette[(6 * (proc_idx % 6) + 5 - (task_idx % 6)) % ARRAY_SIZE(block_palette)];

					if (tl->type == TimelineType::Kernel) {
						if (tl->u.kmd.kmd_id == 0) {
							strcpy(label, "unknown");
						} else {
							uint64_t id = UINT64_MAX - tl->u.kmd.kmd_id;
							if (id < ARRAY_SIZE(kernel_id_job_names))
								strcpy(label, kernel_id_job_names[id]);
							else
								sprintf(label, "reason: 0x%lx", id);
						}
					} else if (show_tgid_pid)
						sprintf(label, "%s (%d)", tl->u.sw.process_name, tl->tgid);
					else
						sprintf(label, "%s", tl->u.sw.process_name);

					/* Draw a light grey background for kernel timelines. */
					if (tl->type == TimelineType::Kernel) {
						ImVec2 b(drawable_area_dim.x, tl_end_y);
						ImGui::GetWindowDrawList()->AddRectFilled(
							ImVec2(legend_pos.x, tl->draw_y), b,
							kernel_timeline_bg);
						last_tl_y[tl->type] = b.y;
					}

					ImGui::GetWindowDrawList()->AddText(ImVec2(pos.x + triangle_size + padding, pos.y),
														tl->color, label);
					title_size = ImGui::CalcTextSize(label);

					foldable_triangle_center = ImVec2(pos.x, pos.y + ImGui::GetTextLineHeight() * 0.5);
					draw_triangle(foldable_triangle_center, triangle_size,
								tl->color,
								tl->collapsed ? (-3.141592 / 2) : 0);
					if (!drawable_area.is_input_active() &&
							ImGui::IsMouseHoveringRect(pos, ImVec2(pos.x + title_size.x, pos.y + title_size.y))) {
						if (tl->collapsed || tl->lane_count() > 1) {
							ImGui::SetMouseCursor(ImGuiMouseCursor_Hand);
							if (ImGui::IsMouseClicked(ImGuiMouseButton_Left)) {
									tl->collapsed = !tl->collapsed;
							}
						}
					}

					previous_tl = tl;
					first_tl_y[tl->type] = std::min(first_tl_y[tl->type], tl->draw_y);
					pos.y = tl_end_y;
				} else {
					task_idx++;
					if (tl->type == TimelineType::Userspace)
						tl->color = block_palette[(6 * (proc_idx % 6) + 5 - (task_idx % 6)) % ARRAY_SIZE(block_palette)];
					else
						tl->color = block_palette[(6 * (proc_idx % 6) + 5) % ARRAY_SIZE(block_palette)];
					tl->collapsed = previous_tl->collapsed;
				}

				const float tl_ctx_start = pos.y;
				int n_rows = (tl->minimized || tl->collapsed) ? 1 : tl->lane_count();
				const size_t n_ctx = tl->context_max_sw_queued.size();

				/* For collapsed kernel timelines, we draw the events on the title line.
				 * In other situations, the timeline name acts as a title, and the events are
				 * drawn below.
				 */
				if (tl->type != TimelineType::Kernel || !tl->collapsed)
					tl->draw_y = pos.y;
				else
					tl->draw_y = previous_tl->draw_y;

				bool drawn = (pos.y <= avail.y);

				ImVec2 bg_start(legend_pos.x, pos.y);

				if (tl->type == TimelineType::Userspace) {
					if (show_tgid_pid)
						sprintf(label, "%s (%d)", tl->u.sw.task_name, tl->pid);
					else
						sprintf(label, "%s", (tl->type == TimelineType::Userspace && tl->u.sw.drm_client_name) ? tl->u.sw.drm_client_name : tl->u.sw.task_name);
					if (drawn)
						ImGui::GetWindowDrawList()->AddText(ImVec2(pos.x + 10 * gui_scale, pos.y), tl->color, label);
					title_size = ImGui::CalcTextSize(label);

					if (n_rows > 1 && n_ctx > 1) {
						pos.y += row_size_with_spacing;
						tl->draw_y += row_size_with_spacing;

						char ctx_label[64];
						/* Draw context ids. */
						if (drawn) {
							for (const auto &c: tl->context_max_sw_queued) {
								float y = pos.y + tl->lane_index(c.first) * row_size_with_spacing;
								sprintf(ctx_label, "  ctx: %ld", c.first);
								title_size.x = std::max(title_size.x, ImGui::CalcTextSize(ctx_label).x);
								ImGui::GetWindowDrawList()->AddText(ImVec2(pos.x + 10 * gui_scale, y), tl->color, ctx_label);
							}
						}
					}
				} else {
					if (drawn && !(tl->type == TimelineType::Kernel && tl->collapsed)) {
						if (show_tgid_pid)
							sprintf(label, "%s (%d)", tl->u.kmd.task_name, tl->tgid);
						else
							sprintf(label, "%s", tl->u.kmd.task_name);

						title_size.x = std::max(title_size.x, ImGui::CalcTextSize(label).x);

						ImGui::GetWindowDrawList()->AddText(ImVec2(pos.x + 10 * gui_scale, pos.y), tl->color, label);
					}
				}

				/* Reserve enough space for each row. */
				if (tl->type != TimelineType::Kernel || !tl->collapsed || previous_tl->type != TimelineType::Kernel)
					pos.y += n_rows * (row_size_with_spacing);

				title_size.x += 10 * gui_scale;

				ImVec2 a(pos.x, tl_ctx_start);
				ImVec2 b(pos.x + 10, pos.y);
				cursor.y = pos.y;

				if (!drawn)
					continue;

				ImVec2 points[] = {
					foldable_triangle_center,
					ImVec2(foldable_triangle_center.x, pos.y),
					ImVec2(foldable_triangle_center.x + 10 * gui_scale, pos.y)
				};
				ImGui::GetWindowDrawList()->AddPolyline(
					points, ARRAY_SIZE(points), tl->color, 0, 1);
				foldable_triangle_center.y = pos.y;

				if (tl->type == TimelineType::Kernel) {
					ImGui::GetWindowDrawList()->AddRectFilled(
						bg_start, ImVec2(drawable_area_dim.x, b.y),
						kernel_timeline_bg);
					last_tl_y[tl->type] = b.y;
				}
			}

			cursor.x = std::max(cursor.x, pos.x + title_size.x);
end:
			if (ImGui::IsMouseHoveringRect(ImVec2(gpu_timelines_area.x, tl->draw_y),
										   ImVec2(gpu_timelines_area.z, pos.y))) {
				if (ImGui::IsKeyReleased(SDL_GetScancodeFromKey(SDLK_h)))
					tl->visible = false;
				if (ImGui::IsKeyReleased(SDL_GetScancodeFromKey(SDLK_m)) ||
			        ImGui::IsMouseClicked(ImGuiMouseButton_Right)) {
					tl->minimized = !tl->minimized;
					if (!tl->minimized)
						tl->collapsed = false;
				}
			}
			cursor.y = pos.y;
		}

		const char *timeline_titles[] = { "GPU", "Kernel", "Applications" };
		for (int i = 2; i >= 0; i--) {
			ImVec2 p(legend_pos.x, first_tl_y[i]);
			const float th = ImGui::GetTextLineHeight();
			ImGui::PushClipRect(p, ImVec2(drawable_area_dim.x, last_tl_y[i]), true);
			for (int j = 0; j < strlen(timeline_titles[i]); j++) {
				ImGui::GetWindowDrawList()->AddText(p, IM_COL32_WHITE, &timeline_titles[i][j], &timeline_titles[i][j + 1]);
				p.y += th;
			}
			ImGui::PopClipRect();
			if (offset_applied && i == 1)
				ImGui::PopClipRect();
		}

		cursor.x += padding;

		/* Available space for the graph. */
		const ImVec2 timeline_graph_pos(cursor.x, legend_pos.y - row_size);
		const ImVec2 timeline_graph_dim(drawable_area_dim.x - cursor.x, drawable_area.get_top_row_height());

		double ts_shift = min_ts;
		captures[0]->ts_shift = ts_shift;

		const double scale = drawable_area.get_top_row_zoom() * timeline_graph_dim.x / total;
		const float graph_end_y = timeline_graph_pos.y + timeline_graph_dim.y;

		ImGui::PushClipRect(ImVec2(timeline_graph_pos.x, timeline_graph_pos.y), ImVec2(cursor.x + timeline_graph_dim.x, graph_end_y), true);

		struct {
			ImVec2 bl, tr;
		} submit, hw_wait, hw_exec;

		previous_tl = NULL;

		const bool show_connection = (1 / scale) < 0.0001;

		for (size_t i = 0; i < captures.size(); i++) {
			auto *capture = captures[i];
			if (i > 0 && capture->ts_shift < 0 && !capture->sched_jobs.empty()) {
				float ts = capture->start_ts();
				float prev_ts = captures[i - 1]->end_ts();

				if (ts - prev_ts > 1) {
					/* Draw over the time discontinuity region. */
					float x1 = drawable_area.timestamp_to_x(prev_ts + 0.1);
					float x2 = drawable_area.timestamp_to_x(prev_ts + 0.9);
					ImGui::GetWindowDrawList()->AddRectFilled(
						ImVec2(x1, timeline_graph_pos.y), ImVec2(x2, timeline_graph_pos.y + timeline_graph_dim.y),
						ImColor(ImGui::GetStyle().Colors[ImGuiCol_WindowBg]));

					ts_shift += (ts - prev_ts) - 1;
				}
				capture->ts_shift = ts_shift;
			}

			drawable_area.set_extra_timestamp_offset(capture->ts_shift);

			auto& sched_jobs = capture->sched_jobs;
			for (auto *job: sched_jobs) {
				job->drawn = false;
				if (!job->execute_timeline || !job->execute_timeline->visible)
					continue;

				if (!compute_job_rect(drawable_area, timeline_graph_pos.y, row_size,
									  job->start_ts(), job->end_ts(), submit.bl, submit.tr)) {
					/* If nothing from the job is visible, skip it. */
					continue;
				}

				const double hw_submit_ts = job->hw_submit_ts();
				const int context_lane_idx = job->submit_timeline->lane_index(job->fence.context);
				float submit_y = job->submit_timeline->draw_y +
					((job->submit_timeline->minimized || job->submit_timeline->collapsed) ? 0 : (context_lane_idx + job->lane_offset)) * (row_size_with_spacing);
				const float exec_y = job->execute_timeline ? job->execute_timeline->draw_y : 0;
				const ImColor color = job->submit_timeline->color;
				const ImColor color2 = (job->submit_timeline->type == TimelineType::Kernel && job->submit_timeline->u.kmd.umd_color) ?
					*job->submit_timeline->u.kmd.umd_color : color;

				HighlightStatus::Enum status = get_hightlight_status(active_graphics_job, job, seqno_lookup,
																	 highlight_by_duration.min, highlight_by_duration.max,
																	 job_duration_tab.mode);

				/* Jobs are drawn in 3 parts:
				 * - 1 box for submit, which starts at the ioctl and ends when the scheduler push the job to the hw
				 * - 1 box for hw wait (starts after the previous one, and ends when hw execution begins)
				 * - 1 box for hw execution (which ends when the fence is signaled)
				 */
				bool submit_visible = job->submit_timeline->visible;
				float this_row_size = row_size;

				/* Clip row_size if the timeline is at the top. */
				if (submit_y + row_size < gpu_timelines_area.w) {
					submit_visible = false;
				} else if (submit_y < gpu_timelines_area.w) {
					this_row_size = submit_y + row_size - gpu_timelines_area.w;
					submit_y = gpu_timelines_area.w;
				}

				submit_visible =
					submit_visible &&
					compute_job_rect(drawable_area, submit_y, this_row_size,
									 job->start_ts(), hw_submit_ts, submit.bl, submit.tr);

				/* Draw the submission / scheduler wait part. */
				if (submit_visible &&
						draw_job("sched wait", timeline_graph_pos, submit.bl, submit.tr, hw_submit_ts - job->start_ts(), color,
								 color2, status, DrawStyle::Hatched))
					new_active_job = job;

				/* Determine if we need to draw a "hardware wait" box. */
				bool did_hw_wait = hw_submit_ts != job->hw_exec_ts();
				if (did_hw_wait) {
					double exec_ts = job->hw_exec_ts();

					/* Pretend we didn't wait if it's not visible (2 pixels or less) */
					did_hw_wait = (exec_ts - hw_submit_ts) * scale > 2;

					if (did_hw_wait) {
						bool wait_visible =
							compute_job_rect(drawable_area, exec_y, row_size,
											 hw_submit_ts, exec_ts, hw_wait.bl, hw_wait.tr);

						if (wait_visible) {
							/* If the job is interesting the user, draw the hw wait area. */
							if (status >= HighlightStatus::YesIndirect)
								draw_job("hw wait", timeline_graph_pos, hw_wait.bl, hw_wait.tr, exec_ts - hw_submit_ts, color,
										 color2, status, DrawStyle::Hatched);
							/* Otherwise draw a single line. */
							else if (status != HighlightStatus::Greyed)
								ImGui::GetWindowDrawList()->AddLine(
									ImVec2(hw_wait.bl.x, hw_wait.tr.y - gui_scale - 1),
									ImVec2(hw_wait.tr.x, hw_wait.tr.y - gui_scale - 1),
									color, gui_scale);
						}
					}
				}

				if (!job->execute_timeline)
					continue;

				bool exec_visible = compute_job_rect(drawable_area, exec_y, row_size,
													 job->hw_exec_ts(), job->end_ts(), hw_exec.bl, hw_exec.tr);

				if (exec_visible) {
					double end = job->end_ts() - drawable_area.get_timestamp_offset();
					double sta = job->hw_exec_ts() - drawable_area.get_timestamp_offset();
					double job_duration = end - sta;
					/* Clip end based on the visible timespan. */
					if (end > displayed_duration)
						end = displayed_duration;

					if (sta <= end) {
						double d = std::max(0.0, end) - std::max(0.0, sta);

						double job_duration = get_job_duration(job, job_duration_tab.mode);
						if (job_duration < job_duration_tab.min_job_duration)
							job_duration_tab.min_job_duration = job_duration;
						if (job_duration > job_duration_tab.max_job_duration)
							job_duration_tab.max_job_duration = job_duration;
						job_duration_tab.n_visible_jobs++;
						job->drawn = true;

						job->execute_timeline->usage += d;

						/* Draw the hardware execution block. */
						if (draw_job("exec", timeline_graph_pos, hw_exec.bl, hw_exec.tr, d, color, color2,
									 status, DrawStyle::Fill))
							new_active_job = job;
					}
				}

				if (status != HighlightStatus::Greyed && show_connection && submit_visible && !job->submit_timeline->minimized) {
					/* If we didn't draw any hw_wait, copy the hw exec coords to the hw wait coords. */
					if (!did_hw_wait) {
						hw_wait.bl = hw_exec.bl;
						hw_wait.tr = hw_exec.tr;
					}

					/* Connect the submit and the exec parts, if we're zoomed in */
					ImColor c(color);
					c.Value.w = 0.4;
					ImGui::GetWindowDrawList()->AddLine(ImVec2(submit.tr.x, submit.bl.y), ImVec2(hw_wait.bl.x, hw_wait.tr.y),
														c, gui_scale);

					if (status >= HighlightStatus::YesIndirect) {
						for (const auto *dep: job->dependencies) {
							draw_dependency(drawable_area,
											dep->execute_timeline->draw_y,
											row_size, row_spacing,
											dep, hw_exec.bl, hw_exec.tr,
											status == HighlightStatus::Yes);
						}
					}
				}
			}
		}

		ImGui::PopClipRect();

		/* Draw hardware queue name + usage. */
		for (auto *tl: timelines) {
			if (!tl->visible)
				continue;
			if (tl->type != TimelineType::Hardware)
				break;

			/* Timeline name. */
			float x = legend_pos.x + hw_queue_h_off;
			ImGui::GetWindowDrawList()->AddText(ImVec2(x, tl->draw_y), IM_COL32_WHITE, tl->u.hw.ring);

			float usage = std::min(1.0, tl->usage / (displayed_duration - (timeline_graph_pos.x - legend_pos.x) / drawable_area.get_scale()));
			sprintf(label, "%3d %%", (int) (usage * 100));
			float w = ImGui::CalcTextSize(label).x + 3 * padding;
			/* Right aligned usage. */
			ImVec2 bb1(timeline_graph_pos.x - w, tl->draw_y);
			ImVec2 bb2(timeline_graph_pos.x - padding, tl->draw_y + ImGui::GetTextLineHeight());
			ImColor bg;
			if (usage < 0.25)
				bg = palette[7];
			else if (usage < 0.50)
				bg = palette[0];
			else if (usage < 0.75)
				bg = palette[1];
			else
				bg = palette[2];
			ImGui::GetWindowDrawList()->AddRectFilled(bb1, bb2, bg);
			ImGui::GetWindowDrawList()->AddText(
				ImVec2(timeline_graph_pos.x - w + padding, tl->draw_y), IM_COL32_BLACK, label);
		}

		ImGui::PopClipRect();

		float gradient_start_y = gpu_timelines_area.w;
		float gradient_end_y = gradient_start_y + 1.5f * row_size;
		ImGui::GetWindowDrawList()->AddRectFilledMultiColor(
			ImVec2(0.0, gradient_start_y),
			ImVec2(legend_pos.x + avail.x, gradient_end_y),
			hw_timeline_bg, hw_timeline_bg,
			ImColor(0.0f, 0.0f, 0.0f, 0.f), ImColor(0.0f, 0.0f, 0.0f, 0.f));
		ImGui::EndChild();

		drawable_area.update(legend_pos, drawable_area_dim, min_ts, total, absolute_timestamps);

		ImGui::SetCursorScreenPos(ImVec2(legend_pos.x, drawable_area.get_row_split_y()));
		ImGui::BeginChild("Dtails");
		ImGui::BeginTabBar("Details");
		if (ImGui::BeginTabItem("Jobs")) {
			for (auto it = selected_jobs.begin(); it != selected_jobs.end();) {
				auto *job = *it++;
				if (display_event_details_window(job, min_ts, false, avail, gpu_timelines_area, total)) {
					new_active_job = job;
				}
			}
			ImGui::EndTabItem();
		}
		if (ImGui::BeginTabItem("Timing Analysis")) {
			ImGui::TextUnformatted("Select job duration type:");
			ImGui::SameLine();
			ImGui::PushID("Job Durations Selection");
			if (ImGui::BeginCombo("", JobDurationMode::Str[job_duration_tab.mode])) {
				for (int i = 0; i < 4; i++) {
					if (ImGui::Selectable(JobDurationMode::Str[i], i == job_duration_tab.mode)) {
						job_duration_tab.mode = (JobDurationMode::Enum)i;
					}
				}
				ImGui::EndCombo();
			}
			ImGui::PopID();

			if (job_duration_tab.max_job_duration != job_duration_tab.min_job_duration)
				draw_job_duration(avail, hw_timeline_bg);
			else
				ImGui::TextUnformatted("Nothing to display");
			ImGui::EndTabItem();
		}
		if (ImGui::BeginTabItem("Scheduler")) {
			std::map<Timeline *, std::vector<DrmSchedJob *>> jobs_in_queue;
			/* Display the schedulers queues content for each hw queue at this timestamp. */
			double ts = drawable_area.get_mouse_over_ts(true);

			if (ts >= min_ts && ts <= max_ts) {
				for (auto *tl: timelines) {
					if (!tl->minimized && tl->type == TimelineType::Hardware)
						jobs_in_queue[tl] = std::vector<DrmSchedJob*>();
				}

				for (auto *capture: captures) {
					for (auto *job: capture->sched_jobs) {
						/* Skip unstarted jobs. */
						if (ts < job->start_ts())
							continue;
						/* Skip submitted jobs as well. */
						if (job->hw_submit_ts() < ts)
							continue;
						if (!job->execute_timeline || job->execute_timeline->minimized)
							continue;
						jobs_in_queue[job->execute_timeline].push_back(job);
					}
				}

				ImGui::Text("Queued jobs at %f s\n", ts);
				for (auto& it: jobs_in_queue) {
					if (!it.second.empty()) {
						std::set<uint64_t> contexts;
						ImGui::BeginTable("jj", 5, ImGuiTableFlags_Borders);
						ImGui::TableSetupColumn("Exec Timeline");
						ImGui::TableSetupColumn("Submit Timeline");
						ImGui::TableSetupColumn("Context");
						ImGui::TableSetupColumn("Seqno");
						ImGui::TableSetupColumn("Wait Time");
						ImGui::TableHeadersRow();

						ImGui::TableNextRow();
						ImGui::TableSetColumnIndex(0);
						ImGui::TextUnformatted(it.first->u.hw.ring);
						for (auto jt: it.second) {
							ImGui::BeginDisabled(contexts.find(jt->fence.context) != contexts.end());
							ImGui::TableSetColumnIndex(1);
							ImGui::TextUnformatted(jt->submit_timeline->u.sw.process_name);
							ImGui::TableSetColumnIndex(2);
							ImGui::Text("%lu", jt->fence.context);
							ImGui::TableSetColumnIndex(3);
							ImGui::Text("%lu", jt->fence.seqno);
							ImGui::TableSetColumnIndex(4);
							ImGui::Text("%f sec", ts - jt->start_ts());
							contexts.insert(jt->fence.context);
							ImGui::EndDisabled();
							ImGui::TableNextRow();
						}
						ImGui::EndTable();
					}
				}
			}
			ImGui::EndTabItem();
		}
		ImGui::EndTabBar();
		ImGui::EndChild();

		if (drawable_area.is_input_active()) {
			active_graphics_job = NULL;
		} else if (new_active_job != active_graphics_job) {
			active_graphics_job = new_active_job;
			return true;
		}

		if (active_graphics_job && selected_jobs.find(active_graphics_job) == selected_jobs.end()) {
			display_event_details_window(active_graphics_job, min_ts, true, avail, gpu_timelines_area, total);

			ImGui::SetMouseCursor(ImGuiMouseCursor_Hand);

			if (ImGui::IsMouseDoubleClicked(ImGuiMouseButton_Left)) {
				/* TODO */
			} else if (ImGui::IsMouseClicked(ImGuiMouseButton_Left)) {
				selected_jobs.insert(active_graphics_job);
			}
		}

		return tracing_status != TracingStatus::Off;
	}

private:
	void draw_job_duration(const ImVec2& avail,
						  const ImColor& hw_timeline_bg) {
		const float padding = ImGui::GetStyle().FramePadding.x;
		double max_job_duration, min_job_duration;

		if (job_duration_tab.max_job_duration < 0.001) {
			/* Use microseconds as the base unit */
			max_job_duration = ceil(job_duration_tab.max_job_duration * 1000000) * 0.000001;
			min_job_duration = floor(job_duration_tab.min_job_duration * 1000000) * 0.000001;
		} else {
			/* Use milliseconds as the base unit */
			max_job_duration = ceil(job_duration_tab.max_job_duration * 1000) * 0.001;
			min_job_duration = floor(job_duration_tab.min_job_duration * 1000) * 0.001;
		}

		ImVec2 g_st(ImGui::GetCursorScreenPos());
		/* Draw a histogram of the visible jobs duration. */
		const int n_buckets = std::max(5, std::min(20, (int)sqrt(job_duration_tab.n_visible_jobs)));
		const double bucket_width = (max_job_duration - min_job_duration) / n_buckets;

		std::map<Timeline*, int> tl_to_idx;

		for (auto *tl: timelines) {
			if (tl->type != TimelineType::Hardware)
				continue;
			if (!tl->visible)
				continue;
			tl_to_idx[tl] = tl_to_idx.size();
		}

		/* Draw one histogram, but each bucket will have a bar per queue. */
		const int n_hw_timelines = tl_to_idx.size();

		/* Store the number of submissions from each timeline in each bucket. */
		std::vector<std::map<Timeline *, int>> values(n_buckets * n_hw_timelines);
		int largest_value = 0;
		bool added_at_least_one = false;

		for (size_t i = 0; i < captures.size(); i++) {
			auto *capture = captures[i];
			if (capture->sched_jobs.empty())
				continue;
			auto& sched_jobs = capture->sched_jobs;
			for (auto *job: sched_jobs) {
				if (!job->execute_timeline || !job->execute_timeline->visible)
					continue;
				if (!job->drawn) {
					if (added_at_least_one)
						break;
					continue;
				}
				added_at_least_one = true;

				int idx = tl_to_idx[job->execute_timeline];

				double duration = get_job_duration(job, job_duration_tab.mode);
				int bucket = std::min(n_buckets - 1, (int)((duration - min_job_duration) / bucket_width));

				std::map<Timeline *, int>& c = values[n_hw_timelines * bucket + idx];
				if (c.find(job->submit_timeline) == c.end())
					c[job->submit_timeline] = 1;
				else
					c[job->submit_timeline] += 1;
			}
		}
		for (auto v: values) {
			int n = 0;
			for (auto it: v)
				n += it.second;
			largest_value = std::max(largest_value, n);
		}

		char label[128];
		const float available_space = avail.x - 2 * padding;
		/* Reserve space to draw n_buckets + 1 buckets and n_buckets spacing between them*/
		const float bucketw = available_space / ((n_buckets + 1) * n_hw_timelines + n_buckets * 0.3);
		const float full_bucket_w = bucketw * n_hw_timelines;
		const float bucket_spacing = bucketw * 0.3;
		const ImVec2 hist_leg_pos(g_st.x, g_st.y);
		const ImVec2 hist_leg_size(std::max(ImGui::CalcTextSize("< ms").x, full_bucket_w + bucket_spacing), g_st.y);
		const ImVec2 hist_pos(hist_leg_pos.x + hist_leg_size.x, hist_leg_pos.y + ImGui::GetTextLineHeight() + padding);
		const ImVec2 hist_size(avail.x - padding - hist_pos.x, drawable_area.get_bottom_row_height() - (hist_pos.y - drawable_area.get_row_split_y()));
		const float bottom = hist_pos.y + hist_size.y;

		ImGui::PushClipRect(hist_leg_pos, ImVec2(hist_pos.x + hist_size.x, avail.y), true);

		ImGui::GetWindowDrawList()->AddRectFilled(hist_pos, ImVec2(hist_pos.x + hist_size.x, bottom), hw_timeline_bg);
		int total_in_bucket = 0;

		highlight_by_duration.min = highlight_by_duration.max = 0;
		for (int i = 0; i < n_buckets; i++) {
			const float left = hist_pos.x + i * full_bucket_w  + i * bucket_spacing;
			const float right = left + full_bucket_w;

			ImVec2 bl(left, hist_pos.y), tr(right, bottom);
			ImGui::GetWindowDrawList()->AddRectFilled(bl, tr, hw_timeline_bg);

			if (ImGui::IsMouseHoveringRect(bl, tr)) {
				/* Highlight all jobs whose duration is in this interval. */
				highlight_by_duration.min = min_job_duration + i * bucket_width;
				highlight_by_duration.max = highlight_by_duration.min + bucket_width;
			}

			int n_in_bucket = 0;
			for (int j = 0; j < n_hw_timelines; j++) {
				float bx = left + j * bucketw;

				std::map<Timeline *, int>& v = values[i * n_hw_timelines + j];

				float y = bottom;
				for (auto it: v) {
					float dy = it.second / (float)largest_value;
					float by = std::max(1.0f, dy * hist_size.y);

					if (y >= hist_pos.y) {
						ImGui::GetWindowDrawList()->AddRectFilled(
							ImVec2(bx, y - by),
							ImVec2(bx + bucketw, y),
							it.first->color);
					}
					y -= by;

					n_in_bucket += it.second;
				}
			}
			total_in_bucket += n_in_bucket;
			if (n_in_bucket) {
				sprintf(label, "%d", n_in_bucket);
				ImGui::GetWindowDrawList()->AddText(
					ImVec2((left + right) * 0.5 - ImGui::CalcTextSize(label).x * 0.5, hist_leg_pos.y), IM_COL32_WHITE, label);
			}

			if (max_job_duration < 0.001)
				sprintf(label, "%.1f",
						(min_job_duration + bucket_width * (i + 1)) * 1000000.0);
			else
				sprintf(label, "%.1f",
					(min_job_duration + bucket_width * (i + 1)) * 1000.0);

			float tw = ImGui::CalcTextSize(label).x;
			ImGui::GetWindowDrawList()->AddText(
				ImVec2(left + n_hw_timelines * 0.5 * bucketw - tw * .5,
					bottom),
					IM_COL32_WHITE, label);
		}

		/* Draw legend. */
		ImGui::GetWindowDrawList()->AddRectFilled(ImVec2(hist_leg_pos.x, hist_pos.y), ImVec2(hist_leg_pos.x + full_bucket_w, bottom), hw_timeline_bg);
		for (auto it: tl_to_idx) {
			float left = hist_leg_pos.x + it.second * bucketw;
			const char *name = it.first->u.hw.ring;
			float x = left + bucketw * 0.5 - ImGui::CalcTextSize("a").x * 0.5;
			float y = hist_pos.y + hist_size.y - ImGui::GetTextLineHeight();
			for (int i = (int)strlen(name) - 1; i >= 0 ; i--) {
				ImGui::GetWindowDrawList()->AddText(ImVec2(x, y), IM_COL32_WHITE, &name[i], &name[i + 1]);
				y -= ImGui::GetTextLineHeight();
			}
		}
		ImGui::GetWindowDrawList()->AddText(
			ImVec2(hist_leg_pos.x + full_bucket_w * 0.5 - ImGui::CalcTextSize("< us").x * 0.5, hist_leg_pos.y),
			IM_COL32_WHITE, "count");
		ImGui::GetWindowDrawList()->AddText(
			ImVec2(hist_leg_pos.x + full_bucket_w * 0.5 - ImGui::CalcTextSize("< us").x * 0.5, bottom),
			IM_COL32_WHITE, (max_job_duration < 0.001) ? "< us" : "< ms");

		ImGui::PopClipRect();
	}

	bool display_event_details_window(DrmSchedJob* job, float min_ts, bool tooltip, const ImVec2& avail,
									  const ImVec4& gpu_timelines_area, double total_duration) {
		ImVec2 top;

		ImGui::PushID(job);
		if (tooltip) {
			ImGui::BeginTooltip();
		} else {
			ImGui::Separator();
			top = ImGui::GetCursorScreenPos();
			ImGui::Indent();
		}

		if (job->submit_timeline->type == TimelineType::Kernel) {
			const ImColor color2 = job->submit_timeline->u.kmd.umd_color ?
				*job->submit_timeline->u.kmd.umd_color : job->submit_timeline->color;
			ImGui::Text("#888888Timelines: #888888submit: #%x%s / #%x%s (%d)",
				COLOR_TO_HEX(job->submit_timeline->color),
				job->submit_timeline->u.kmd.kmd_id == 0 ?
					"unknown" : kernel_id_job_names[UINT64_MAX - job->submit_timeline->u.kmd.kmd_id],
				COLOR_TO_HEX(color2),
				job->submit_timeline->u.sw.task_name,
				job->submit_timeline->tgid);
		} else {
			ImGui::Text("#888888Timelines: #888888submit: #%x%s (%d)",
				COLOR_TO_HEX(job->submit_timeline->color),
				job->submit_timeline->u.sw.task_name,
				job->submit_timeline->tgid);
		}
		if (ImGui::IsItemHovered()) {
			ImGui::SetMouseCursor(ImGuiMouseCursor_Hand);
			if (ImGui::IsMouseClicked(ImGuiMouseButton_Left)) {
				job->submit_timeline->minimized = false;
				drawable_area.top_row_y_offset += job->submit_timeline->draw_y - (avail.y - gpu_timelines_area.y) * 0.5;
				if (drawable_area.top_row_y_offset < 0)
					drawable_area.top_row_y_offset = 0;
				drawable_area.center_on_timestamp(min_ts, total_duration, job->start_ts());
			}
		}
		ImGui::SameLine();
		ImGui::Text("#888888exec: %s (%s)",
			job->execute_timeline ? job->execute_timeline->u.hw.ring : "n/a",
			job->execute_timeline ? job->execute_timeline->u.hw.device : "n/a");
		if (ImGui::IsItemHovered()) {
			ImGui::SetMouseCursor(ImGuiMouseCursor_Hand);
			if (ImGui::IsMouseClicked(ImGuiMouseButton_Left)) {
				job->execute_timeline->minimized = false;
				drawable_area.top_row_y_offset += job->execute_timeline->draw_y - (avail.y - gpu_timelines_area.y) * 0.5;
				if (drawable_area.top_row_y_offset < 0)
					drawable_area.top_row_y_offset = 0;
				drawable_area.center_on_timestamp(min_ts, total_duration, job->hw_exec_ts());
			}
		}

		if (!tooltip) {
			const char *lbla = "Remove";
			float w = ImGui::CalcTextSize(lbla).x + 2 * ImGui::GetStyle().ItemInnerSpacing.x + ImGui::GetFrameHeight();
			ImVec2 p = ImGui::GetCursorScreenPos();
			ImGui::SetCursorScreenPos(ImVec2(top.x + avail.x - w, top.y));
			if (ImGui::Button(lbla)) {
				selected_jobs.erase(job);
				Timeline::sort_timelines(timelines, &selected_jobs);
			}

			const char *lbl = "Move Timeline to Top";
			ImGui::PushStyleColor(ImGuiCol_Button, job->move_to_top ?
					ImGui::GetStyleColorVec4(ImGuiCol_ButtonHovered) : ImGui::GetStyleColorVec4(ImGuiCol_Button));

			w = ImGui::CalcTextSize(lbl).x + 2 * ImGui::GetStyle().ItemInnerSpacing.x + ImGui::GetFrameHeight();
			p = ImGui::GetCursorScreenPos();
			ImGui::SetCursorScreenPos(ImVec2(top.x + avail.x - w, top.y + ImGui::GetTextLineHeight() + 3 * ImGui::GetStyle().FramePadding.y));
			if (ImGui::Button(lbl)) {
				job->move_to_top = !job->move_to_top;
				Timeline::sort_timelines(timelines, &selected_jobs);
			}
			ImGui::PopStyleColor();

			ImGui::SetCursorScreenPos(p);
		}

		ImGui::Text("#888888Timestamp: %.5f s", job->start_ts());
		ImGui::Text("#888888Duration: %.5f s", job->end_ts() - job->hw_exec_ts());
		ImGui::Text("#888888Fence: context=%lu seqno=%lu", job->fence.context, job->fence.seqno);

		uint64_t id = job->events[0].u.drm_sched_job_queue.client_id;
		switch (job->submit_timeline->type) {
			case TimelineType::Userspace:
				ImGui::Text("#888888ClientID: %ld", id);
				break;
			case TimelineType::Kernel:
				id = UINT64_MAX - id;
				if (id < ARRAY_SIZE(kernel_id_job_names))
					ImGui::Text("#888888Source: #%x%s", COLOR_TO_HEX(job->submit_timeline->color), kernel_id_job_names[id]);
				break;
			default:
				break;
		}

		if (!job->dependencies.empty()) {
			bool show_deps = true;
			if (tooltip) {
				ImGui::Separator();
				ImGui::Text("Dependencies");
			} else {
				show_deps = ImGui::TreeNode("Dependencies");
			}

			if (show_deps && ImGui::BeginTable("fences", 5, ImGuiTableFlags_Borders)) {
				ImGui::TableSetupColumn("Submit Timeline");
				ImGui::TableSetupColumn("Exec Timeline");
				ImGui::TableSetupColumn("Context");
				ImGui::TableSetupColumn("Seqno");
				ImGui::TableSetupColumn("Signaled");
				ImGui::TableHeadersRow();
				add_fence_dependencies_to_event_details_table(
					job, job->dependencies);
				ImGui::EndTable();

				if (!tooltip)
					ImGui::TreePop();
			}
		}

		bool show_events = true;
		if (tooltip) {
			ImGui::Separator();
			ImGui::Text("Events");
		} else {
			show_events = ImGui::TreeNode("Events");
		}
		if (show_events && ImGui::BeginTable("events", 4, ImGuiTableFlags_Borders)) {
			ImGui::TableSetupColumn("Timestamp");
			ImGui::TableSetupColumn("Name");
			ImGui::TableSetupColumn("dt");
			ImGui::TableSetupColumn("Details");
			ImGui::TableHeadersRow();

			for (size_t i = 0; i < job->events.size(); i++) {
				const auto& evt = job->events[i];

				ImGui::TableNextRow();
				ImGui::TableSetColumnIndex(0);

				if (absolute_timestamps)
					ImGui::Text("%f", evt.timestamp);
				else
					ImGui::Text("%f", evt.timestamp - min_ts);
				ImGui::TableSetColumnIndex(1);
				ImGui::Text("%s", EventType::to_str(evt.type));
				if (i > 0) {
					ImGui::TableSetColumnIndex(2);
					float dt_sec = evt.timestamp - job->events[i - 1].timestamp;
					if (dt_sec < 0.001)
						ImGui::Text(" + %.3f us", dt_sec * 1000000.0);
					else if (dt_sec < 1)
						ImGui::Text(" + %.3f ms", dt_sec * 1000.0);
					else
						ImGui::Text(" + %.3f s", dt_sec);
				}
				ImGui::TableSetColumnIndex(3);
				if (evt.is(EventType::DrmSchedJobQueue)) {
					ImGui::Text("Jobs in entity queue: %d",
						evt.u.drm_sched_job_queue.sw_job_count);
				} else if (evt.is(EventType::DrmSchedJobRun)) {
					ImGui::Text("Jobs in hw queue: %d",
						evt.u.drm_sched_job_run.hw_job_count - 1);
				} else if (evt.is(EventType::DrmSchedJobUnschedulable)) {
					ImGui::Text("waits for context:%ld seqno:%ld", evt.u.drm_sched_job_unschedulable.wait_fence.context, evt.u.drm_sched_job_unschedulable.wait_fence.seqno);
				} else if (evt.is(EventType::DrmSchedJobAddDep)) {
					ImGui::Text("waits for context:%ld seqno:%ld", evt.u.drm_sched_job_add_dep.dep_fence.context, evt.u.drm_sched_job_add_dep.dep_fence.seqno);
				}
			}
			ImGui::EndTable();
			if (!tooltip)
				ImGui::TreePop();
		}

		if (tooltip) {
			ImGui::EndTooltip();
			ImGui::PopID();
			return false;
		} else {
			ImGui::Unindent();
			ImGui::PopID();

			ImVec2 bot = ImGui::GetCursorScreenPos();
			ImGui::GetWindowDrawList()->AddRectFilled(top, ImVec2(top.x + 5, bot.y), job->submit_timeline->color);
			return ImGui::IsMouseHoveringRect(top, ImVec2(top.x + avail.x, bot.y));
		}
	}

	void add_fence_dependencies_to_event_details_table(DrmSchedJob *job, std::vector<const DrmSchedJob *>& dependencies) {
		for (auto &dep: dependencies) {
			ImGui::TableNextRow();
			ImGui::TableSetColumnIndex(0);
			ImGui::Text("%s", dep->submit_timeline->u.sw.task_name);
			ImGui::TableSetColumnIndex(1);
			ImGui::Text("%s", dep->execute_timeline->u.hw.ring);
			ImGui::TableSetColumnIndex(2);
			ImGui::Text("%ld", dep->fence.context);
			ImGui::TableSetColumnIndex(3);
			ImGui::Text("%ld", (uint64_t)dep->fence.seqno);
			ImGui::TableSetColumnIndex(4);
			float signaled_ts = dep->end_ts();
			float delta_ms = (job->start_ts() - signaled_ts) * 1000;
			if (delta_ms > 0)
				ImGui::Text("%.3f ms before ioctl", delta_ms);
			else
				ImGui::Text("%.3f ms after ioctl", -delta_ms);
		}
	}

	std::vector<Capture*> captures;

	double latest_timestamp;
	bool last_reply_parsed;

	TracingStatus::Enum tracing_status;

	bool show_tgid_pid = false;

	struct {
		struct {
			bool enabled = false;
			int seconds = 3;
		} duration;
		struct {
			bool enabled = false;
			int ms = 1000;
		} fence;
	} autostop;
	int capture_rolling_window = 0;

	uint64_t seqno_lookup = 0;
	struct {
		double min, max;
	} highlight_by_duration;

	struct {
		double min_job_duration = FLT_MAX, max_job_duration = 0;
		int n_visible_jobs = 0;
		enum JobDurationMode::Enum mode;
	} job_duration_tab;

	bool absolute_timestamps;
	bool absolute_scanout_req;

	Timelines timelines;
	std::set<DrmSchedJob*> selected_jobs;
	DrmSchedJob *active_graphics_job;

	DrawableArea drawable_area;
};


/* Helpers */
static bool compute_job_rect(const DrawableArea& drawable_area,
							 float base_y, float row_size,
							 double start, double end, ImVec2& bl, ImVec2& tr) {
	bl = ImVec2(drawable_area.timestamp_to_x(start), base_y);
	tr = ImVec2(drawable_area.timestamp_to_x(end), base_y + row_size);

	ImVec4 extent(drawable_area.get_extent());

	if (tr.x < extent.x || extent.z < bl.x)
		return false;

	if (tr.y < extent.y || bl.y > extent.w)
		return false;

	/* Clip */
	bl.x = std::max(bl.x, drawable_area.get_position().x - 5);
	tr.x = std::min(tr.x, drawable_area.get_position().x + drawable_area.get_size().x + 5);

	return true;
}

static double get_job_duration(DrmSchedJob *job, enum JobDurationMode::Enum mode) {
	switch (mode) {
		case JobDurationMode::HardwareSubmit:
			return job->end_ts() - job->hw_submit_ts();
		case JobDurationMode::Submit:
			return job->end_ts() - job->start_ts();
		case JobDurationMode::WaitBeforeSubmit:
			return job->hw_submit_ts() - job->start_ts();
		case JobDurationMode::HardwareExecution:
		default:
			return job->end_ts() - job->hw_exec_ts();
	}
}
