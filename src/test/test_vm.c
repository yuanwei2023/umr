#include "test_framework.h"

// testing direct VM construction
enum TEST_RESULT test_can_read_from_vm_memory_direct0(struct umr_asic* asic)
{
    uint64_t read_data = 0;
    ASSERT_SUCCESS(umr_read_vram(asic, UMR_GFX_HUB|0, 0x444000, sizeof(read_data), &read_data));
    ASSERT_EQ(read_data, 0x0706050403020100);
    return TEST_SUCCESS;
}

// testing direct VM construction
enum TEST_RESULT test_can_read_from_vm_memory_direct1(struct umr_asic* asic)
{
    uint64_t read_data = 0;
    ASSERT_SUCCESS(umr_read_vram(asic, UMR_GFX_HUB|3, 0x800100400800ULL, sizeof(read_data), &read_data));
    ASSERT_EQ(read_data, 0x0706050403020100);
    return TEST_SUCCESS;
}

// testing direct VM construction
enum TEST_RESULT test_can_read_from_vm_memory_direct2(struct umr_asic* asic)
{
    uint64_t read_data = 0;
    ASSERT_SUCCESS(umr_read_vram(asic, UMR_GFX_HUB|0, 0x446000ULL, sizeof(read_data), &read_data));
    ASSERT_EQ(read_data, 0x0706050403020100);
    return TEST_SUCCESS;
}

// testing direct VM construction
enum TEST_RESULT test_can_read_from_vm_memory_direct3(struct umr_asic* asic)
{
    uint64_t read_data = 0;
    ASSERT_SUCCESS(umr_read_vram(asic, UMR_GFX_HUB|3, 0x15600000ULL, sizeof(read_data), &read_data));
    ASSERT_EQ(read_data, 0x0706050403020100);
    return TEST_SUCCESS;
}


// testing direct VM construction
enum TEST_RESULT test_can_read_from_vm_memory_direct4(struct umr_asic* asic)
{
    uint64_t read_data = 0;
    ASSERT_SUCCESS(umr_read_vram(asic, UMR_GFX_HUB|3, 0x15402000ULL, sizeof(read_data), &read_data));
    ASSERT_EQ(read_data, 0x0706050403020100);
    return TEST_SUCCESS;
}

DEFINE_TESTS(vm_tests)
#if 1
TEST(test_can_read_from_vm_memory_direct0, "direct_vm_test0.envdef", "raven1"),
TEST(test_can_read_from_vm_memory_direct1, "direct_vm_test1.envdef", "raven1"),
TEST(test_can_read_from_vm_memory_direct2, "direct_vm_test2.envdef", "navi10"),
TEST(test_can_read_from_vm_memory_direct3, "direct_vm_test3.envdef", "navi10"),
#endif
TEST(test_can_read_from_vm_memory_direct4, "direct_vm_test4.envdef", "navi10"),
END_TESTS(vm_tests);
