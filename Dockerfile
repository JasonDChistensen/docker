# To build: docker build -t my-miniconda .
# To debug: docker build -t my-miniconda . --progress=plain

# To run:  docker run -it --mount type=bind,source=/home/jason,target=/home/jason -w /home/jason my-miniconda

# 1. Use the official Ubuntu 24.04 image as the base
FROM ubuntu:24.04

# 2. Set environment variables to prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# 3. Update and install packages, then clean up to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# For Ubuntu/Debian based images.  Without this wget will fail with the error: ERROR: cannot verify repo.anaconda.com's certificate, issued by 'CN=E7,O=Let\'s Encrypt,C=US': 
RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# -b (Batch Mode): Runs the installer without manual intervention and automatically accepts the license agreement
# -p [PATH] (Prefix): Defines the installation directory. You must provide this in batch mode if you want to ensure it installs where you expect (default is often $HOME/miniconda3).
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda
RUN ls -la /miniconda
ENV PATH="/miniconda/bin:${PATH}"

# Command to workaround: RUN conda update --all
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

# 4. Set the working directory
WORKDIR /home/jason



# 5. Define the default command to run
CMD ["/bin/bash"]

# conda env list
# which python
# python --version
# which pip
# pip --version
# conda list

# conda create --name py311 python=3.11.9
# docker ps
# docker commit my-miniconda my-miniconda:py311
#    docker commit <container_id_or_name> <new_image_name>:<tag>
# exit current container
# docker run -it --mount type=bind,source=/home/jason,target=/home/jason -w /home/jason my-miniconda:py311
# source activate py311
# which python
# python --version
# conda list
# conda deactivate
# exit the container

# docker run -it --mount type=bind,source=/home/jason,target=/home/jason -w /home/jason my-miniconda
# conda create --name py27 python=2.7.18
# source activate py27
# python --version
# conda list
# conda deactivate


# Create the new tag: docker tag old-name:old-tag new-name:new-tag
# Remove the old tag: docker rmi old-name:old-tag


