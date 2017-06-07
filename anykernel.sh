# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
do.devicecheck=1
do.modules=1
do.cleanup=1
do.cleanuponabort=0
device.name1=YUREKA
device.name2=YU5510
device.name3=A05510
device.name4=tomato
device.name5=
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 755 $ramdisk
chmod 644 $ramdisk/init.spectrum.rc
chmod 644 $ramdisk/init.spectrum.sh

## AnyKernel install
dump_boot;

#Add Spectrum Profile
 ui_print "Pushing Spectrum Profiles...";
found=$(find init.rc -type f | xargs grep -oh "import /init.spectrum.rc");
if [ "$found" != 'import /init.spectrum.rc' ]; then
	#append the new lines for this option at the bottom
        echo "" >> init.rc
	echo "import /init.spectrum.rc" >> init.rc
fi

write_boot;

## end install

