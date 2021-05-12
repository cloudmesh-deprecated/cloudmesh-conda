# Conda Cloudmesh Package creation

We explain how we create conda packages for cloudmesh. This has not yet been
extensively tested. If you like to help let us know.

workflow:

make container
make shell
container> anaconda login
container> make upload

open https://anaconda.org/cloudmesh/repo


## Installing of the packages

You will need to execute the following commands

```bash
$ conda install -c cloudmesh cloudmesh-common
$ conda install -c cloudmesh cloudmesh-cmd5
$ conda install -c cloudmesh cloudmesh-sys
$ conda install -c cloudmesh cloudmesh-inventory
```

After this you still need to set up the `cloudmesh.yaml` and
inventory.yaml in your ~/.cloudmesh directory. Prerequisits

For more indformation see our documentation


## Creating the Conda package

The next set of information is only for the maintainers of the package and

The directory contains a maikefile that creates the container

You can say 

```bash
$ make container
```

To create the anaconda packages from the latest git hub

Than you need to log into the image and say

```bash
container$ anaconda login
```

List the available packages in 

    /opt/conda/conda-bld/linux-64/

Then you can identify the version and execute commands similar to

    export VESRION=4.0.21
    anaconda upload --user=cloudmesh /opt/conda/conda-bld/linux-64/cloudmesh-cmd5-$VERSION.tar.bz2
    anaconda upload --user=cloudmesh /opt/conda/conda-bld/linux-64/cloudmesh-common-$VERSION.tar.bz2
    anaconda upload --user=cloudmesh /opt/conda/conda-bld/linux-64/cloudmesh-common-$VERSION-py37_0.tar.bz2
    anaconda upload --user=cloudmesh /opt/conda/conda-bld/linux-64/cloudmesh-inventory-$VERSION.tar.bz2

If the versions are different, plase adapt them in the individual commands

After this the pacakes will be visible after a while in 

* <https://anaconda.org/search?q=cloudmesh>

If you see in that folder owners that are not `cloudmesh` you should not use
them. They are not officially released by us.
