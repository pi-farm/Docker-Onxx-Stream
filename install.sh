#!/bin/bash
set -e
export baseDir=/app/onxx-stream
mkdir $baseDir
cd $baseDir

command -v cmake >/dev/null || apt-get install -y cmake
command -v git-lfs >/dev/null || apt-get install -y git-lfs

git clone https://github.com/google/XNNPACK.git
cd XNNPACK/scripts/
#git checkout 579de32260742a24166ecd13213d2e60af862675
#mkdir build
#cd build
#cmake -DXNNPACK_BUILD_TESTS=OFF -DXNNPACK_BUILD_BENCHMARKS=OFF ..
#cmake --build . --config Release
bash build-linux-aarch64.sh

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
