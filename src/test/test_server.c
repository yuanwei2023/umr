#include "test_framework.h"
#include "parson.h"

extern void parse_sysfs_clock_file(char *content, int *min, int *max);
extern JSON_Value *compare_fence_infos(const char *before, const char *after);
extern JSON_Array *parse_vm_info(const char *content);
extern JSON_Array *parse_kms_framebuffer_sysfs_file(const char *content);
extern JSON_Object *parse_kms_state_sysfs_file(const char *content);

enum TEST_RESULT test_parse_sysfs_clock_file()
{
    char *content =
        "0: 500Mhz \n"
        "1: 0Mhz *\n"
        "2: 2575Mhz \n";

    int min, max;
    parse_sysfs_clock_file(content, &min, &max);
    ASSERT_EQ(0, min);
    ASSERT_EQ(2575, max);
    return TEST_SUCCESS;
}

enum TEST_RESULT test_parse_fence_info()
{
    const char *before =
        "--- ring 0 (gfx_0.0.0) ---\n"
        "Last signaled fence          0x000e67ee\n"
        "Last emitted                 0x000e67ee\n"
        "Last signaled trailing fence 0x00000000\n"
        "Last emitted                 0x00000000\n"
        "Last preempted               0x00000000\n"
        "Last reset                   0x00000000\n"
        "Last both                    0x00000000\n"
        "--- ring 1 (comp_1.0.0) ---\n"
        "Last signaled fence          0x00000002\n"
        "Last emitted                 0x00000002\n"
        "--- ring 2 (comp_1.1.0) ---\n"
        "Last signaled fence          0x00000012\n"
        "Last emitted                 0x00000012\n";

    const char *after =
        "--- ring 0 (gfx_0.0.0) ---\n"
        "Last signaled fence          0x000f67ee\n"
        "Last emitted                 0x000f67ee\n"
        "Last signaled trailing fence 0x00000000\n"
        "Last emitted                 0x00000000\n"
        "Last preempted               0x00000000\n"
        "Last reset                   0x00000000\n"
        "Last both                    0x00000000\n"
        "--- ring 1 (comp_1.0.0) ---\n"
        "Last signaled fence          0x00000010\n"
        "Last emitted                 0x00000010\n"
        "--- ring 2 (comp_1.1.0) ---\n"
        "Last signaled fence          0x00000098\n"
        "Last emitted                 0x00000098\n";

    const char *names[] = { "gfx_0.0.0", "comp_1.0.0", "comp_1.1.0" };
    const int deltas[]  = { 0x000f67ee - 0x000e67ee, 0x00000010 - 0x00000002, 0x00000098 -  0x00000012 };

    JSON_Value *fences = compare_fence_infos(before, after);
    ASSERT_EQ(json_array_get_count(json_array(fences)), 3);
    for (int i = 0; i < 3; i++) {
        JSON_Object *v = json_object(json_array_get_value(json_array(fences), i));
        ASSERT_STR_EQ(json_object_get_string(v, "name"), names[i]);
        ASSERT_EQ(json_object_get_number(v, "delta"), deltas[i]);
    }
    json_value_free(fences);
    return TEST_SUCCESS;
}

enum TEST_RESULT test_parse_vm_info()
{
    const char *content =
        "pid:0\tProcess: ----------\n"
        "\tIdle BOs:\n"
        "\tEvicted BOs:\n"
        "\t\t0x00000000:         4096 byte  GTT CPU_GTT_USWC VRAM_CONTIGUOUS\n"
        "\tRelocated BOs:\n"
        "\tMoved BOs:\n"
        "\tInvalidated BOs:\n"
        "\tDone BOs:\n"
        "\tTotal idle size:                   0\tobjs:\t0\n"
        "\tTotal evicted size:             4096\tobjs:\t1\n"
        "\tTotal relocated size:              0\tobjs:\t0\n"
        "\tTotal moved size:                  0\tobjs:\t0\n"
        "\tTotal invalidated size:            0\tobjs:\t0\n"
        "\tTotal done size:                   0\tobjs:\t0\n"
        "pid:3140\tProcess:GeckoMain ----------\n"
        "\tIdle BOs:\n"
        "\t\t0x00000000:         4096 byte VRAM CPU_GTT_USWC VRAM_CONTIGUOUS\n"
        "\t\t0x00000001:         4096 byte   GTT exported as 000000000a49a273 NO_CPU_ACCESS CPU_GTT_USWC\n"
        "\tEvicted BOs:\n"
        "\tRelocated BOs:\n"
        "\tMoved BOs:\n"
        "\tInvalidated BOs:\n"
        "\tDone BOs:\n"
        "\t\t0x00000001:      2097152 byte  GTT CPU_ACCESS_REQUIRED CPU_GTT_USWC\n"
        "\tTotal idle size:                8192\tobjs:\t2\n"
        "\tTotal evicted size:                0\tobjs:\t0\n"
        "\tTotal relocated size:              0\tobjs:\t0\n"
        "\tTotal moved size:                  0\tobjs:\t0\n"
        "\tTotal invalidated size:            0\tobjs:\t0\n"
        "\tTotal done size:             2097152\tobjs:\t1\n";

    const char *names[] = { "", "GeckoMain" };
    int pids[] = { 0, 3140 };
    JSON_Array *out = parse_vm_info(content);
    ASSERT_EQ(json_array_get_count(out), 2);
    for (int i = 0; i < 2; i++) {
        JSON_Object *v = json_object(json_array_get_value(out, i));
        ASSERT_STR_EQ(json_object_get_string(v, "name"), names[i]);
        ASSERT_EQ(json_object_get_number(v, "pid"), pids[i]);
        ASSERT_EQ(json_array_get_count(json_object_get_array(v, "Relocated")), 0);
        ASSERT_EQ(json_array_get_count(json_object_get_array(v, "Moved")), 0);
        ASSERT_EQ(json_array_get_count(json_object_get_array(v, "Invalidated")), 0);
        if (i == 0) {
            ASSERT_EQ(json_array_get_count(json_object_get_array(v, "Done")), 0);
            ASSERT_EQ(json_array_get_count(json_object_get_array(v, "Idle")), 0);
            ASSERT_EQ(json_array_get_count(json_object_get_array(v, "Evicted")), 1);
            ASSERT_EQ(json_object_get_number(v, "total"), 4096);
        } else {
            ASSERT_EQ(json_array_get_count(json_object_get_array(v, "Evicted")), 0);
            ASSERT_EQ(json_array_get_count(json_object_get_array(v, "Done")), 1);
            ASSERT_EQ(json_array_get_count(json_object_get_array(v, "Idle")), 2);
            ASSERT_EQ(json_object_get_number(v, "total"), 2105344);
            JSON_Value *bo = json_array_get_value(json_object_get_array(v, "Idle"), 1);
            JSON_Array *attr = json_object_get_array(json_object(bo), "attributes");
            ASSERT_EQ(json_array_get_count(attr), 4);
            const char *exp[] = {
                "GTT",
                "exported as 000000000a49a273",
                "NO_CPU_ACCESS",
                "CPU_GTT_USWC"
            };
            for (int i = 0; i < 4; i++)
                ASSERT_STR_EQ(json_array_get_string(attr, i), exp[i]);
        }
    }
    json_value_free(json_array_get_wrapping_value(out));
    return TEST_SUCCESS;
}

enum TEST_RESULT test_parse_sysfs_framebuffer()
{
    const char *content =
        "framebuffer[135]:\n"
        "\tallocated by = gnome-shell\n"
        "\trefcount=1\n"
        "\tformat=AR24 little-endian (0x34325241)\n"
        "\tmodifier=0x0\n"
        "\tsize=256x256\n"
        "\tlayers:\n"
        "\t\tsize[0]=256x256\n"
        "\t\tpitch[0]=1024\n"
        "\t\toffset[0]=0\n"
        "\t\tobj[0]:\n"
        "\t\t\tname=0\n"
        "\t\t\trefcount=2\n"
        "\t\t\tstart=00103c38\n"
        "\t\t\tsize=262144\n"
        "\t\t\timported=no\n"
        "framebuffer[119]:\n"
        "\tallocated by = [fbcon]\n"
        "\trefcount=1\n"
        "\tformat=XR24 little-endian (0x34325258)\n"
        "\tmodifier=0x1234\n"
        "\tsize=3440x1440\n"
        "\tlayers:\n"
        "\t\tsize[0]=3440x1440\n"
        "\t\tpitch[0]=13824\n"
        "\t\toffset[0]=0\n"
        "\t\tobj[0]:\n"
        "\t\t\tname=0\n"
        "\t\t\trefcount=2\n"
        "\t\t\tstart=00100000\n"
        "\t\t\tsize=19906560\n"
        "\t\t\timported=no\n";

    JSON_Array *out = parse_kms_framebuffer_sysfs_file(content);

    const char *expected_json =
        "[ \
            { \
                \"id\": 135, \"allocated by\": \"gnome-shell\", \"format\": \"AR24 little-endian (0x34325241)\", \
                \"modifier\": 0, \"size\": { \"w\": 256, \"h\": 256 }, \
                \"layers\": [ \
                    { \
                        \"size\": { \"w\": 256, \"h\": 256 }, \
                        \"pitch\": 1024 \
                    } \
                ] \
            }, \
            { \
                \"id\": 119, \"allocated by\": \"[fbcon]\", \"format\": \"XR24 little-endian (0x34325258)\", \
                \"modifier\": 4660, \"size\": { \"w\": 3440, \"h\": 1440 }, \
                \"layers\": [ \
                    { \
                        \"size\": { \"w\": 3440, \"h\": 1440 }, \
                        \"pitch\": 13824 \
                    } \
                ] \
            } \
        ]";

    JSON_Value *expected = json_parse_string(expected_json);

    ASSERT_EQ(json_value_equals(json_array_get_wrapping_value(out), expected), 1);
    return TEST_SUCCESS;
}

enum TEST_RESULT test_parse_sysfs_state()
{
    const char *content =
        "plane[65]: plane-5\n"
        "\tcrtc=crtc-0\n"
        "\tfb=120\n"
        "\t\tallocated by = gnome-shell\n"
        "\t\trefcount=2\n"
        "\t\tformat=XR24 little-endian (0x34325258)\n"
        "\t\tmodifier=0x200000020801b03\n"
        "\t\tsize=3440x1440\n"
        "\t\tlayers:\n"
        "\t\t\tsize[0]=3440x1440\n"
        "\t\t\tpitch[0]=13824\n"
        "\t\t\toffset[0]=0\n"
        "\t\t\tobj[0]:\n"
        "\t\t\t\tname=0\n"
        "\t\t\t\trefcount=2\n"
        "\t\t\t\tstart=001096aa\n"
        "\t\t\t\tsize=21422080\n"
        "\t\t\t\timported=no\n"
        "\tcrtc-pos=3440x1440+0+0\n"
        "\tsrc-pos=3440.000000x1440.000000+0.000000+0.000000\n"
        "\trotation=1\n"
        "\tnormalized-zpos=0\n"
        "\tcolor-encoding=ITU-R BT.601 YCbCr\n"
        "\tcolor-range=YCbCr limited range\n"
        "crtc[77]: crtc-0\n"
        "\tenable=1\n"
        "\tactive=1\n"
        "\tself_refresh_active=0\n"
        "\tplanes_changed=1\n"
        "\tmode_changed=0\n"
        "\tactive_changed=0\n"
        "\tconnectors_changed=0\n"
        "\tcolor_mgmt_changed=0\n"
        "\tplane_mask=a0\n"
        "\tconnector_mask=1\n"
        "\tencoder_mask=1\n"
        "\tmode: \"3440x1440\": 60 319750 3440 3520 3552 3600 1440 1468 1478 1481 0x48 0x9\n"
        "connector[94]: DP-1\n"
        "\tcrtc=crtc-0\n"
        "\tself_refresh_aware=0\n";

    JSON_Object *out = parse_kms_state_sysfs_file(content);

    const char * frames = "[{\"name\": \"plane-0\", \"fb\": 120, \"crtc\": { \"id\": 0, \"pos\": { \"x\": 0, \"y\": 0, \"w\": 3440, \"h\": 1440 } }]";
    const char * crtcs = "[{\"id\": 0, \"enable\": 1, \"active\": 1}]";
    const char * connectors = "[{\"name\": \"DP-1\", \"crtc\": 0}]";

    JSON_Value *frames_ref = json_parse_string(frames);
    ASSERT_EQ(json_value_equals(json_object_get_value(out, "frames"), frames_ref), 1);

    JSON_Value *crtcs_ref = json_parse_string(crtcs);
    ASSERT_EQ(json_value_equals(json_object_get_value(out, "crtcs"), crtcs_ref), 1);

    JSON_Value *connectors_ref = json_parse_string(connectors);
    ASSERT_EQ(json_value_equals(json_object_get_value(out, "connectors"), connectors_ref), 1);

    return TEST_SUCCESS;
}

DEFINE_TESTS(server_tests)
TEST(test_parse_sysfs_clock_file, "navi_reg_only.envdef", "navi10"),
TEST(test_parse_fence_info, "navi_reg_only.envdef", "navi10"),
TEST(test_parse_vm_info, "navi_reg_only.envdef", "navi10"),
TEST(test_parse_sysfs_framebuffer, "navi_reg_only.envdef", "navi10"),
TEST(test_parse_sysfs_state, "navi_reg_only.envdef", "navi10"),
END_TESTS(server_tests);
