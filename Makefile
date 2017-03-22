
ENDPOINTS := $(wildcard endpoints/*)
DOCKER := $(shell command -v docker 2> /dev/null)
DOCKERCOM := $(shell command -v docker-compose 2> /dev/null)

all: clean build

clean:
	rm -rf ./conf.d
	rm -f ./api

setup:
	mkdir ./conf.d

pre-build:
ifndef DOCKER
	$(error "docker not available, please install docker")
endif

ifndef DOCKERCOM
	$(error "docker-compose not available, please install docker-compose")
endif

post-build:
	docker-compose build
	chcon -Rt svirt_sandbox_file_t ./conf.d
	echo -e "#!/bin/bash\ndocker-compose up" > ./api
	chmod 744 ./api

build: pre-build clean setup $(ENDPOINTS) post-build

$(ENDPOINTS):
	cp $@/httpd/*.conf ./conf.d/

.PHONY: all pre-build build post-build setup clean $(ENDPOINTS)
