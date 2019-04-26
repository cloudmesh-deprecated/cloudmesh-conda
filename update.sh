#! /bin/sh


cd .. && cloudmesh-installer git pull cms \
         cloudmesh-installer git pull conda


cd cloudmesh-conda && conda build cloudmesh-common && cd ..
cd cloudmesh-conda && conda build cloudmesh-cmd5 && cd ..
cd cloudmesh-conda && conda build cloudmesh-sys && cd ..
