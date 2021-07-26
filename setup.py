"""
Setup of codebase
"""
import os
import sys

from setuptools import find_packages, setup

requirements = set(
    [
        "numpy",
        "opencv-python",
        "matplotlib",
        "scikit-image",
        "imageio",
        "torch",
        "torchvision",
        "torchsummary",
        "tensorboardX"
    ]
)

# if someone wants to output a requirements file
# `python setup.py --list-reqs > requirements.txt`
if "--list-reqs" in sys.argv:
    print("\n".join(requirements))
    exit()

# load README.md as long_description
long_description = ""
if os.path.exists("README.md"):
    with open("README.md", "r") as f:
        long_description = f.read()

setup(
    name="ggcnn",
    version=2.0,
    description="GGCNN Paper Code",
    long_description=long_description,
    author="Douglas Morrison",
    license="BSD-3-Clause License",
    url="https://github.com/dougsm/ggcnn",
    keywords="robotics computer vision",
    classifiers=[
        "License :: OSI Approved :: BSD-3-Clause License",
        "Programming Language :: Python",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Natural Language :: English",
        "Topic :: Scientific/Engineering",
    ],
    packages=find_packages(),
    install_requires=list(requirements),
)