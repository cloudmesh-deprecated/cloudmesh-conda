# Conda Cloudmesh Package creation

## Prerequisits

Using docker container to create cloudmesh
put DOckerile in repo

## Creating the Conda package

This will explain how the conta packges are created in the container.

The container could for example be started as interactive container. on OSX 

    cms terminal   
    
Needs proper image

## Uploading the Conda packages

Once the packages are created they shuld be uploaded

## Management Makefile

A management makefile will be created with the following targets

`make image` - creates the docker image
`make image-upload` - uploads the image to dockerhub
`make conda` -creates all conda packages using the container
`make conda-upload` uploads all conda packages to the conda hub




# Creating Conda packages for cloudmesh

BUG install this in non sudo


* Step 1 - Download anaconda latest version by running command - 
  
  ```
  mkdir condavm
  cd condavm
  vagrant init generic/ubuntu1810
  vagrant up
  vagarnt ssh
  
  sudo apt-get update
  # wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh

  # curl -O https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
  #sh Anaconda3-2018.12-Linux-x86_64.sh -b
  
  wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
  
  # sh Anaconda3-5.0.1-Linux-x86_64.sh -b
  
  sudo sh Anaconda3-2018.12-Linux-x86_64.sh -b -u -p /usr/local
  
  export PATH="/usr/local/anaconda3/bin:$PATH"
  conda config --set anaconda_upload yes
  conda config --env --add channels conda-forge
  
  export SRC=`pwd`
  git clone https://github.com/cloudmesh/cloudmesh-common.git
  git clone https://github.com/cloudmesh/cloudmesh-cmd5.git
  git clone https://github.com/cloudmesh/cloudmesh-sys.git
  git clone https://github.com/cloudmesh-community/cloudmesh-inventory.git
  git clone https://github.com/cloudmesh/cloudmesh-openapi.git
  git clone https://github.com/cloudmesh-community/cloudmesh-cloud.git
  ```
 
  
* Step 6 - Login to anaconda org to upload the packages - 
 
  ```
  anaconda login --username <username> --password <Password>
  ```
 
* Step 7 - conda build cloudmesh-common (This will build and upload cloudmesh-common)

  ```
  cd $SRC/cloudmesh-conda
  conda build cloudmesh-common
  conda build cloudmesh-cmd5
  conda build cloudmesh-sys
  conda build cloudmesh-inventory
  ```
  
* Step 8 - Install the packages

  ```
  sudo conda install -y -c laszewski cloudmesh-cmd5
  sudo conda install -y -c laszewski cloudmesh-sys
  sudo conda install -y -c laszewski cloudmesh-inventory
  ```
