import sys
import subprocess
import platform


# Hello world in Lithuanian
print('Labas, pasauli!')
print('Python and its libraries have been successfully installed.')
print('Python Version:', sys.version)

try:
    pip_version = subprocess.check_output([sys.executable, '-m', 'pip', '--version']).decode('utf-8')
    print(f'pip Version: {pip_version.strip()}')
except subprocess.CalledProcessError as e:
    print('pip is not installed or not found.')

# Print OS information
print('Operating System:', platform.system(), platform.release())
