#!/bin/bash

# try installing a package with python pip
# pip3.6 install python-pip

cd /data1/environments
# create an environment by running the following command:
python3.6 -m venv my_env
# To use this environment, you need to activate it, which you can do by typing 
# the following command that calls the activate script in the bin directory
source my_env/bin/activate

echo 'print("Hello, World!")' > /data1/environments/hello.py
python3.6 /data1/environments/hello.py
deactivate
