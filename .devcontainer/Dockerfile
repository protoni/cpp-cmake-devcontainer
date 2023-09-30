FROM test-app

# Set your working directory
WORKDIR /app

# Copy necessary files
COPY . .

# Install dependencies for code-server
RUN apt-get update && \
    apt-get install -y curl wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app/build

# Make sure that build/compile_commands.json exists because sonarlint depends on it
RUN chmod +x /app/scripts/compile.sh
RUN [ ! -e "/app/build/compile_commands.json" ] && /bin/bash /app/scripts/compile.sh || true


# Download and install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install VSCode extensions
RUN mkdir -p /home/vscode/.vscode-server/extensions \
    && cat /app/extensions.txt | xargs -L 1 code-server --install-extension

COPY settings.vscode.json /root/.vscode-remote/data/Machine/settings.json


# Set the entry point without default parameters
CMD ["/bin/bash", "/app/scripts/compile.sh"]