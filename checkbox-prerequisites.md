<pre>
  

cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian trixie main contrib non-free non-free-firmware

deb http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
EOF

echo "export STRESS_NG_DISK_TIME=60s" >> /root/.profile
echo "alias ll='ls -lrth'" >> /root/.profile
echo "export STRESS_NG_CPU_TIME=60s" >> /root/.profile


echo "deb http://ftp.de.debian.org/debian trixie main " >> /etc/apt/sources.list


apt update
sudo apt install -y \
 snapd \
 python3 \
 python3-pip \
 python3-setuptools \
 python3-wheel \
 git \
 unzip \
 usbutils \
 pciutils \
 lshw \
 dmidecode \
 hdparm \
 smartmontools \
 util-linux \
 parted \
 iproute2 \
 iputils-ping \
 net-tools \
 ethtool \
 curl \
 snapd \
 debsums \
 ipmitool \
 wget \
 sysstat \
 stress \
 stress-ng \
 memtester \
 acpid \
 acpi-support-base \
 acpi-call-dkms \
 i2c-tools \
 lm-sensors \
 iozone3 \
 python3-serial \
 systemd-sysv \
 dosfstools \
 exfatprogs \
 xfsprogs \
 e2fsprogs \
 btrfs-progs \
 f2fs-tools \
 upower \
 powermgmt-base \
 pulseaudio \
 alsa-utils \
 sox \
 v4l-utils \
 efibootmgr \
 apparmor \
 apparmor-utils \
 fwupd \
 fwupd-signed \
 dmidecode \
 tree \
 file \
 jq \
 xxd \
 bash-completion \
 libfile-fnmatch-perl \
 cpanminus
sudo cpanm File::FnMatch

snap install --beta --devmode fwts
</pre>
