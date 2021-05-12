#FROM debian:latest
FROM ubuntu:20.04

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

RUN apt-get update --fix-missing
RUN apt-get install -y wget bzip2
RUN apt-get install -y ca-certificates 
RUN apt-get install -y libglib2.0-0
RUN apt-get install -y libxext6
RUN apt-get install -y libsm6
RUN apt-get install -y libxrender1 
RUN apt-get install -y git
RUN apt-get install -y mercurial
RUN apt-get install -y subversion
RUN apt-get install -y curl grep sed

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-$VERSION-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get clean

RUN apt-get install -y build-essential

RUN pip install pip  -U

RUN conda update --all


RUN python --version
RUN pip --version
RUN conda --version
RUN conda config --add channels conda-forge

RUN conda config --set always_yes yes
RUN conda config --set anaconda_upload yes

# RUN pip install cloudmesh-installer
# RUN cloudmesh-installer git clone cms
# RUN cloudmesh-installer git clone conda


RUN git clone https://github.com/cloudmesh/cloudmesh-conda.git

# RUN cd cloudmesh-conda && conda build cloudmesh-common
# RUN cd cloudmesh-conda && conda build cloudmesh-cmd5
# RUN cd cloudmesh-conda && conda build cloudmesh-sys


#WORKDIR /cloudmesh-conda
#RUN  conda build .

# RUN ls /opt/conda/conda-bld/linux-64/



WORKDIR cloudmesh-conda

RUN make skeleton

CMD [ "/bin/bash" ]



