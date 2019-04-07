PACKAGE=conda
VERSION=5.2.0
DOCKER=docker run -v $(CURDIR):$(CURDIR) -w $(CURDIR) cloudmesh/anaconda

conda-build:
	conda-build $(PACKAGE)

conda-install:
	conda install --use-local $(PACKAGE)

conda-all:
	conda convert --platform all ~/anaconda/conda-bld/linux-64/$(PACKAGE)-0.13.1-py27_0.tar.bz2 -o outputdir/

conda-upload:
	anaconda login
	anaconda upload ~/miniconda/conda-bld/linux-64/pyinstrument-0.12-py27_0.tar.bz

#location of file:
#~/anaconda/conda-bld/linux-64/$(PACKAGE)-0.13.1-py27_0.tar.bz2

conda-init:
	conda create -n CONDA python=3.7.1


container:
	docker build . -t cloudmesh/anaconda:latest
	@echo
	@echo "#################################################"
	@echo "# WARNING: DO NOT UPLOAD THE IMAGE TO DOCKERHUB #"
	@echo "#################################################"
	@echo
	@echo "Run it interactively with"
	@echo
	@echo "docker run -it cloudmesh/anaconda"
	@echo

#conda-container:
#	docker build . -t cloudmesh/anaconda:latest -t cloudmesh/anaconda:$(VERSION) -t cloudmesh/anaconda2:latest -t cloudmesh/anaconda2:$(VERSION)
#	docker run --rm -it cloudmesh/anaconda2:latest /bin/bash
#	docker push cloudmesh/anaconda:latest
#	docker push cloudmesh/anaconda:$(VERSION)
#	docker push cloudmesh/anaconda2:latest
#	docker push cloudmesh/anaconda2:$(VERSION)

test:
	docker run cloudmesh/anaconda conda --version
	$(DOCKER) ls
	# $(DOCKER) cms
	$(DOCKER) pip install python-hostlist
	$(DOCKER) pip install oyaml
	$(DOCKER) conda build cloudmesh-common
	$(DOCKER) conda build cloudmesh-cmd5
	$(DOCKER) conda build cloudmesh-sys
	$(DOCKER) conda build cloudmesh-inventory

shell:
	docker run -it cloudmesh/anaconda
