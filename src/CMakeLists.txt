cmake_minimum_required(VERSION 3.10)

project(cpp_test)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)

# Source files
set(SOURCES
    main.cpp
)

add_executable(cpp_test ${SOURCES})

# Set the build type to "Debug" for debugging information
set(CMAKE_BUILD_TYPE Debug)

# Setup static code analyzer ( CppCheck )
find_program(CPPCHECK_EXECUTABLE NAMES cppcheck)

# Setup memory leak detector ( Valgrind )
find_program(VALGRIND_EXECUTABLE valgrind)
