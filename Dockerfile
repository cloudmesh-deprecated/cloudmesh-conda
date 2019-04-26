#FROM debian:latest
FROM ubuntu:18.10

MAINTAINER Gregor von Laszewski <laszewski@gmail.com>

ENV VERSION=5.3.0

RUN apt-get update

#  $ docker build . -t cloudmesh/anaconda:latest -t cloudmesh/anaconda:$VERSION -t cloudmesh/anaconda3:latest -t cloudmesh/anaconda3:$VERSION
#  $ docker run --rm -it cloudmesh/anaconda3:latest /bin/bash
#  $ docker push cloudmesh/anaconda:latest
#  $ docker push cloudmesh/anaconda:$VERSION
#  $ docker push cloudmesh/anaconda3:latest
#  $ docker push cloudmesh/anaconda3:$VERSION

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-$VERSION-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

RUN pip install pip  -U

RUN conda update --all


RUN python --version
RUN pip --version
RUN conda --version
RUN conda config --add channels conda-forge

RUN conda config --set always_yes yes
RUN conda config --set anaconda_upload no

RUN pip install cloudmesh-installer


RUN cloudmesh-installer git clone cms
RUN cloudmesh-installer git clone conda



RUN cd cloudmesh-conda && conda build cloudmesh-common
RUN cd cloudmesh-conda && conda build cloudmesh-cmd5
RUN cd cloudmesh-conda && conda build cloudmesh-sys


#WORKDIR /cloudmesh-conda
#RUN  conda build .

RUN ls /opt/conda/conda-bld/linux-64/

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]

WORKDIR cloudmesh-conda





