#!/bin/bash
# docker run -it debian:12-slim /bin/bash
# https://github.com/AUTOMATIC1111/stable-diffusion-webui

apt-get update
set -e
export baseDir=/app/onxx-stream
mkdir -p $baseDir
cd $baseDir
command -v cmake >/dev/null || apt-get install -y cmake g++-aarch64-linux-gnu python3 git git-lfs

###

git clone https://github.com/google/XNNPACK.git
cd XNNPACK
git checkout 1c8ee1b68f3a3e0847ec3c53c186c5909fa3fbd3
mkdir build
cd build
cmake -DXNNPACK_BUILD_TESTS=OFF -DXNNPACK_BUILD_BENCHMARKS=OFF ..
cmake --build . --config Release

###

cd $baseDir
git lfs install
git clone --depth=1 https://huggingface.co/AeroX2/stable-diffusion-xl-turbo-1.0-onnxstream

###

cd $baseDir
git clone https://github.com/vitoplantamura/OnnxStream.git
cd OnnxStream
cd src
mkdir build
cd build
cmake -DMAX_SPEED=ON -DOS_LLM=OFF -DOS_CUDA=OFF -DXNNPACK_DIR=/app/onxx-stream/XNNPACK ..
cmake --build . --config Release


#cd OnnxStream/src
#mkdir build
#cd build
#apt install libpthreadpool-dev
#cmake -DMAX_SPEED=ON -DXNNPACK_DIR=$baseDir/XNNPACK/include ..
#cmake --build . --config Release

# Aufruf
#cd $baseDir/OnnxStream/src/build/
#time $baseDir/sd --turbo --rpi --models-path $baseDir/stable-diffusion-xl-turbo-1.0-onnxstream --prompt "An astronaut riding a horse on Mars" --steps 1 --output astronaut.png
