
ENDPOINTS := $(wildcard endpoints/*)
DOCKER := $(shell command -v docker 2> /dev/null)
DOCKERCOM := $(shell command -v docker-compose 2> /dev/null)

all: clean build

clean:
	rm -rf ./conf.d
	rm -f ./api-gateway

check:
	@echo "No tests available"

build: clean $(ENDPOINTS)
ifndef DOCKER
	$(error "docker not available, please install docker")
endif

ifndef DOCKERCOM
	$(error "docker-compose not available, please install docker-compose")
endif
	docker-compose build
	chcon -Rt svirt_sandbox_file_t ./conf.d
	echo -e "#!/bin/bash\ndocker-compose up" > ./api-gateway
	chmod 744 ./api-gateway

$(ENDPOINTS):
	mkdir -p ./conf.d
	cp $@/httpd/*.conf ./conf.d/

.PHONY: all build check setup clean $(ENDPOINTS)
