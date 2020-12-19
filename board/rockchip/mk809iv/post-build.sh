#!/bin/sh

BOARD_DIR="$(dirname $0)"

#Finish building bootloader

# Copy Magic
cp -av "$BOARD_DIR/magic.img" $BINARIES_DIR/

# Assemble idbloader.img
$BOARD_DIR/../../../output/build/uboot-custom/tools/mkimage -n rk322x -T rksd -d "$BOARD_DIR/../../../output/build/host-rkbin-991d0e441c74f93813e6a2b7e8d6ef8a136985ad/rk32/rk322x_ddr3_600MHz_ddr2_330MHz_v1.10.bin" idbloader.img
cat "$BOARD_DIR/../../../output/build/host-rkbin-991d0e441c74f93813e6a2b7e8d6ef8a136985ad/rk32/rk322x_miniloader_v2.56.bin" >> idbloader.img
cp -av idbloader.img $BINARIES_DIR/
rm idbloader.img

# Assemble uboot.img
$BOARD_DIR/../../../output/build/uboot-custom/tools/loaderimage --pack --uboot "$BOARD_DIR/../../../output/build/uboot-custom/u-boot-dtb.bin" u-boot.img "0x60200000"
cp -av u-boot.img $BINARIES_DIR/
rm u-boot.img

# Assemble trust.img
$BOARD_DIR/../../../output/build/uboot-custom/tools/loaderimage --pack --trustos "$BOARD_DIR/../../../output/build/host-rkbin-991d0e441c74f93813e6a2b7e8d6ef8a136985ad/rk32/rk3228_tee_ta-51.1.0-333-gc9d95d1.bin" trust.img "0x68400000"
cp -av trust.img $BINARIES_DIR/
rm trust.img


install -m 0644 -D $BOARD_DIR/extlinux.conf $BINARIES_DIR/extlinux/extlinux.conf
