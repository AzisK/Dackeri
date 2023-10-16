# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/engine/reference/builder/

# Get the OS image
FROM ubuntu:22.04 as base

# Define desired Python version number
ARG PYTHON_VERSION=3.11.5

# Prevents Python from writing pyc files
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering
ENV PYTHONUNBUFFERED=1

# Update the package list and install essential packages for Python ${PYTHON_VERSION}

# Install essential build tools, including dependencies required for compiling source code, as well as occasional dependencies used when Python requires specific features
# - build-essential: Critical (always needed when building from source)
# - wget: Critical (used to download Python source code)
# - libssl-dev: Critical (required for secure socket connections)
# - zlib1g-dev: Occasional (used when Python requires zlib support)
# - libgdbm-dev: Occasional (used when Python works with dbm databases)
# - libnss3-dev: Critical (required for SSL/TLS support in Python)
# - libreadline-dev: Occasional (used for interactive command-line sessions)
# - libffi-dev: Critical (required for C-API and calling functions from dynamic libraries)
# - libsqlite3-dev: Occasional (used when working with SQLite databases)
# - libbz2-dev: Occasional (used when Python requires Bzip2 support)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    libssl-dev \
    zlib1g-dev \
    libgdbm-dev \
    libnss3-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    libbz2-dev

# Download and install Python ${PYTHON_VERSION} source code
WORKDIR /tmp
RUN wget --no-check-certificate https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
RUN tar -xf Python-${PYTHON_VERSION}.tgz
WORKDIR /tmp/Python-${PYTHON_VERSION}
RUN ./configure --enable-optimizations
RUN make -j$(nproc)
RUN make install

# Clean up
WORKDIR /
RUN rm -rf /tmp/Python-${PYTHON_VERSION}

# Move to /app directory
WORKDIR /app

# Copy requirements.txt into the image
COPY requirements.txt .

# Upgrade pip
RUN pip3 install --upgrade pip

# Download Python dependencies as a separate step to take advantage of Docker's caching
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds
# Install Python dependecies
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt

# Copy the source code into the container
COPY src ./src

# Run the application
CMD python3 src/app.py
