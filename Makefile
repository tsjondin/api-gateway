
ENDPOINTS := $(wildcard endpoints/*)
DOCKER := $(shell command -v docker 2> /dev/null)
DOCKERCOM := $(shell command -v docker-compose 2> /dev/null)

pre-build:
ifndef DOCKER
	$(error "docker not available, please install docker")
endif

ifndef DOCKERCOM
	$(error "docker-compose not available, please install docker-compose")
endif

clean:
	rm -rf ./conf.d
	rm -f ./pgi

setup:
	mkdir ./conf.d

post-build:
	docker-compose build
	chcon -Rt svirt_sandbox_file_t ./conf.d
	echo -e "#!/bin/bash\ndocker-compose up" > ./pgi
	chmod 744 ./pgi

build: pre-build clean setup $(ENDPOINTS) post-build

$(ENDPOINTS):
	cp $@/httpd/*.conf ./conf.d/

.PHONY: all $(ENDPOINTS)
