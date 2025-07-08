# Use miniconda as base image
FROM continuumio/miniconda3:latest


# Set working directory
WORKDIR /app

COPY converter.py /app/convert.py
# Update conda and install mamba for faster package resolution
RUN conda update -n base -c defaults conda && \
    conda install -n base -c conda-forge mamba

# Create a new conda environment with anndata2ri and its dependencies
RUN mamba create -n anndata2ri-env -c conda-forge -c bioconda \
    python=3.9 \
    anndata2ri \
    pandas \
    rpy2 \
    numpy \
    scipy \
    scanpy \
    r-base \
    bioconductor-singlecellexperiment \
    r-biocmanager \
    jupyter \
    ipykernel \
    -y

# Activate the environment by default
RUN echo "conda activate anndata2ri-env" >> ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]

# Make RUN commands use the new environment
RUN conda activate anndata2ri-env && \
    python -m ipykernel install --user --name anndata2ri-env --display-name "Python (anndata2ri)"

# Set environment variables
ENV CONDA_DEFAULT_ENV=anndata2ri-env
ENV PATH="/opt/conda/envs/anndata2ri-env/bin:$PATH"

# Expose port for Jupyter notebook (optional)
EXPOSE 8888

# Set the default command to activate environment and start bash
CMD ["conda", "run", "-n", "anndata2ri-env", "/bin/bash"]