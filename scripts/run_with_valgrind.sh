#!/bin/bash

# Run the program with Valgrind
valgrind --leak-check=full /app/build/cpp_test
