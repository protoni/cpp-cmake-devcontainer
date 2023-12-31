#### Description
A container for testing c++ building techniques.
Currently configured setup:
  - Docker build environment
  - Cmake project
    - Run CppCheck and generate HTML report under build/cppcheck_output folder
    - Run Valgrind and generate XML report under build/valgrind_output folder
      - Also generate callgrind object for Kcachegrind/other tool to open with
    - Run unittests and generate HTML report under build/tests_output folder
    - ( Optional ) Run sonar-scanner
  - VScode devcontainer setup
    - Sonarlint for c++
    - Cppcheck
    - Clang-format code formatting with slightly modified google styleguide rules 
    - Add debugger and run valgrind when running the executable from the editor
  - Generate docs with doxygen

#### Build
```
docker build -t test-app .
```

#### Shell access to container
```
docker run -it test-app /bin/bash
```

#### Dev env
```
# Open editor
code .

# Open console and open editor in the container
Ctrl + Shift + P -> Reopen in container

# Build
/app/scripts/compile.sh

# To switch back to local sources
Ctrl + Shift + P -> Reopen folder locally

# Note:
Volume mappings are done for dev env for these folders:
- src/
- scripts/
- build/
- test/
```

#### Run build without SonarQube
```
docker run -v ${PWD}\build:/app/build -v ${PWD}\src:/app/src -v ${PWD}\scripts:/app/scripts -t test-app
```

#### Run build with SonarQube
```
docker run --network=host -e SONAR_HOST_URL='http://127.0.0.1:9000' -v ${PWD}\build:/app/build -v ${PWD}\src:/app/src -v ${PWD}\scripts:/app/scripts -e SONARQUBE_TOKEN=PASTE_TOKEN_HERE -t test-app
```

#### View build status and docs
```
Build the project and open project_info.html
```