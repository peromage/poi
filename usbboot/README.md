# GRUB for USB
## Boot from any iso file

# For BIOS + MBR or BIOS + GPT
### Extra Step for BIOS + GPT
- Use disk tool like **fdisk** or **parted** to create a protective MBR partition (+1M) without file system on it and mark it as `BIOS BOOT` or with GUID `21686148-6449-6E6F-744E-656564454649`. This partition can be put in any place on the disk but it is recommended to put it at the begginning from sector 34 to 2047.
### Common procedures
1. Create a big enough partition with file system **FAT32** where the GRUB modules and configuration files will be placed.
2. Mount the partition and in reminder of this section, substitute *PART* with its mount point.
3. `grub-install --recheck --target=i386-pc --boot-directory=PART /dev/sdx`
4. Copy **memdisk** from Syslinux to *PART/*
5. Modify any custom config file under */etc/grub.d/*
```
menuentry "Boot from iso" {
	# if on ntfs with compression on
	insmode ntfscomp
	# set partition
	search --set=part --no-floppy --fs-uuid UUID_OF_PARTITION_CONTAINING_ISO
	# or search based on files
	# search --set=part --no-floppy --file PATH_TO_FILE
	linux16 PATH_TO_MEMDISK iso ro
	initrd16 ($part)/PATH_TO_ISO
}
```
6. `grub-mkconfig -o PART/grub/grub.cfg`
7. Then it should be working.
---

# For UEFI + MBR or UEFI + GPT
1. Create a partition at least 256M (550M recommended). Mark it as `EFI System Partition` and format it with **FAT32** file system.
2. Mount the partition and in reminder of this section, substitute *PART* with its mount point.
3. `grub-install --recheck --target=x86_64-efi --efi-directory=PART --boot-directory=PART --bootloader-id=GRUB`
4. Copy **memdisk** from Syslinux to *PART/*
5. Modify any custom config file under */etc/grub.d/*
```
menuentry "Boot from iso" {
	# if on ntfs with compression on
	insmode ntfscomp
	# set partition
	search --set=part --no-floppy --fs-uuid UUID_OF_PARTITION_CONTAINING_ISO
	# or search based on files
	# search --set=part --no-floppy --file PATH_TO_FILE
	linux16 PATH_TO_MEMDISK iso ro
	initrd16 ($part)/PATH_TO_ISO
}
```
6. `grub-mkconfig -o PART/grub/grub.cfg`
7. Then it should be working.
---

# For Compatible with both BIOS and UEFI
For convenience, substitute *pmbr* with Protective MBR and *esp* with EFI System Partition.
### For MBR
1. Follow **all** instructions of **For UEFI + MBR or UEFI + GPT**.
2. Follow **common** instructions of **For BIOS + MBR or BIOS + GPT** doing all operations on the *esp*.
### For GPT
1. Follow **extra** instructions of **For BIOS + MBR or BIOS + GPT** to create *pmbr*.
2. Follow **all** instructions of **For UEFI + MBR or UEFI + GPT**.
3. Follow **common** instructions of **For BIOS + MBR or BIOS + GPT** doing all operations on the *esp*.
---


# Credits
[BIOS + GPT + GRUB + Linux + Windows 折腾笔记](https://wzyboy.im/post/1049.html)  
[Arch Linux Wiki: GRUB](https://wiki.archlinux.org/index.php/GRUB)  
[Arch Linux Wiki: EFI system partition](https://wiki.archlinux.org/index.php/EFI_system_partition)  
[Wiki: GUID Partition Table](https://en.wikipedia.org/wiki/GUID_Partition_Table)  