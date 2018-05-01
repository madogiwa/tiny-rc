
TARGET_DIR := /cases/normal_exit

build:
	docker build -f envs/alpine/Dockerfile -t tiny-rc_alpine .
	docker build -f envs/centos/Dockerfile -t tiny-rc_centos .
	docker build -f envs/debian/Dockerfile -t tiny-rc_debian .
	docker build -f envs/ubuntu/Dockerfile -t tiny-rc_ubuntu .

run-alpine:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d -e TINYRC_LOG_LEVEL=9 --rm tiny-rc_alpine $(TARGET_DIR)/app.sh

run-alpine-it:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d -e TINYRC_LOG_LEVEL=9 -it --rm tiny-rc_alpine $(TARGET_DIR)/app.sh

run-centos:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d -e TINYRC_LOG_LEVEL=9 --rm tiny-rc_centos $(TARGET_DIR)/app.sh

run-centos-it:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d -e TINYRC_LOG_LEVEL=9 -it --rm tiny-rc_centos $(TARGET_DIR)/app.sh

run-debian:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d -e TINYRC_LOG_LEVEL=9 --rm tiny-rc_debian $(TARGET_DIR)/app.sh

run-debian-it:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d -e TINYRC_LOG_LEVEL=9 -it --rm tiny-rc_debian $(TARGET_DIR)/app.sh

run-ubuntu:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d -e TINYRC_LOG_LEVEL=9 --rm tiny-rc_ubuntu $(TARGET_DIR)/app.sh

run-ubuntu-it:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d -e TINYRC_LOG_LEVEL=9 -it --rm tiny-rc_ubuntu $(TARGET_DIR)/app.sh
