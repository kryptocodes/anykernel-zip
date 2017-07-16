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

## Alert of unsupported Android version
android_ver=$(mount /system; grep "^ro.build.version.release" /system/build.prop | cut -d= -f2; umount /system);
case "$android_ver" in
  "5.0"|"5.1.1") compatibility_string="Your version is unsupported, Your device will not boot!";;
  "6.0"|"6.0.1"|"7.0"|"7.1"|"7.1.1"|"7.1.2") compatibility_string="Your version is supported!";;
esac;
rom=$(mount /system; grep "^ro.modversion" /system/build.prop | cut -d= -f2; umount /system);
ui_print "Running $rom Android $android_ver, $compatibility_string";

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

