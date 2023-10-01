#include "gtest/gtest.h"
#include "../src/test_example.h"  // Adjust the path accordingly
#include <iostream>
TEST(cpp_test_test, TestAddition) {
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(-1, 1), 0);
}

TEST(cpp_test_test, TestSubtraction) {
    EXPECT_EQ(subtract(5, 3), 2);
    EXPECT_EQ(subtract(0, 1), -1);
}