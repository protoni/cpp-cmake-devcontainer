cmake_minimum_required(VERSION 3.10)

# Generate compile commands for sonarlint
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(cpp_test)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)

# Source files
set(SOURCES
    src/main.cpp
    src/test_example.h
    src/test_example.cpp
)

# Test Source files
set(TEST_SOURCES
    test/test_file.cpp
)

# Create a library for the main application
add_library(main_library ${SOURCES})

# Enable Google tests
enable_testing()
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

# Enable Google Test's death test feature
add_definitions(-DGTEST_HAS_DEATH_TEST=0)

# Unit test executable
add_executable(cpp_test_test ${TEST_SOURCES})
target_link_libraries(cpp_test_test GTest::GTest GTest::Main main_library)
target_compile_features(cpp_test_test PRIVATE cxx_std_11)

# Main application executable
add_executable(cpp_test ${SOURCES})
target_compile_features(cpp_test PRIVATE cxx_std_11)

# Set the build type to "Debug" for debugging information
set(CMAKE_BUILD_TYPE Debug)

# Setup static code analyzer ( CppCheck )
find_program(CPPCHECK_EXECUTABLE NAMES cppcheck)

# Setup memory leak detector ( Valgrind )
find_program(VALGRIND_EXECUTABLE valgrind)

# Link against the C++ standard library
target_link_libraries(cpp_test PRIVATE stdc++)

# Add unit tests
add_test(NAME cpp_test_test
        COMMAND cpp_test_test --gtest_output=xml:${CMAKE_BINARY_DIR}/tests_output/test_results.xml
)

# Add a custom target to generate HTML report
add_custom_target(html_report
    COMMAND xsltproc ${CMAKE_SOURCE_DIR}/test/gtest2html.xslt ${CMAKE_BINARY_DIR}/tests_output/test_results.xml > ${CMAKE_BINARY_DIR}/tests_output/test_report.html
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Generating HTML report"
)

# Ensure that the HTML report generation is performed after the tests have been run
add_dependencies(html_report cpp_test_test)