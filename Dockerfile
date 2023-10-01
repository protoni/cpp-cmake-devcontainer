# Use an official Debian-based Linux distribution as the base image
FROM debian:bullseye-slim

# Install necessary packages (CMake, g++, etc.)
RUN apt-get update && \
    apt-get install -y \
    cmake \
    g++ \
    libc6-dev \
    libstdc++-10-dev \
    valgrind \
    cppcheck \
    wget \
    zip \
    openjdk-17-jdk \
    libgtest-dev \
    xsltproc \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for your project
WORKDIR /app

# Copy sources
RUN mkdir /app/src
RUN mkdir /app/build
RUN mkdir /app/scripts
RUN mkdir /app/test

# Install SonarQube
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006.zip && \
    unzip sonar-scanner-cli-5.0.1.3006.zip && \
    mv sonar-scanner-5.0.1.3006 /opt/sonar-scanner

# Set the PATH environment variable to include the SonarQube Scanner
ENV PATH="/opt/sonar-scanner/bin:${PATH}"

# Copy your CMakeLists.txt and source files into the container
COPY CMakeLists.txt /app/
COPY src/ /app/src/
COPY scripts/compile.sh /app/scripts/
COPY .devcontainer/extensions.txt /app/
COPY test/ /app/test/

WORKDIR /app/build

# Open port 9000 for sonarqube
EXPOSE 9000

# Build the C++ application
RUN chmod +x /app/scripts/compile.sh
CMD ["/bin/bash", "/app/scripts/compile.sh"]
