FROM jiangengdong/template:devbase

RUN curl -fsSL -v -o ~/miniconda.sh -O  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    chmod +x ~/miniconda.sh && \
    ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda install -y python=3 conda-build && \
    /opt/conda/bin/conda clean -ya
RUN chmod -R ugo+rw /opt/conda/
ENV PATH /opt/conda/bin:$PATH
RUN conda init
