FROM jiangengdong/template:conda

RUN conda install -y numpy ninja pyyaml mkl mkl-include setuptools cmake cffi typing_extensions future six requests dataclasses && \
    conda install -y -c pytorch magma-cuda102 && \
    conda clean -ya

WORKDIR /opt
RUN git clone --recursive --branch v1.8.1 --depth 1 https://github.com/pytorch/pytorch
RUN cd pytorch && \
    export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"} && \
    python3 setup.py install
