#base lvl
FROM ubuntu:20.04
#cuda
FROM nvidia/cuda:10.2-base



LABEL maintainer="Jerhaad"

# USE YOUR TIMEZONE
# TODO: Automate
ARG TIMEZONE=America/Los_Angeles

# XMRig base version
ARG XMRIG_VER=6.12.2-mo2

# XMRig-CUDA version
ARG XMRIG_CUDA_VER=6.12.0

# Let the installs happen on their own
ENV DEBIAN_FRONTEND=noninteractive 

#allow GPU passthrough
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

# One-off for tzdata
RUN set -xe; \
    apt update && apt upgrade -y; \
    ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime; \
    apt install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata;



# Install XMRig
RUN set -xe; \
    apt-get update && apt-get install build-essential cmake automake libtool autoconf wget -y; \
    wget https://github.com/MoneroOcean/xmrig/archive/refs/tags/v${XMRIG_VER}.tar.gz; \
    tar xf v${XMRIG_VER}.tar.gz; \
    mkdir -p xmrig-${XMRIG_VER}/build; \
    sed -i 's/DonateLevel = 1/DonateLevel = 0/g' xmrig-${XMRIG_VER}/src/donate.h; \
    cd xmrig-${XMRIG_VER}/scripts; \
    ./build_deps.sh; \
    cd ../build; \
    cmake .. -DXMRIG_DEPS=scripts/deps -DCMAKE_BUILD_TYPE=Release -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda; \
    make -j $(nproc); \
    cp xmrig /usr/local/bin/xmrig; \
    rm -rf xmrig* *.tar.gz;

# XMRig-CUDA install
RUN set -xe; \
    wget https://github.com/xmrig/xmrig-cuda/archive/refs/tags/v${XMRIG_CUDA_VER}.tar.gz; \
    tar xf v${XMRIG_CUDA_VER}.tar.gz; \
    mkdir -p xmrig-cuda-${XMRIG_CUDA_VER}/build; \
    cd xmrig-cuda-${XMRIG_CUDA_VER}/build; \
    cmake .. -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda; \
    make -j$(nproc); \
    cp libxmrig-cuda.so /usr/local/lib/libxmrig-cuda.so;

WORKDIR /tmp
COPY entrypoint.sh /
EXPOSE 3000
CMD ["/entrypoint.sh"]
#https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#package-manager-installation