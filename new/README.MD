This docker container does not have great performance and there are better implementations of this.
The docker container was designed to run on unraid and may not work on other platforms, because of this the instructions will be for unraid.

This docker container requires these things to install and run.
    1.The nvidia driver in unraid this can be found in CA under "Nvidia Driver" by ich777.
    2.under advanced options in the "Extra Parameters" field "--runtime=nvidia" must be present otherwise it will not run (this tells docker to expect an nvidia GPU)
    3.a variable with the key NVIDIA_VISIBLE_DEVICES and the value of the GUID of your nvidia GPU
    4.a variable with the key URL and the value of a monero mining pool must be supplied
    5.a variable with the key USER and the value of your wallet must be supplied
    6.a variable with the key PASS is optional but for most pools it allows easy identification of a miner
