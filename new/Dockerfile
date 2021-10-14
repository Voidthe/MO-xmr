FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
#enable CUDA support????
ENV NVIDIA_DRIVER_CAPABILITIES=all
RUN set -xe; \
    apt update; \
    apt install software-properties-common wget -y; \
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub; \
    apt-key add 7fa2af80.pub; \ 
    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"; \
    apt-get update; \
    apt-get -y install cuda;
#give library access to docker container
RUN apt update
RUN apt install libssl1.1 libhwloc-dev -y
WORKDIR /exes
##copy the required files
COPY  /exes/ /exes/
COPY /entrypoint.sh /

#start the miner
CMD ["/entrypoint.sh"]


##isues with code so far
#its very simple but also requires the dependancys to be precreated so each new version will require an update (automate)
