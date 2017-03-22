
ENDPOINTS := $(wildcard endpoints/*)
DOCKER := $(shell command -v docker 2> /dev/null)
DOCKERCOM := $(shell command -v docker-compose 2> /dev/null)

all: clean build

clean:
	rm -rf ./conf.d
	rm -f ./api-gateway

pre-build:
ifndef DOCKER
	$(error "docker not available, please install docker")
endif

ifndef DOCKERCOM
	$(error "docker-compose not available, please install docker-compose")
endif
	mkdir ./conf.d

build: clean pre-build $(ENDPOINTS)
	docker-compose build
	chcon -Rt svirt_sandbox_file_t ./conf.d
	echo -e "#!/bin/bash\ndocker-compose up" > ./api-gateway
	chmod 744 ./api-gateway

$(ENDPOINTS):
	cp $@/httpd/*.conf ./conf.d/

.PHONY: all pre-build build setup clean $(ENDPOINTS)
