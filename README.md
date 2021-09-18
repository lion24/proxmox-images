# proxmox-images
Images tailored for Proxmox using DIB

# Why ?

Most of the availables cloud images are tailored for Openstack / AWS CloudFormation and other big cloud providers.
Since for Proxmox, the cloud-init userdatas are exposed to the VM as a ConfigDrive which is generally not the most
common deployement in cloud providers and it can cause trouble setting up the VM.

Some features like qemu-guest-agent are also often missing with is required in order to retrieve VM information on
the Proxomx GUI.

So the VM build from this repo should "just work" with Proxmox :)

Starting with ubuntu, planning to add centos, fedora and debian. Feel free to contribue :)

# How to build

Only ubuntu image is supported for now.

1. Ensure docker is installed on your machine.
2. Execute the `build.sh` script, it does not require any argument.
3. Enjoy a coffee since it could be pretty long depending on your internet speed.
4. Enjoy your freshly qcow2 image :)

# TODO

- [ ] Build centos7-8 template
- [ ] Build fedora template
- [ ] Build debian template
- [ ] Integrate github actions to automatically build images