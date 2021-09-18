.PHONY: image deps ubuntu

IMAGE_NAME_UBUNTU = ubuntu

DISK_FORMAT ?= qcow2
UBUNTU_VARIANT ?= focal
TARGET_PLATFORM ?= amd64
ARCH ?= amd64

DISK_IMAGE_CREATE = \
	ELEMENTS_PATH=./elements \
	DIB_IMAGE_CACHE=$(XDG_CACHE_HOME)/dib-image-cache \
	DIB_LOCKFILES=$(XDG_CACHE_HOME)/dib-lockfiles \
	nice -n19 ionice -c2 -n7 disk-image-create

BASE_CONFIG = \
	DIB_GRUB_TIMEOUT=0 \
	DIB_CLOUD_INIT_DATASOURCES="NoCloud, ConfigDrive"

BASE_ELEMENTS = \
	vm \
	cloud-init \
	cloud-init-datasources \
	enable-serial-console \
	qemu-guest-agent

UBUNTU_ELEMENTS = \
	$(BASE_ELEMENTS) \
	ubuntu

all: images

deps:
	docker build -t dib .

ubuntu:
	# It seems while running this from my M1 macbook it ends up with a grub error.
	# Workaround is to uncomment the next line forcing GRUB_OPTS to the defined target and comment the next line.
	# See: https://bugs.launchpad.net/diskimage-builder/+bug/1943363
	#DIB_RELEASE=$(UBUNTU_VARIANT) $(BASE_CONFIG) GRUB_OPTS="--target=i386-pc" $(DISK_IMAGE_CREATE) -a $(TARGET_PLATFORM)
	ARCH=$(ARCH) DIB_RELEASE=$(UBUNTU_VARIANT) $(BASE_CONFIG) $(DISK_IMAGE_CREATE) -a $(TARGET_PLATFORM) \
		    -t $(DISK_FORMAT) -o $@-$(UBUNTU_VARIANT).$(DISK_FORMAT) \
		    $(UBUNTU_ELEMENTS)

images: ubuntu
