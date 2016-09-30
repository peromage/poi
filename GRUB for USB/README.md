# GRUB for USB

# 如何使用
- 格式化优盘为 ***FAT32*** 格式。  
- 将 **/boot/** **bootmgr** 复制到优盘根目录。  
- 复制 **/etc/** 在一台安装了 ***GRUB2*** 的 Linux 的根目录。  
- 更改所有者 `sudo chown root:root /etc/grub.d/44_usb`。  
- 更改权限 `sudo chmod 755 /etc/grub.d/44_usb`。  
- 执行 `sudo grub-install --target=i386-pc --recheck --boot-directory=/mnt/boot /dev/sdX` 。  
- 根据需要修改 **/etc/grub.d/44_usb** 。  
- 执行 `sudo grub-mkconfig -o /mnt/boot/grub/grub.cfg` 。  
- 将镜像文件放到优盘 **/boot/image/** 下。  

---

# 配置说明
## Arch Linux

* 官方给出的标准配置为：  
```
menuentry '[loopback]archlinux-2014.12.01-dual.iso' {
	set isofile='/boot/iso/archlinux-2014.12.01-dual.iso'
	loopback loop $isofile
	linux (loop)/arch/boot/x86_64/vmlinuz archisodevice=/dev/loop0 img_dev=$imgdevpath img_loop=$isofile earlymodules=loop
	initrd (loop)/arch/boot/x86_64/archiso.img
}
```

有个问题在于引导的时候会提示找不到 */dev/loop0* 从而进入 *grub rescue* 模式。  
解决的办法也很简单，删除 `archisodevice` （似乎不是必须的）。另外 `img_dev` 最好也指定设备的 UUID。  

* 我使用的配置为：  
```
menuentry "Arch Linux dual 2016.09.03" {
	set isofile="/boot/image/archlinux-2016.09.03-dual.iso"
	loopback loop $isofile
	linux (loop)/arch/boot/x86_64/vmlinuz img_dev=/dev/disk/by-uuid/3973-2EAD img_loop=$isofile earlymodules=loop
	initrd (loop)/arch/boot/x86_64/archiso.img
}
```

## Ubuntu

* 官方给出的标准配置为：  
```
 menuentry "Ubuntu 12.04 ISO" {
         set isofile="/home/<username>/Downloads/ubuntu-12.04-desktop-i386.iso"
         # or set isofile="/<username>/Downloads/ubuntu-12.04-desktop-i386.iso"
         # if you use a single partition for your $HOME
         loopback loop (hd0,5)$isofile
         linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=$isofile noprompt noeject
         initrd (loop)/casper/initrd.lz
 }
```

其中 `loopback` 时的设备位置不用特别指明，GRUB 启动的地方默认就为 root 了。  
如果此时进入 Live CD 的桌面环境安装系统会导致失败。按照官方文档，原因在于要成功安装系统必须成功卸载 */isodevice* 目录（优盘根目录）。  
解决办法为将其中一行最后加上一个参数：  
`linux /casper/vmlinuz boot=casper iso-scan/filename=/<ISO-name.iso> noprompt noeject toram --`  
其中 `toram` 的作用是试图将镜像所有文件载入到内存中，这样就可以卸载 */isodevice* 了。但如果内存不足则会失败。  
如果 `toram` 不可用，则在进入 Live CD 环境中，使用：  
`sudo umount -l -r -f /isodevice`  
尝试卸载。  
一般 `sudo umount -l /isodevice` 足矣。  

* 我使用的配置为：  
```
menuentry "Ubuntu Desktop amd64 16.04.1" {
	set isofile="/boot/image/ubuntu-16.04.1-desktop-amd64.iso"
	loopback loop $isofile
	linux (loop)/casper/vmlinuz.efi boot=casper iso-scan/filename=$isofile noprompt noeject toram --
	initrd (loop)/casper/initrd.lz
}
```

---

# 版本
## grub.cfg Ver 1.0
- 初始版本  

---

# 附录
[Github: GRUB2 Live ISO Multiboot][https://github.com/thias/glim]  
[Github: Multiboot USB][https://github.com/aguslr/multibootusb]  
[Multiboot USB drive][https://wiki.archlinux.org/index.php/Multiboot_USB_drive]  
[Grub2/ISOBoot][https://help.ubuntu.com/community/Grub2/ISOBoot]  
[Grub2/ISOBoot/Examples][https://help.ubuntu.com/community/Grub2/ISOBoot/Examples]  
[使用GRUB2引导ISO镜像][https://blog.icehoney.me/posts/2013-04-25-grub2-boot-from-iso]  
