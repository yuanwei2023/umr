#include "test_framework.h"

enum TEST_RESULT test_can_translate_vm_addr(struct umr_asic* asic)
{
    ASSERT_SUCCESS(umr_read_vram(asic, UMR_GFX_HUB|1, 0x1000000, 0, NULL));
    return TEST_SUCCESS;
}

enum TEST_RESULT test_can_read_from_vm_memory(struct umr_asic* asic)
{
    uint32_t read_data = 0;
    ASSERT_SUCCESS(umr_read_vram(asic, UMR_GFX_HUB|1, 0x1000000, sizeof(read_data), &read_data));
    ASSERT_EQ(read_data, 0x87654321);
    return TEST_SUCCESS;
}

enum TEST_RESULT test_can_write_to_vm_memory(struct umr_asic* asic)
{
    uint32_t data = 0x12345678;
    uint32_t read_data = 0;
    ASSERT_SUCCESS(umr_write_vram(asic, UMR_GFX_HUB|1, 0x1000000, sizeof(data), &data));
    ASSERT_SUCCESS(umr_read_vram(asic, UMR_GFX_HUB|1, 0x1000000, sizeof(read_data), &read_data));
    ASSERT_EQ(data, read_data);
    return TEST_SUCCESS;
}

DEFINE_TESTS(vm_tests)
TEST(test_can_translate_vm_addr, "basic_vm.envdef", "vega10"),
TEST(test_can_translate_vm_addr, "basic_vm.envdef", "navi10"),
TEST(test_can_translate_vm_addr, "basic_vm.envdef", "renoir"),
TEST(test_can_read_from_vm_memory, "basic_vm.envdef", "vega10"),
TEST(test_can_read_from_vm_memory, "basic_vm.envdef", "navi10"),
TEST(test_can_read_from_vm_memory, "basic_vm.envdef", "renoir"),
TEST(test_can_write_to_vm_memory, "basic_vm.envdef", "vega10"),
TEST(test_can_write_to_vm_memory, "basic_vm.envdef", "navi10"),
TEST(test_can_write_to_vm_memory, "basic_vm.envdef", "renoir"),
END_TESTS(vm_tests);
