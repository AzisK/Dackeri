import sys
import platform
import subprocess
import os
import pkg_resources


def get_package_metadata(package_name):
    try:
        distribution = pkg_resources.working_set.by_key.get(package_name)
        if distribution:
            return f"Name: {distribution.project_name}\nVersion: {distribution.version}\nLocation: {distribution.location}"
        return f"Package '{package_name}' not found."
    except Exception as e:
        return f"Error retrieving metadata for '{package_name}': {str(e)}"

def print_python_info():
    print(f"Python Version: {platform.python_version()}")
    print(f"Python Executable: {sys.executable}")

def print_pip_info():
    try:
        pip_version = subprocess.check_output([sys.executable, '-m', 'pip', '--version']).decode('utf-8')
        print(f"pip Version: {pip_version.strip()}")
    except subprocess.CalledProcessError as e:
        print("pip is not installed or not found.")

def print_setuptools_info():
    try:
        setuptools_version = pkg_resources.get_distribution("setuptools").version
        print(f"Setuptools Version: {setuptools_version}")
    except pkg_resources.DistributionNotFound:
        print("Setuptools is not installed or not found.")

def print_os_info():
    print(f"Operating System: {platform.system()} {platform.release()}")

def print_env_variables():
    print("Environment Variables:")
    for key, value in os.environ.items():
        print(f"{key}: {value}")

def print_python_path():
    print("Python Path:")
    for path in sys.path:
        print(path)

def print_installed_packages():
    # Print detailed package information
    print("Installed Python Packages:")
    for package_name in [pkg.project_name for pkg in pkg_resources.working_set]:
        package_metadata = get_package_metadata(package_name)
        print(f"Package: {package_name}\n{package_metadata}\n")

if __name__ == "__main__":
    print("Python and its dependencies are installed successfully!")
    print("\n")
    print_python_info()
    print("\n")
    print_pip_info()
    print("\n")
    print_setuptools_info()
    print("\n")
    print_os_info()
    print("\n")
    print_env_variables()
    print("\n")
    print_python_path()
    print("\n")
    print_installed_packages()
    print("\n")
