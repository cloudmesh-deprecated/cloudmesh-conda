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




