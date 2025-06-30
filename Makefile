CC = ccache clang
CFLAGS = -static -O3 -Wall
all: init cpio
run:
	qemu-system-x86_64 axisIMG -m 2G
cpio: init.cpio.gz
	cd initramfs && find . | cpio -c -H newc | gzip > ../init.cpio.gz
	dd if=/dev/zero of=axisIMG bs=1M count=300
	mkfs -t fat axisIMG
	syslinux axisIMG
	mkdir mnt
	sudo mount axisIMG mnt
	sudo cp AXISLinux inti.cpio.gz syslinux.cfg mnt
	sudo umount mnt

init: init.c
	$(CC) $(CFLAGS) -o initramfs/sbin/init init.c


.PHONY: clean