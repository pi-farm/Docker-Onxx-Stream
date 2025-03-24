#!/bin/bash
# docker run -it debian:12-slim /bin/bash

apt-get update
set -e
export baseDir=/app/onxx-stream
mkdir -p $baseDir
cd $baseDir
command -v cmake >/dev/null || apt-get install -y cmake g++-aarch64-linux-gnu python3 git git-lfs
git clone https://github.com/google/XNNPACK.git
cd XNNPACK
bash scripts/build-linux-aarch64.sh

###

cd $baseDir
git lfs install
git clone --depth=1 https://huggingface.co/AeroX2/stable-diffusion-xl-turbo-1.0-onnxstream

cd $baseDir
git clone https://github.com/vitoplantamura/OnnxStream.git
cd OnnxStream/src
mkdir build
cd build
cmake -DMAX_SPEED=ON -DXNNPACK_DIR=$baseDir/XNNPACK ..
cmake --build . --config Release

# Aufruf
#cd $baseDir/OnnxStream/src/build/
#time $baseDir/sd --turbo --rpi --models-path $baseDir/stable-diffusion-xl-turbo-1.0-onnxstream --prompt "An astronaut riding a horse on Mars" --steps 1 --output astronaut.png
