#### Description
A container for testing c++ building techniques.
Currently configured setup:
  - Cmake project
  - Run CppCheck and generate HTML report under build/ folder
  - Run Valgrind and generate XML report under build/ folder
  - Run sonar-scanner

#### Build
```
docker build -t test-app .
```

#### Shell access to container
```
docker run -it test-app /bin/bash
```

#### Run without SonarQube
```
docker run -v ${PWD}\build:/app/build -v ${PWD}\src:/app/src -v ${PWD}\scripts:/app/scripts -t test-app
```

#### Run with SonarQube
```
docker run --network=host -e SONAR_HOST_URL='http://127.0.0.1:9000' -v ${PWD}\build:/app/build -v ${PWD}\src:/app/src -v ${PWD}\scripts:/app/scripts -t test-app sonar PASTE_TOKEN_HERE
```

#### Configure SonarQube
```
From the SonarQube front-end ( localhost:9000 ), Copy the token to scripts/compile.sh -> -Dsonar.token=
```