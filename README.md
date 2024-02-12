# calixto-rz-atf


### Build Commands: ATF (release) can be built by giving the following command:

```shell
make -j$(nproc) PLAT=g2l BOARD=CALIXTO_RZG2L_VERSA_1GB all
```
### ATF (debug) instead:

```shell
make -j$(nproc) PLAT=g2l BOARD=CALIXTO_RZG2L_VERSA_1GB DEBUG=1 all
```
Binaries (bl2.bin and bl31.bin) are located in the build/g2l/release|debug folder.

We have to combine bl2.bin with boot parameters, we can use this simple bash script to do that:

[bootp.sh](https://github.com/eaglelinuxplatform/calixto-rz-atf/blob/v2.7/rz/build/g2l/release/bootp.sh)

run this script by using 

```shell
./bootp.sh
```

Make the fip creation tool:

```shell
cd tools/fiptool
make -j$(nproc) plat=g2l
```
Now we can create the fip file by combining the bl31.bin and u-boot.bin (refer to this section and copy the .bin in the ATF root folder):

```shell
cd ../..
tools/fiptool/fiptool create --align 16 --soc-fw build/g2l/release|debug/bl31.bin --nt-fw u-boot.bin fip.bin
```
bl2_bp.bin and fip.bin are the files that have to be programmed using Flash Writer. Actually .srec may be more handy, they can be converted by using the following commands:

```shell
${CROSS_COMPILE}objcopy -I binary -O srec --adjust-vma=0x00011E00 --srec-forceS3 bl2_bp.bin bl2_bp.srec
${CROSS_COMPILE}objcopy -I binary -O srec --adjust-vma=0x00000000 --srec-forceS3 fip.bin fip.srec
```
ATF BL2 is what you more often might need to debug, since this is the part that includes most of the system specific options. Obviously it is possible to use the various log options (INFO, NOTICE, DEBUG, etc), however especially during the first stages or if something is difficult to catch, it might be just more convenient to use a JTAG debugger and OpenOCD. In this way you do not need to reflash the bootloaders every time since the new image is just loaded in the internal RAM directly. 
