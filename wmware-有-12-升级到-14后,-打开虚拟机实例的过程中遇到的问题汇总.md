* How to fix “vmci.sys is incorrect” in Vmware workstation/player
  
  解决方法为, 在该虚拟机实例的配置文件中, 将 vmci0.present = "true" 替换为 vmci0.present = "false"

参考:
http://agrtech.com.au/windows/fix-vmci-sys-incorrect-vmware-workstationplayer/#ixzz4zY7BNL9v

http://blog.csdn.net/indexman/article/details/35778033


* 解决VMWARE NAT SERVICE服务无法启动或服务消失的问题, 表现我所有使用 NAT 连接网络的虚拟机无法上网了.

解决法案:

打开VMware的虚拟网络编辑器，选择“还原默认设置”，这时它会自动删除所有的VMware网络服务和虚拟网卡并且重新安装，

参考:

https://www.cnblogs.com/sunshineyang/p/5939434.html

* 提示: vmware fusion is unable to provide all the graphic features expected by this vm

原因: 升级前虚拟机实例并没有完全关机.

解决方案: 强制关机, 然后重启

参考:

https://communities.vmware.com/thread/335306


