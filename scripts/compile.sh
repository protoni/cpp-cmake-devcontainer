#!/bin/bash

# Build the application using CMake.
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON /app

# Build the project
cmake --build .

# Run static code analysis
mkdir -p /app/build/cppcheck_output
cppcheck \
    --enable=all \
    --std=c++11 \
    --inconclusive \
    --quiet \
    --suppress=missingIncludeSystem \
    --xml \
    --max-configs=25 \
    /app/src 2> /app/build/cppcheck_output/cppcheck_errors.xml

# Generate HTML report of the errors
cppcheck-htmlreport \
    --file=/app/build/cppcheck_output/cppcheck_errors.xml \
    --title=TestApp \
    --report-dir=/app/build/cppcheck_output \
    --source-dir=/app/src

# Setup sonar scanner
if [ -n "$SONARQUBE_TOKEN" ]; then
    sonar-scanner \
      -Dsonar.projectKey=Cpp_test \
      -Dsonar.sources=/app/src \
      -Dsonar.projectBaseDir=/app/src \
      -Dsonar.language=c++ \
      -Dsonar.host.url=http://localhost:9000 \
      -Dsonar.token=$SONARQUBE_TOKEN
fi

# Run memory leak detector
mkdir -p /app/build/valgrind_output
valgrind \
    --leak-check=full \
    --show-leak-kinds=all \
    --xml=yes \
    --xml-file=/app/build/valgrind_output/valgrind_output.xml \
    /app/build/cpp_test 2>&1

# Generate call stack profile
# Requirements: 
# Drag output file to for example: https://www.speedscope.app/, or use Kcachegrind
valgrind --tool=callgrind --callgrind-out-file="/app/build/valgrind_output/callgrind_output" /app/build/cpp_test

# Generate HTML report of the valgrind XML report
# ??

# Run tests
ctest --output-on-failure

# Generate HTML report from the Gtests
make html_report