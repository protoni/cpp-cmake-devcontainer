#!/bin/bash

# Build the application using CMake
cmake /app/src

cmake --build .

# Run static code analysis
cppcheck --enable=all --std=c++11 --inconclusive --quiet --suppress=missingIncludeSystem --xml --max-configs=25 /app/src 2> /app/build/cppcheck_errors.xml

# Generate HTML report of the errors
cppcheck-htmlreport --file=/app/build/cppcheck_errors.xml --title=TestApp --report-dir=/app/build/ --source-dir= /app/src

# Setup sonar scanner
sonar-scanner \
  -Dsonar.projectKey=Cpp_test \
  -Dsonar.sources=/app/src \
  -Dsonar.projectBaseDir=/app/src \
  -Dsonar.language=c++ \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.token=sqp_b2b03fc650f7626e2f18c8ff71401c10a421e65d

# Run memory leak detector
valgrind --leak-check=full --show-leak-kinds=all --xml=yes /app/build/cpp_test > /app/build/valgrind_output.xml 2>&1

# Generate HTML report of the