FROM nvidia/cuda:11.0-base
FROM ubuntu:20.04
#enable CUDA support????
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all

#build xmr-mo from git
RUN set -xe;\
    apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev; \
    git clone https://github.com/xmrig/xmrig.git; \
    mkdir xmrig/build && cd xmrig/build; \
    cmake ..; \
    make -j$(nproc);

#build xmr-mo-cuda from git
RUN set -xe;\
    git clone https://github.com/xmrig/xmrig-cuda.git;\
    mkdir xmrig-cuda/build && cd xmrig-cuda/build;\
    cmake .. -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda;\
    make -j$(nproc);