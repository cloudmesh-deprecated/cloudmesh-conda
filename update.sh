#! /bin/sh


cd ..

cloudmesh-installer git pull cms
cloudmesh-installer git pull conda

cd cloudmesh-conda

conda build cloudmesh-common
conda build cloudmesh-cmd5
conda build cloudmesh-sys
