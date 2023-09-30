#### Description
A container for testing c++ building techniques.
Currently configured setup:
  - Docker build environment
  - Cmake project
    - Run CppCheck and generate HTML report under build/cppcheck_output folder
    - Run Valgrind and generate XML report under build/valgrind_output folder
    - ( Optional ) Run sonar-scanner
  - VScode dev env setup
    - Autosetup sonarlint for c++

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
code .
Ctrl + Shift + P -> Reopen in container
```

#### Run build without SonarQube
```
docker run -v ${PWD}\build:/app/build -v ${PWD}\src:/app/src -v ${PWD}\scripts:/app/scripts -t test-app
```

#### Run build with SonarQube
```
docker run --network=host -e SONAR_HOST_URL='http://127.0.0.1:9000' -v ${PWD}\build:/app/build -v ${PWD}\src:/app/src -v ${PWD}\scripts:/app/scripts -e SONARQUBE_TOKEN=PASTE_TOKEN_HERE -t test-app
```

#### Configure SonarQube
```
From the SonarQube front-end ( localhost:9000 ), Copy the token to docker run command ( it is used by scripts/compile.sh -> -Dsonar.token= )
```
