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

RUN sh -c 'curl -Ls http://cloudmesh.github.io/get | sh'

# RUN cd cloudmesh-common; pip install .; cd ..
# RUN cd cloudmesh-cmd5; pip install .; cd ..
# RUN cd cloudmesh-sys; pip install .; cd ..
# RUN cd cloudmesh-inventory; pip install .; cd ..
# RUN cd cloudmesh-cloud; pip install .; cd ..
# RUN cd cloudmesh-; pip install .; cd ..

RUN python --version
RUN pip --version
RUN conda --version
RUN conda config --add channels conda-forge

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]

WORKDIR cloudmesh-conda

#  sudo apt-get update
#  # wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh

#  # curl -O https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
#  #sh Anaconda3-2018.12-Linux-x86_64.sh -b

#  wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh

#  # sh Anaconda3-5.0.1-Linux-x86_64.sh -b

#  sudo sh Anaconda3-2018.12-Linux-x86_64.sh -b -u -p /usr/local

#  export PATH="/usr/local/anaconda3/bin:$PATH"
#  conda config --set anaconda_upload yes
#  conda config --env --add channels conda-forge

#  export SRC=`pwd`


