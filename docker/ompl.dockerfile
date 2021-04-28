FROM jiangengdong/template:torchbase as torchbase

FROM jiangengdong/template:conda

RUN conda install -y numpy ninja pyyaml mkl mkl-include setuptools cmake cffi typing_extensions future six requests dataclasses && \
    conda install -y -c pytorch magma-cuda102 pytorch torchvision torchaudio cudatoolkit=10.2 && \
    conda clean -ya
COPY --from=torchbase /opt/pytorch/torch /opt/pytorch/torch
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/pytorch/torch/lib/ \
    CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:/opt/pytorch/

WORKDIR /opt
RUN apt-get update && \
    apt-get install -y --no-install-recommends g++ cmake pkg-config libboost-serialization-dev libboost-filesystem-dev libboost-system-dev \
    libboost-program-options-dev libboost-test-dev libeigen3-dev libode-dev wget libyaml-cpp-dev && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    ln -sf /usr/include/eigen3/Eigen /usr/include/Eigen
RUN git clone --recursive --branch 1.4.2 --depth 1 https://github.com/ompl/ompl.git && \
    mkdir -p ompl/build/Release && \
    cd ompl/build/Release && \
    cmake ../.. && \
    make -j 4 && \
    make install
