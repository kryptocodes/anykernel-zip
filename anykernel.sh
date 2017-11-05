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
chmod -R 750 $ramdisk/*;
chmod 644 $ramdisk/init.spectrum.rc
chmod 644 $ramdisk/init.spectrum.sh
chmod -R root:root $ramdisk/*;

## Alert of unsupported Android version
android_ver=$(mount /system; grep "^ro.build.version.release" /system/build.prop | cut -d= -f2; umount /system);
case "$android_ver" in
  "5.0"|"5.1.1"|"6.0"|"6.0.1"|"7.0"|"7.1"|"7.1.1"|"7.1.2") compatibility_string="Your version is unsupported, Your device will not boot!";;
  "8.0.0"|"8.0"|"8") compatibility_string="Your version is supported!";;
esac;
rom=$(mount /system; grep "^ro.modversion" /system/build.prop | cut -d= -f2; umount /system);
ui_print "***************************************";
ui_print "Running $rom";
ui_print "Android $android_ver";
ui_print "*$compatibility_string";
ui_print "***************************************";
=======
## AnyKernel file attributes
# set permissions/ownership for included ramdisk files

>>>>>>> 8decdd4624c7bcb82ce72a516d1c9e97aabe7c32


## AnyKernel install
dump_boot;

<<<<<<< HEAD
#Add Spectrum Profile
 ui_print "Pushing Spectrum Profiles...";
found=$(find init.rc -type f | xargs grep -oh "import /init.spectrum.rc");
if [ "$found" != 'import /init.spectrum.rc' ]; then
	#append the new lines for this option at the bottom
        echo "" >> init.rc
	echo "import /init.spectrum.rc" >> init.rc
fi
ui_print "***************************************";
ui_print "Installing kernel...";
=======
# begin ramdisk changes

# init.rc
backup_file init.rc;
replace_string init.rc "cpuctl cpu,timer_slack" "mount cgroup none /dev/cpuctl cpu" "mount cgroup none /dev/cpuctl cpu,timer_slack";
append_file init.rc "run-parts" init;

# init.tuna.rc
backup_file init.tuna.rc;
insert_line init.tuna.rc "nodiratime barrier=0" after "mount_all /fstab.tuna" "\tmount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/userdata /data remount nosuid nodev noatime nodiratime barrier=0";
append_file init.tuna.rc "dvbootscript" init.tuna;

# fstab.tuna
backup_file fstab.tuna;
patch_fstab fstab.tuna /system ext4 options "noatime,barrier=1" "noatime,nodiratime,barrier=0";
patch_fstab fstab.tuna /cache ext4 options "barrier=1" "barrier=0,nomblk_io_submit";
patch_fstab fstab.tuna /data ext4 options "data=ordered" "nomblk_io_submit,data=writeback";
append_file fstab.tuna "usbdisk" fstab;

# end ramdisk changes

>>>>>>> 8decdd4624c7bcb82ce72a516d1c9e97aabe7c32
write_boot;

## end install

