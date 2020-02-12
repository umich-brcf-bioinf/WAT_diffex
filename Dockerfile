FROM continuumio/miniconda3:4.7.12-alpine

ARG env_name

# env_name is supplied as --build-arg to docker, and is identical between yaml file basename and environment name specified within it
COPY ${env_name}.yaml /tmp/

ENV PATH /opt/conda/bin:$PATH

#bioconductor post-link scripts need bash
RUN conda install -c conda-forge bash && \
    conda env create -f /tmp/${env_name}.yaml && \
    conda clean --all -y

ENV PATH /opt/conda/envs/${env_name}/bin:$PATH

