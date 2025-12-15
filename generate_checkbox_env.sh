#!/usr/bin/env bash
set -Eeufo pipefail

echo -e "=================================="
echo -e "**Welcome to checkbox initiation**"
echo -e "=================================="

### --- CONFIGURATION ---
DEBIAN_RELEASE="trixie"
VENVDIR="$HOME/checkbox_venv"
CHECKBOX_REPO="https://github.com/canonical/checkbox.git"
#CHK_DIRECTORIES_URL="https://raw.githubusercontent.com/saubhikdattagithub/public/main/chkbx_directories.zip"
CHK_DIRECTORIES_URL="https://raw.githubusercontent.com/saubhikdattagithub/public/main/providers_directory_working_v5.0.zip"

### --- FUNCTIONS ---
ask_provider() {
    read -rp "Enter provider identifier [default: 1234.gardenlinux.certification:ccloud]: " input
    echo -e "Eg. 2024.gardenlinux.certification"
    PROVIDER="${input}:ccloud"
    echo "==> Using provider: $PROVIDER"
}


configure_dns() {
    echo "==> Configuring DNS..."
    echo "nameserver 8.8.8.8" | tee /etc/resolv.conf >/dev/null
}

configure_sources() {
    echo "==> Configuring APT sources..."
    cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian ${DEBIAN_RELEASE} main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian ${DEBIAN_RELEASE} main contrib non-free non-free-firmware

deb http://deb.debian.org/debian ${DEBIAN_RELEASE}-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian ${DEBIAN_RELEASE}-updates main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security ${DEBIAN_RELEASE}-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security ${DEBIAN_RELEASE}-security main contrib non-free non-free-firmware
EOF
}

install_packages() {
    echo "==> Installing required packages..."
    apt-get clean
    rm -rf /var/lib/apt/lists/*
    apt-get update -q

    local packages=(
        snapd python3 python3-pip python3-setuptools python3-wheel
        git unzip usbutils pciutils lshw dmidecode hdparm smartmontools
        util-linux parted iproute2 iputils-ping net-tools ethtool curl debsums
        ipmitool wget sysstat stress stress-ng memtester acpid acpi-support-base
        acpi-call-dkms i2c-tools lm-sensors iozone3 python3-serial systemd-sysv
        dosfstools exfatprogs xfsprogs e2fsprogs btrfs-progs f2fs-tools upower
        powermgmt-base pulseaudio alsa-utils sox v4l-utils efibootmgr apparmor
        apparmor-utils fwupd fwupd-signed tree file jq xxd bash-completion
        libfile-fnmatch-perl iperf iperf3 nmap python3-natsort lxc bc
        ntpsec-ntpdate netcat-traditional w3m python3-virtualenv zip rsyslog
        cpanminus
    )

    DEBIAN_FRONTEND=noninteractive apt-get install -yq --fix-missing "${packages[@]}"
}

configure_profile() {
    echo "==> Updating profile..."
    cat <<'EOF' >> ~/.profile
alias chkcli='checkbox-cli'
alias chkv='cd ~/checkbox/checkbox-ng && . ../../checkbox_venv/bin/activate && cd ../providers'
alias ll='ls -lrth'
alias vim='vim -u NONE -N'
export STRESS_NG_DISK_TIME=60
export STRESS_NG_CPU_TIME=60
EOF
    source ~/.profile
}

configure_logging() {
    echo "==> Configuring rsyslog..."
    mkdir -p /var/log/installer
    touch /var/log/installer/testingfile
    echo "kern.*   -/var/log/kern.log" >> /etc/rsyslog.conf
    systemctl enable --now rsyslog
}

setup_checkbox_venv() {
    echo "==> Setting up Checkbox in venv..."
        
    # first install python3 and python3-venv
    $ sudo apt install python3 python3-virtualenv python3-pip
    # clone the Checkbox repository
    git clone "$CHECKBOX_REPO" ~/checkbox
    git checkout tags/v5.0.0 -b v5.0.0
    
    cd checkbox/checkbox-ng
    ./mk-venv ../../checkbox_venv
    # Activate the virtual environment
    . ../../checkbox_venv/bin/activate
    
    # Install checkbox_support, it is a collection of utility scripts used by
    # many tests
    (checkbox_venv) $ cd ../checkbox-support
    (checkbox_venv) $ pip install -e .
    # Install the resource provider, we will use it further along in this tutorial
    (checkbox_venv) $ cd ../providers/resource
    (checkbox_venv) $ python3 manage.py develop

    cd ~/checkbox/providers
    "$VENVDIR/bin/checkbox-cli" startprovider "$PROVIDER"

    cd "$PROVIDER"
    python3 manage.py develop

    source "$VENVDIR/bin/activate"

    wget --show-progress "$CHK_DIRECTORIES_URL" -O /home/providers_directory_working_v5.0.zip
    mv ~/checkbox/providers ~/checkbox/providers.ORIG
    unzip -o /home/providers_directory_working_v5.0.zip -d "~/checkbox/"
}

validate_install() {
    echo "==> Validating installation..."
    cat <<EOF > /tmp/venvactivate
source $VENVDIR/bin/activate
EOF
    source /tmp/venvactivate && chkv
    if chkcli list "all-jobs" | grep -q dmesg_output; then
        echo "✅ Checkbox in Python venv installed successfully"
    else
        echo "⚠️  Validation failed, please check installation manually"
    fi
}

### --- MAIN EXECUTION FLOW ---
ask_provider
configure_dns
configure_sources
install_packages
configure_profile
configure_logging
setup_checkbox_venv
validate_install
