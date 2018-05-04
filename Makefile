
TARGET_DIR := /cases/normal_exit

build:
	docker build -f envs/alpine/Dockerfile -t tiny-rc_alpine .
	docker build -f envs/centos/Dockerfile -t tiny-rc_centos .
	docker build -f envs/debian/Dockerfile -t tiny-rc_debian .
	docker build -f envs/ubuntu/Dockerfile -t tiny-rc_ubuntu .

run-alpine:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d --env-file docker.env --rm tiny-rc_alpine $(TARGET_DIR)/app.sh

run-alpine-it:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d --env-file docker.env --rm -it tiny-rc_alpine $(TARGET_DIR)/app.sh

run-centos:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d --env-file docker.env --rm tiny-rc_centos $(TARGET_DIR)/app.sh

run-centos-it:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d --env-file docker.env --rm -it tiny-rc_centos $(TARGET_DIR)/app.sh

run-debian:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d --env-file docker.env --rm tiny-rc_debian $(TARGET_DIR)/app.sh

run-debian-it:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d --env-file docker.env --rm -it tiny-rc_debian $(TARGET_DIR)/app.sh

run-ubuntu:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d --env-file docker.env --rm tiny-rc_ubuntu $(TARGET_DIR)/app.sh

run-ubuntu-it:
	docker run -e TINYRC_INIT_DIR=$(TARGET_DIR)/tiny-rc.d --env-file docker.env --rm -it tiny-rc_ubuntu $(TARGET_DIR)/app.sh

run-alpine-all:
	@-make run-alpine TARGET_DIR=/cases/normal_exit
	@-make run-alpine TARGET_DIR=/cases/error_main
	@-make run-alpine TARGET_DIR=/cases/error_unit
	@-make run-alpine TARGET_DIR=/cases/error_service
	@-make run-alpine TARGET_DIR=/cases/error_shutdown
	@-make run-alpine TARGET_DIR=/cases/file_not_found
	@-make run-alpine TARGET_DIR=/cases/error_mainonly

run-centos-all:
	@-make run-centos TARGET_DIR=/cases/normal_exit
	@-make run-centos TARGET_DIR=/cases/error_main
	@-make run-centos TARGET_DIR=/cases/error_unit
	@-make run-centos TARGET_DIR=/cases/error_service
	@-make run-centos TARGET_DIR=/cases/error_shutdown
	@-make run-centos TARGET_DIR=/cases/file_not_found
	@-make run-centos TARGET_DIR=/cases/error_mainonly

run-debian-all:
	@-make run-debian TARGET_DIR=/cases/normal_exit
	@-make run-debian TARGET_DIR=/cases/error_main
	@-make run-debian TARGET_DIR=/cases/error_unit
	@-make run-debian TARGET_DIR=/cases/error_service
	@-make run-debian TARGET_DIR=/cases/error_shutdown
	@-make run-debian TARGET_DIR=/cases/file_not_found
	@-make run-debian TARGET_DIR=/cases/error_mainonly

run-ubuntu-all:
	@-make run-ubuntu TARGET_DIR=/cases/normal_exit
	@-make run-ubuntu TARGET_DIR=/cases/error_main
	@-make run-ubuntu TARGET_DIR=/cases/error_unit
	@-make run-ubuntu TARGET_DIR=/cases/error_service
	@-make run-ubuntu TARGET_DIR=/cases/error_shutdown
	@-make run-ubuntu TARGET_DIR=/cases/file_not_found
	@-make run-ubuntu TARGET_DIR=/cases/error_mainonly
