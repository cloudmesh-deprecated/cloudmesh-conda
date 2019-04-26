PACKAGE=conda
VERSION=5.2.0
DOCKER=docker run -v $(CURDIR):$(CURDIR) -w $(CURDIR) cloudmesh/anaconda
OPT=/opt/conda/conda-bld/linux-64

define banner
	@echo
	@echo "############################################################"
	@echo "# $(1) "
	@echo "############################################################"
endef

update:
	anaconda login
	./update.sh

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
	#$(DOCKERrun ) pip install python-hostlist
	#$(DOCKER) pip install oyaml

	$(call banner, "COMMON")
	$(DOCKER) conda build cloudmesh-common

	$(call banner, "CMD5")
	$(DOCKER) conda build cloudmesh-cmd5

	$(call banner, "SYS")
	$(DOCKER) conda build cloudmesh-sys

	$(call banner, "INVENTORY")
	$(DOCKER) conda build cloudmesh-inventory

shell:
	docker run --rm --name=conda -it cloudmesh/anaconda

login:
	docker run --name=conda cloudmesh/anaconda anaconda login --username $(USERNAME) --password $(PASSWORD)

upload:
	@$(DOCKER) ls /opt/conda/conda-bld/linux-64 > /tmp/files-tmp.txt
	@fgrep tar /tmp/files-tmp.txt > /tmp/files.txt
	@while read -r file; do \
	$(DOCKER) anaconda upload --user=cloudmesh $(OPT)/$$file ; \
	done < /tmp/files.txt

#
#  EXPERIMENTAL FROM HERE ON
#


upload-sample-broken:
	$(DOCKER) anaconda upload --user=cloudmesh $(OPT)/cloudmesh-cmd5-4.0.21-0.tar.bz2
	$(DOCKER) anaconda upload --user=cloudmesh $(OPT)/cloudmesh-common-4.0.21-py37_0.tar.bz2
	$(DOCKER) anaconda upload --user=cloudmesh $(OPT)/cloudmesh-inventory-4.0.21-0.tar.bz2
	$(DOCKER) anaconda upload --user=cloudmesh $(OPT)/cloudmesh-sys-4.0.21-0.tar.bz2

notes:
	anaconda login
    anaconda upload --user=cloudmesh /opt/conda/conda-bld/linux-64/cloudmesh-cmd5-4.0.21-0.tar.bz2
    anaconda upload --user=cloudmesh /opt/conda/conda-bld/linux-64/cloudmesh-common-4.0.21-0.tar.bz2
    anaconda upload --user=cloudmesh /opt/conda/conda-bld/linux-64/cloudmesh-common-4.0.21-py37_0.tar.bz2
    anaconda upload --user=cloudmesh /opt/conda/conda-bld/linux-64/cloudmesh-inventory-4.0.21-0.tar.bz2

clean:
	docker image rm cloudmesh/anaconda --force
	docker system prune -f

