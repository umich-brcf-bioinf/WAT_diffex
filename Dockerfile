FROM continuumio/miniconda3:4.7.12

ARG env_name

# env_name is supplied as --build-arg to docker, and is identical between yaml file basename and environment name specified within it
COPY ${env_name}.yaml /tmp/

RUN conda install mamba -n base -c conda-forge

RUN mamba env create -f /tmp/${env_name}.yaml && conda clean --all -y

ENV PATH /opt/conda/envs/${env_name}/bin:$PATH

RUN apt-get --allow-releaseinfo-change update && \
    apt-get -y install fonts-noto

RUN fc-cache -fv

# Add RStudio to environment, to simplify the experience of interactive / manual interventions
RUN apt-get update && \
    apt-get install -y libnss3 libasound2 libegl1 && \
    wget -P /tmp/ https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb && \
    apt install -y /tmp/rstudio-1.2.5033-amd64.deb

