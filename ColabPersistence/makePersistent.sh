#!/bin/bash
#%%bash
# The directory to store the persistence files. Will create intermediate directories that don't exist.
# Be sure to change this for each different VM!
if [[ "$1" == "" ]]; then
  echo "Error: please provide a datastore path."
fi
PERSISTENCE_DIR="$1"


if ! [[ -d "/mnt/drive/MyDrive" ]]; then
  echo "Error: You must mount your Google Drive at /mnt/drive to run this script!"
fi

cd /tmp
echo "Downloading mergerfs..."
wget 'https://github.com/trapexit/mergerfs/releases/download/2.33.5/mergerfs_2.33.5.ubuntu-bionic_amd64.deb' 2>/dev/null
echo "Installing mergerfs..."
apt install -y ./mergerfs_2.33.5.ubuntu-bionic_amd64.deb &> /dev/null
echo "Installing mergerfs dependencies..."
apt --fix-broken install &> /dev/null
cd /content

# Set up chroot web...
datastore="$PERSISTENCE_DIR"
echo "Chrooting:"
for DIR in {content,boot,python-apt,sbin,bin,srv,home,tools,datalab,lib32,lib64,usr,opt,lib/firmware,lib/init,lib/lsb,lib/modprobe.d,lib/modules,lib/systemd,lib/terminfo,lib/udev}; do
  echo -n "/$DIR, "
  mkdir -p "/sysFileLinks/$DIR"
  mkdir -p "$datastore/$DIR"
  mount --rbind "/$DIR" "/sysFileLinks/$DIR" && mergerfs -o defaults,allow_other,use_ino,nonempty,category.create=ff,category.action=ff,category.search=ff "$datastore/$DIR:/sysFileLinks/$DIR" "/$DIR"
done
echo
echo "Done"