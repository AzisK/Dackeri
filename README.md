# Dackeri

Check your Docker image build

### Usage

Build the images
```bash
docker-compose build
```

Run the apps on containers of the images 
```bash
docker-compose up
```

There are 2 versions: the usual one `src/app.py` and `src/app.simple.py` which is a little more simple and lightweigth

A. Run the usual one
```bash
docker-compose run dackeri
```

B. Run the simple one
```bash
docker-compose run dackerisimple
```

# Customization

These examples are built for Docker images with Python and its dependencies but can be adapted to completely different programs and its dependencies.

Here we have 2 Dockerfiles. `Dockerfile.simple` is simple, utilizing a Docker image with Python already installed `FROM python:${PYTHON_VERSION}-slim as base`. It is recommended to use it as it is lightweigth. However, if this does not help solve the issue or trace the problem, we can use `Dockerfile` to start from a fresh OS instalation and install Python and other dependencies ourselves.

`requirements.txt` can be adjusted to desired libraries. Current one has been used to trace an issue with an open source library pypika and can be found here https://github.com/kayak/pypika/issues/761#issuecomment-1760599852.

### License
MIT
