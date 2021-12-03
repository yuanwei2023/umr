#include "test_framework.h"
#include "parson.h"

extern void parse_sysfs_clock_file(char *content, int *min, int *max);
extern JSON_Value *compare_fence_infos(const char *before, const char *after);
extern JSON_Array *parse_vm_info(const char *content);

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

DEFINE_TESTS(server_tests)
TEST(test_parse_sysfs_clock_file, "navi_reg_only.envdef", "navi10"),
TEST(test_parse_fence_info, "navi_reg_only.envdef", "navi10"),
TEST(test_parse_vm_info, "navi_reg_only.envdef", "navi10"),
END_TESTS(server_tests);
