=========== Showing the content of com.canonical.certification::package
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:109-117
id: package
estimated_duration: 1.16
plugin: resource
category_id: information_gathering
command:
  #shellcheck disable=SC2016
  dpkg-query -W -f='name: ${Package}\nversion: ${Version}\n\n' || true
_description: Generates a list of packages
_summary: Collect information about installed software packages

========
=========== Showing the content of com.canonical.certification::miscellanea/apport-directory
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:278-284
plugin: shell
category_id: com.canonical.plainbox::miscellanea
id: miscellanea/apport-directory
requires: package.name == 'apport'
command: if [ -d /var/crash ]; then if [ "$(find /var/crash -type f | grep -c -v .lock)" -eq 0 ]; then echo "/var/crash is empty"; else ls /var/crash; false; fi; else echo "/var/crash does not exist"; fi
_purpose: Test that the /var/crash directory doesn't contain anything. Lists the files contained within if it does, or echoes the status of the directory (doesn't exist/is empty).
_summary: Check the /var/crash directory's status and contents.

========
=========== Showing the content of com.canonical.certification::executable
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:128-135
id: executable
estimated_duration: 0.78
plugin: resource
category_id: information_gathering
_summary: Enumerate available system executables
_description: Generates a resource for all available executables
command:
  xargs -n1 -d: <<< "$PATH" | xargs -I{} find -H {} -maxdepth 1 -xtype f -executable -printf "name: %f\n\n" 2> /dev/null | sort -u | awk '{print}' ORS='\n\n' || true

========
=========== Showing the content of com.canonical.certification::cpuinfo
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:50-57
id: cpuinfo
estimated_duration: 0.37
plugin: resource
category_id: information_gathering
user: root
command: cpuinfo_resource.py
_summary: Collect information about the CPU
_description: Gets CPU resource info from /proc/cpuinfo

========
=========== Showing the content of com.canonical.certification::miscellanea/bmc_info
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:212-225
plugin: shell
category_id: com.canonical.plainbox::miscellanea
id: miscellanea/bmc_info
requires:
 executable.name == 'ipmitool'
 cpuinfo.platform != 's390x'
estimated_duration: 0.5
user: root
command: bmc_info.py
_purpose:
 This will gather some information about the BMC itself for diagnostic purposes. This
 will not work on non-IPMI systems like AMT and blade/sled type systems.
_summary:
 Gather BMC identification info

========
=========== Showing the content of com.canonical.certification::lsb
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:76-82
id: lsb
estimated_duration: 1.63
plugin: resource
category_id: information_gathering
command: os_resource.py
_description: Generates release info based on /etc/os-release
_summary: [DEPRECATED, use 'os' instead] Collect information about installed operating system (os-release)

========
=========== Showing the content of com.canonical.certification::miscellanea/check_prerelease
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:190-200
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.5
id: miscellanea/check_prerelease
_summary: Test that the system is not a pre-release version
_purpose:
 Test to verify that the system uses production, rather
 than pre-release, versions of the kernel and the OS.
command: check_prerelease.py
requires:
  "Ubuntu Core" not in lsb.description

========
=========== Showing the content of com.canonical.certification::miscellanea/cpuid
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:476-484
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.2
id: miscellanea/cpuid
user: root
requires: cpuinfo.platform in ("i386", "x86_64")
command: cpuid.py
_summary: Attempt to identify CPU family (x86/amd64 only)
_purpose: Attempts to identify the CPU family of an x86/amd64 processor

========
=========== Showing the content of com.canonical.certification::dmi_present
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:153-165
id: dmi_present
estimated_duration: 0.02
plugin: resource
category_id: information_gathering
user: root
command:
  if [ -d /sys/devices/virtual/dmi ]
  then
      echo "state: supported"
  else
      echo "state: unsupported"
  fi
_summary: Resource to detect if dmi data is present

========
=========== Showing the content of com.canonical.certification::miscellanea/cpus_are_not_samples
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:227-239
plugin: shell
category_id: com.canonical.plainbox::miscellanea
id: miscellanea/cpus_are_not_samples
requires:
  executable.name == 'dmidecode'
  dmi_present.state == 'supported'
estimated_duration: 0.5
user: root
command: dmitest.py cpu-check
_purpose:
 Sanity check of CPU information; fails if CPU is an engineering sample
_summary:
 Test DMI data for CPUs

========
=========== Showing the content of com.canonical.certification::miscellanea/debsums
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:494-502
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 60
id: miscellanea/debsums
user: root
requires: executable.name == 'debsums'
command: debsums -c
_summary: Check the MD5 sums of installed Debian packages
_purpose: Verify installed Debian package files against MD5 checksum lists from /var/lib/dpkg/info/*.md5sums.

========
=========== Showing the content of com.canonical.certification::miscellanea/dmitest_server
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:241-253
plugin: shell
category_id: com.canonical.plainbox::miscellanea
id: miscellanea/dmitest_server
requires:
  executable.name == 'dmidecode'
  dmi_present.state == 'supported'
estimated_duration: 0.5
user: root
command: dmitest.py server
_purpose:
 Sanity check of DMI system identification data (for servers)
_summary:
 Test DMI identification data (servers)

========
=========== Showing the content of com.canonical.certification::miscellanea/efi_boot_mode
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:120-129
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.5
id: miscellanea/efi_boot_mode
requires:
 cpuinfo.platform in ("i386", "x86_64", "aarch64")
_summary: Test that system booted in EFI mode
_purpose:
 Test to verify that the system booted in EFI mode.
command: boot_mode_test.py efi

========
=========== Showing the content of com.canonical.certification::miscellanea/efi_pxeboot
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:176-188
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.5
user: root
id: miscellanea/efi_pxeboot
requires:
 cpuinfo.platform in ("i386", "x86_64", "aarch64")
depends: miscellanea/efi_boot_mode
_summary: Test that system booted from the network
_purpose:
 Test to verify that the system booted from the network.
 Works only on EFI-based systems.
command: efi-pxeboot.py

========
=========== Showing the content of com.canonical.certification::miscellanea/get_make_and_model
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:430-439
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 30.0
id: miscellanea/get_make_and_model
user: root
command: get_make_and_model.py
requires:
  dmi_present.state == 'supported'
_purpose: Retrieve the computer's make and model for easier access than digging through the dmidecode output.
_summary: Gather info on the SUT's make and model

========
=========== Showing the content of com.canonical.certification::miscellanea/get_maas_version
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:414-420
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.1
id: miscellanea/get_maas_version
command: install-method-check.sh --maas
_description: If the system was installed via MAAS from a cert server, the MAAS version used should be contained in /etc/installed-by-maas
_summary: Verify MAAS version used to deploy the SUT

========
=========== Showing the content of com.canonical.certification::miscellanea/ipmi_test
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:105-118
plugin: shell
category_id: com.canonical.plainbox::miscellanea
id: miscellanea/ipmi_test
requires:
 executable.name == 'ipmitool'
 cpuinfo.platform != 's390x'
user: root
command: ipmi_test.py
_summary:
 Test IPMI in-band communications
_purpose:
 This will run some basic commands in-band against a BMC, verifying that IPMI
 works. Use of MAAS to deploy the system implicitly tests out-of-band BMC
 control.

========
=========== Showing the content of com.canonical.certification::miscellanea/kernel_taint_test
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:202-210
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.5
id: miscellanea/kernel_taint_test
_summary: Test that kernel is not tainted
_purpose:
 Test to verify that the kernel is not tainted by out-of-tree
 drivers, live patches, proprietary modules, etc.
command: kernel_taint_test.py

========
=========== Showing the content of com.canonical.certification::miscellanea/maas_user_check
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:520-539
plugin: shell
category_id: com.canonical.plainbox::miscellanea
id: miscellanea/maas_user_check
requires:
 executable.name == 'ipmitool'
 cpuinfo.platform != 's390x'
estimated_duration: 0.5
user: root
command:
 CHAN=0
 while [ $CHAN -le 15 ]; do
  if ipmitool user list $CHAN 2>/dev/null | grep -E "maas.*ADMINISTRATOR"; then
   break
  fi
  (( CHAN+=1 ))
 done
_purpose:
 This will verify that the maas user was successfully created with admin privileges
_summary:
 Verify BMC user called 'maas' was successfully created with administrative privileges

========
=========== Showing the content of com.canonical.certification::miscellanea/reboot_firmware
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:145-155
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.5
id: miscellanea/reboot_firmware
requires:
 cpuinfo.platform in ("i386", "x86_64", "aarch64")
depends: miscellanea/efi_boot_mode
_summary: Test that system supports booting into firmware setup utility
_purpose:
 Test that the system supports rebooting into the firmware setup utility.
command: boot_mode_test.py reboot_firmware

========
=========== Showing the content of com.canonical.plainbox::manifest
origin: /snap/checkbox24/current/lib/python3.12/site-packages/plainbox/impl/providers/manifest/units/manifest.pxu:14-23
unit: job
id: manifest
category_id: com.canonical.plainbox::info
_summary: Hardware Manifest
_description:
 This job loads the hardware manifest and exposes it as a resource.
plugin: resource
command: plainbox-manifest-resource
estimated_duration: 1
flags: preserve-locale

========
=========== Showing the content of com.canonical.certification::miscellanea/secure_boot_mode
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:131-143
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.5
id: miscellanea/secure_boot_mode
imports: from com.canonical.plainbox import manifest
requires:
 cpuinfo.platform in ("i386", "x86_64", "aarch64")
 manifest.has_secure_boot == 'True'
depends: miscellanea/efi_boot_mode
_summary: Test that system booted with Secure Boot active
_purpose:
 Test to verify that the system booted in Secure Boot active.
command: boot_mode_test.py secureboot

========
=========== Showing the content of com.canonical.certification::miscellanea/sosreport
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:455-463
plugin: shell
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 20.0
id: miscellanea/sosreport
user: root
requires: executable.name == 'sosreport'
command: sos report --batch -n lxd --tmp-dir "$PLAINBOX_SESSION_SHARE"
_summary: Generate baseline sosreport
_purpose: Generates a baseline sosreport of logs and system data

========
=========== Showing the content of com.canonical.certification::miscellanea/sosreport_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:465-474
plugin: attachment
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 5.0
id: miscellanea/sosreport_attachment
depends: miscellanea/sosreport
user: root
command:
 # shellcheck disable=SC2012
 SOSFILE=$(ls -t "$PLAINBOX_SESSION_SHARE"/sosreport*xz | head -1); [ -e "${SOSFILE}" ] && cat "$SOSFILE"
_summary: Attach the baseline sosreport file

========
=========== Showing the content of com.canonical.certification::dkms_info_json
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/submission/jobs.pxu:1-13
id: dkms_info_json
template-engine: jinja2
plugin: attachment
category_id: com.canonical.plainbox::info
command:
 {%- if __on_ubuntucore__ %}
 echo "{}"
 {%- else %}
 dkms_info.py  --format json | checkbox-support-parse dkms-info | \
 jq '.dkms_info'
 {% endif -%}
_description: Attaches json dumps of installed dkms package information.
_summary: Attaches json dumps of installed dkms package information.

========
=========== Showing the content of com.canonical.certification::lspci_standard_config_json
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/submission/jobs.pxu:48-56
id: lspci_standard_config_json
_summary: Attach PCI configuration space hex dump
plugin: attachment
category_id: com.canonical.plainbox::info
command:
 lspci -x | checkbox-support-parse pci-subsys-id | \
 jq '.pci_subsystem_id'
estimated_duration: 0.1
_purpose: Attaches a hex dump of the standard part of the PCI configuration space for all PCI devices.

========
=========== Showing the content of com.canonical.certification::raw_devices_dmi_json
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/submission/jobs.pxu:22-36
id: raw_devices_dmi_json
plugin: attachment
category_id: com.canonical.plainbox::info
requires:
 executable.name == 'dmidecode'
 dmi_present.state == 'supported'
user: root
command:
 BOOT_MODE=$(inxi_snapshot -M --output json --output-file print | grep -oP '(?<=\d#)(UEFI|BIOS)(\s+\[Legacy\])?')
 # shellcheck disable=SC2016
 dmidecode | checkbox-support-parse dmidecode | \
 jq --arg BOOT_MODE "$BOOT_MODE" '[.[] | ._attributes + {"category": .category} + (if .category == "BIOS" then {boot_mode: $BOOT_MODE} else {} end)]'
estimated_duration: 1
_purpose: Attaches dmidecode output
_summary: Attaches JSON dumps of raw DMI devices

========
=========== Showing the content of com.canonical.certification::module
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:100-107
id: module
estimated_duration: 0.13
plugin: resource
category_id: information_gathering
user: root
command: module_resource.py
_description: Generates resources info on running kernel modules
_summary: Collect information about kernel modules

========
=========== Showing the content of com.canonical.certification::dmi
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:167-175
id: dmi
estimated_duration: 0.59
plugin: resource
category_id: information_gathering
requires:
  dmi_present.state == 'supported'
user: root
command: dmi_resource.py
_summary: Collect information about hardware devices (DMI)

========
=========== Showing the content of com.canonical.certification::dpkg
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:68-74
id: dpkg
estimated_duration: 0.19
plugin: resource
category_id: information_gathering
command: dpkg_resource.py
_summary: Collect information about dpkg version
_description: Gets info on the version of dpkg installed

========
=========== Showing the content of com.canonical.certification::meminfo
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:92-98
id: meminfo
estimated_duration: 0.1
plugin: resource
category_id: information_gathering
command: meminfo_resource.py
_description: Generates resource info based on /proc/meminfo
_summary: Collect information about system memory (/proc/meminfo)

========
=========== Showing the content of com.canonical.certification::dmi_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:31-41
id: dmi_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command:
  # shellcheck disable=SC2015
  [ -d /sys/class/dmi/id/ ] && (grep -r . /sys/class/dmi/id/ 2>/dev/null || true) || false
estimated_duration: 0.044
_purpose: Attaches info on DMI
_summary: Attach a copy of /sys/class/dmi/id/*
requires:
  dmi_present.state == 'supported'

========
=========== Showing the content of com.canonical.certification::lsblk_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:212-220
id: lsblk_attachment
estimated_duration: 0.1
plugin: attachment
category_id: com.canonical.plainbox::info
command: lsblk -i -n -P -o KNAME,TYPE,MOUNTPOINT
requires:
 executable.name == 'lsblk'
_purpose: Attaches disk block devices mount points
_summary: Attach information about block devices and their mount points.

========
=========== Showing the content of com.canonical.certification::modprobe_json
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/submission/jobs.pxu:38-46
id: modprobe_json
plugin: attachment
category_id: com.canonical.plainbox::info
command:
 find /etc/modprobe.* -name \*.conf -exec cat {} + | checkbox-support-parse modprobe |
 jq 'to_entries | map({"module": .key, "options": .value})'
estimated_duration: 0.015
_purpose: Attaches the contents of the various modprobe conf files.
_summary: Attach the contents of /etc/modprobe.*

========
=========== Showing the content of com.canonical.certification::kernel_cmdline_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:472-478
id: kernel_cmdline_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command: cat /proc/cmdline
estimated_duration: 0.005
_purpose: Attaches the kernel command line used to boot
_summary: Attach a copy of /proc/cmdline

========
=========== Showing the content of com.canonical.certification::info/kernel_config
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:480-487
id: info/kernel_config
plugin: shell
category_id: com.canonical.plainbox::info
command: 
 kernel_config.py --output "$PLAINBOX_SESSION_SHARE"/kernel_config
estimated_duration: 0.005
_purpose: Gathers the kernel configuration and saves it to a file
_summary: Gather the kernel configuration

========
=========== Showing the content of com.canonical.certification::kernel_config_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:489-497
id: kernel_config_attachment
plugin: attachment
depends: info/kernel_config
category_id: com.canonical.plainbox::info
command: 
 [ -f "$PLAINBOX_SESSION_SHARE"/kernel_config ] && cat "$PLAINBOX_SESSION_SHARE"/kernel_config
estimated_duration: 0.005
_purpose: Attaches the kernel configuration
_summary: Attach a copy of the kernel configuration

========
=========== Showing the content of com.canonical.certification::efi
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:177-183
id: efi
estimated_duration: 0.56
plugin: resource
category_id: information_gathering
user: root
command: efi_resource.py
_summary: Collect information about the EFI configuration

========
=========== Showing the content of com.canonical.certification::udev_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:196-202
id: udev_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command: udevadm info --export-db
estimated_duration: 1.465
_description: Attaches a dump of the udev database showing system hardware information.
_summary: Attach dump of udev database

========
=========== Showing the content of com.canonical.certification::cdimage
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:59-66
id: cdimage
estimated_duration: 0.61
plugin: resource
category_id: information_gathering
user: root
command: cdimage_resource.py
_summary: Collect information about installation media (casper)
_description: Gets installation info from casper.log and media-info

========
=========== Showing the content of com.canonical.certification::snap
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:390-398
id: snap
estimated_duration: 1.1
plugin: resource
category_id: information_gathering
command:
    unset PYTHONUSERBASE
    snapd_resource.py snaps
_description: Generates a list of snap packages
_summary: Collect information about installed snap packages

========
=========== Showing the content of com.canonical.certification::system_info_json
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/submission/jobs.pxu:89-96
id: system_info_json
plugin: attachment
category_id: com.canonical.plainbox::info
command: system_info.py
_purpose: Attaches JSON dumps of system info tools (inxi + udev)
_summary: Attaches JSON dumps of system info tools
requires:
  cpuinfo.platform not in ("aarch64")

========
=========== Showing the content of com.canonical.certification::uname
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:185-191
id: uname
estimated_duration: 0.09
plugin: resource
category_id: information_gathering
command: uname_resource.py
_description: Creates resource info from uname output
_summary: Collect information about the running kernel

========
=========== Showing the content of com.canonical.certification::udev_json
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/submission/jobs.pxu:15-20
id: udev_json
plugin: attachment
category_id: com.canonical.plainbox::info
command: udevadm info --export-db | checkbox-support-parse udevadm
_purpose: Attaches json dumps of udev_resource.py
_summary: Attaches JSON dumps of udev resource information.

========
=========== Showing the content of com.canonical.certification::device
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:137-143
id: device
estimated_duration: 0.48
plugin: resource
category_id: information_gathering
command: udev_resource.py
_description: Creates resource info from udev
_summary: Collect information about hardware devices (udev)

========
=========== Showing the content of com.canonical.certification::environment
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:250-259
id: environment
estimated_duration: 0.11
plugin: resource
category_id: information_gathering
_summary: Create resource info for environment variables
command:
 IFS=$'\n'
 for e in $(env | sed 's/=/:/g'); do
     echo "$e" | awk -F':' '{print $1 ": " $2}'
 done

========
=========== Showing the content of com.canonical.certification::requirements
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:320-354
id: requirements
estimated_duration: 0.01
plugin: resource
category_id: information_gathering
command:
 if [ -f "$PLAINBOX_SESSION_SHARE"/requirements_docs.txt ];then
    cat "$PLAINBOX_SESSION_SHARE"/requirements_docs.txt
 else
    true
 fi
_summary: Provide links to requirements documents
_description:
 Provide links to requirements documents.
 .
 The requirement document should contain sets of name/link pairs.
 .
 Each requirement should have two keys with their respective
 values:
 name: (to be used as the anchor text)
 link: (the actual URL)
 .
 Each set should be separated from the previous one by a new line.
 .
 Example:
 .
 name: Requirement 1
 link: http://example.com/requirement1
 .
 name: requirement 2
 link: http://example.com/requirement2
 .
 Providers wishing to use this feature need to:
 1- Write a job that places a suitably-formatted file in $PLAINBOX_SESSION_SHARE
 2- Update their whitelists to run that job *before* miscellanea/submission-resources
    or the "requirements" resource job.

========
=========== Showing the content of com.canonical.certification::sysfs_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:181-194
id: sysfs_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
_description: Attaches a report of sysfs attributes.
command:
 for i in $(udevadm info --export-db | sed -n 's/^P: //p'); do
  echo "P: $i"
  udevadm info --attribute-walk --path=/sys"$i" 2>/dev/null | sed -n 's/    ATTR{\(.*\)}=="\(.*\)"/A: \1=\2/p'
  echo
 done
estimated_duration: 6.344
_summary: Attach detailed sysfs property output from udev
requires:
  cpuinfo.platform not in ("aarch64")

========
=========== Showing the content of com.canonical.certification::miscellanea/submission-resources
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:1-38
plugin: shell
category_id: com.canonical.plainbox::miscellanea
id: miscellanea/submission-resources
depends:
 cdimage
 cpuinfo
 dmi
 dpkg
 efi
 environment
 lsb
 meminfo
 module
 package
 snap
 requirements
 uname
 device
 dmi_attachment
 lsblk_attachment
 sysfs_attachment
 udev_attachment
 dkms_info_json
 udev_json
 raw_devices_dmi_json
 modprobe_json
 lspci_standard_config_json
 system_info_json
 kernel_cmdline_attachment
 kernel_config_attachment
estimated_duration: 1.0
command: true
_summary:
 Check that data for a complete result are present
_description:
 A meta-job that verifies the data necessary for a complete result
 submission are present. Failure indicates that the results are incomplete
 and may be rejected.

========
=========== Showing the content of com.canonical.certification::block_device
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:217-223
id: block_device
estimated_duration: 0.08
plugin: resource
category_id: information_gathering
user: root
command: block_device_resource.py
_summary: Create resource info for removable block devices

========
=========== Showing the content of com.canonical.certification::info/hdparm_sda.txt
========
=========== Showing the content of com.canonical.certification::info/hdparm_sdc.txt
========
=========== Showing the content of com.canonical.certification::info/hdparm_sdb.txt
========
=========== Showing the content of com.canonical.certification::benchmarks/disk/hdparm-read_sda
========
=========== Showing the content of com.canonical.certification::benchmarks/disk/hdparm-read_sdc
========
=========== Showing the content of com.canonical.certification::benchmarks/disk/hdparm-read_sdb
========
=========== Showing the content of com.canonical.certification::benchmarks/disk/hdparm-cache-read_sda
========
=========== Showing the content of com.canonical.certification::benchmarks/disk/hdparm-cache-read_sdc
========
=========== Showing the content of com.canonical.certification::benchmarks/disk/hdparm-cache-read_sdb
========
=========== Showing the content of com.canonical.certification::rtc
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:300-318
id: rtc
estimated_duration: 0.02
plugin: resource
category_id: information_gathering
command:
  if [ -e /proc/driver/rtc ]
  then
      echo "state: supported"
  else
      echo "state: unsupported"
  fi
  # even with RTC being available to the system, the wakealarm may not be
  if [ -e /sys/class/rtc/rtc0/wakealarm ]
  then
      echo "wakealarm: supported"
  else
      echo "wakealarm: unsupported"
  fi
_summary: Creates resource info for RTC

========
=========== Showing the content of com.canonical.certification::power-management/rtc
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/power-management/jobs.pxu:198-223
plugin: shell
category_id: com.canonical.plainbox::power-management
id: power-management/rtc
flags: also-after-suspend
requires:
  rtc.state == 'supported'
  cpuinfo.other != 'emulated by qemu'
user: root
environ: RTC_DEVICE_FILE
command:
  if [[ -n "$RTC_DEVICE_FILE" ]]; then
    rtc_path="/sys/class/rtc/${RTC_DEVICE_FILE/#\/dev\/}"
  else
    rtc_path="/sys/class/rtc/rtc0"
  fi
  if [[ -f "${rtc_path}/since_epoch" ]]; then
    rtc_time=$(cat "${rtc_path}/since_epoch")
    echo "RTC time: ${rtc_time} seconds since epoch."
  else
    echo "RTC time information not available."
    exit 1
  fi
estimated_duration: 0.02
_summary: Test that RTC functions properly (if present)
_purpose:
 Verify that the Real-time clock (RTC) device functions properly, if present.

========
=========== Showing the content of com.canonical.certification::virtualization/verify_lxd
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/virtualization/jobs.pxu:15-27
plugin: shell
category_id: com.canonical.plainbox::virtualization
id: virtualization/verify_lxd
environ: LXD_TEMPLATE LXD_ROOTFS
estimated_duration: 30.0
requires:
 executable.name == 'lxc'
 package.name == 'lxd' or package.name == 'lxd-installer' or snap.name == 'lxd'
command: virtualization.py --debug lxd
_purpose:
 Verifies that an LXD container can be created and launched
_summary:
 Verify LXD container launches

========
=========== Showing the content of com.canonical.certification::virtualization/verify_lxd_vm
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/virtualization/jobs.pxu:1-13
plugin: shell
category_id: com.canonical.plainbox::virtualization
id: virtualization/verify_lxd_vm
environ: LXD_TEMPLATE KVM_IMAGE
estimated_duration: 60.0
requires:
 executable.name == 'lxc'
 package.name == 'lxd-installer' or snap.name == 'lxd'
command: virtualization.py --debug lxdvm
_purpose:
 Verifies that an LXD Virtual Machine can be created and launched
_summary:
 Verify LXD Virtual Machine launches

========
=========== Showing the content of com.canonical.certification::info/kvm_output
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:461-470
plugin: attachment
category_id: com.canonical.plainbox::info
id: info/kvm_output
estimated_duration: 0.1
_summary:
 Attaches console log from the kvm_check_vm test
_purpose:
 Attaches the debug log from the virtualization/kvm_check_vm test
 to the results submission.
command: [ -f "$PLAINBOX_SESSION_SHARE"/virt_debug ] && cat "$PLAINBOX_SESSION_SHARE"/virt_debug

========
=========== Showing the content of com.canonical.certification::miscellanea/oops
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:343-355
plugin:shell
id: miscellanea/oops
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 10.0
requires: executable.name == 'fwts'
user: root
_description:
 Run Firmware Test Suite (FWTS) oops tests.
_summary:
 Run FWTS OOPS check
environ: PLAINBOX_SESSION_SHARE
command:
 checkbox-support-fwts_test -l "$PLAINBOX_SESSION_SHARE"/fwts_oops_results.log -t oops

========
=========== Showing the content of com.canonical.certification::miscellanea/oops_results.log
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:357-364
plugin: attachment
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.5
id: miscellanea/oops_results.log
command:
 [ -e "${PLAINBOX_SESSION_SHARE}"/fwts_oops_results.log ] && xz -c "${PLAINBOX_SESSION_SHARE}"/fwts_oops_results.log
_purpose: Attaches the FWTS oops results log to the submission
_summary: Attach the FWTS oops results for submission.

========
=========== Showing the content of com.canonical.certification::miscellanea/olog
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:366-380
plugin:shell
id: miscellanea/olog
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 10.0
requires:
 executable.name == 'fwts'
 cpuinfo.platform in ("ppc64el", "ppc64le")
user: root
_description:
 Run Firmware Test Suite (fwts) olog tests (IBM Power only).
_summary:
 Run FWTS OLOG check on Power systems
environ: PLAINBOX_SESSION_SHARE
command:
 checkbox-support-fwts_test -l "$PLAINBOX_SESSION_SHARE"/fwts_olog_results.log -t olog

========
=========== Showing the content of com.canonical.certification::miscellanea/olog_results.log
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:382-389
plugin: attachment
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.5
id: miscellanea/olog_results.log
command:
 [ -e "${PLAINBOX_SESSION_SHARE}"/fwts_olog_results.log ] && xz -c "${PLAINBOX_SESSION_SHARE}"/fwts_olog_results.log
_purpose: Attaches the FWTS olog results log to the submission
_summary: Attach the FWTS olog results log to the submission.

========
=========== Showing the content of com.canonical.certification::miscellanea/klog
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:391-403
plugin:shell
id: miscellanea/klog
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 10.0
requires: executable.name == 'fwts'
user: root
_purpose:
 Run Firmware Test Suite (fwts) klog tests.
_summary:
 Run FWTS Kernel Log check
environ: PLAINBOX_SESSION_SHARE
command:
 checkbox-support-fwts_test -l "$PLAINBOX_SESSION_SHARE"/fwts_klog_results.log -t oops

========
=========== Showing the content of com.canonical.certification::miscellanea/klog_results.log
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/miscellanea/jobs.pxu:405-412
plugin: attachment
category_id: com.canonical.plainbox::miscellanea
estimated_duration: 0.5
id: miscellanea/klog_results.log
command:
 [ -e "${PLAINBOX_SESSION_SHARE}"/fwts_klog_results.log ] && xz -c "${PLAINBOX_SESSION_SHARE}"/fwts_klog_results.log
_purpose: Attaches the FWTS klog results log to the submission
_summary: Attach FWTS kernel log results for submission.

========
=========== Showing the content of com.canonical.certification::cpu/clocktest
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/cpu/jobs.pxu:126-137
plugin: shell
category_id: com.canonical.plainbox::cpu
id: cpu/clocktest
requires:
 cpuinfo.platform not in ("s390x")
flags: also-after-suspend
estimated_duration: 300.0
command: clocktest
_summary:
 Tests the CPU for clock jitter
_purpose:
 Runs a test for clock jitter on SMP machines.

========
=========== Showing the content of com.canonical.certification::cpu/cpufreq_test-server
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/cpu/jobs.pxu:289-299
plugin: shell
category_id: com.canonical.plainbox::cpu
id: cpu/cpufreq_test-server
estimated_duration: 3.0
user: root
command: cpufreq_test.py -q
requires: cpuinfo.scaling == 'supported'
_summary:
 cpufreq scaling test
_purpose:
 Comprehensive testing of CPU scaling capabilities and directives via cpufreq.

========
=========== Showing the content of com.canonical.certification::cpu/maxfreq_test
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/cpu/jobs.pxu:66-83
plugin: shell
category_id: com.canonical.plainbox::cpu
id: cpu/maxfreq_test
estimated_duration: 0.6
requires: executable.name == 'fwts'
 cpuinfo.platform in ("i386", "x86_64")
user: root
environ: LD_LIBRARY_PATH SNAP
command:
 if [[ -v SNAP ]]; then
     export LD_LIBRARY_PATH=$SNAP/usr/lib/fwts:$LD_LIBRARY_PATH
 fi
 checkbox-support-fwts_test -t maxfreq -l "$PLAINBOX_SESSION_SHARE"/maxfreq_test.log
_summary:
 Test that the CPU can run at its max frequency
_description:
 Use the Firmware Test Suite (fwts cpufreq) to ensure that the CPU can run at
 its maximum frequency.

========
=========== Showing the content of com.canonical.certification::cpu/maxfreq_test-log-attach
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/cpu/jobs.pxu:104-113
plugin: attachment
category_id: com.canonical.plainbox::cpu
id: cpu/maxfreq_test-log-attach
estimated_duration: 1.0
depends: cpu/maxfreq_test
command: [ -e "$PLAINBOX_SESSION_SHARE"/maxfreq_test.log ] && cat "$PLAINBOX_SESSION_SHARE"/maxfreq_test.log
_summary:
 Attach CPU max frequency log
_purpose:
 Attaches the log generated by cpu/maxfreq_test to the results submission.

========
=========== Showing the content of com.canonical.certification::cpu/topology
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/cpu/jobs.pxu:153-164
plugin: shell
category_id: com.canonical.plainbox::cpu
id: cpu/topology
flags: also-after-suspend
estimated_duration: 1.0
requires: int(cpuinfo.count) > 1 and (cpuinfo.platform == 'i386' or cpuinfo.platform == 'x86_64')
command: cpu_topology.py
_summary:
 Check CPU topology for accuracy between proc and sysfs
_description:
 Parses information about CPU topology provided by proc and sysfs and checks
 that they are consistent.

========
=========== Showing the content of com.canonical.certification::cpu/cstates
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/cpu/jobs.pxu:210-227
plugin:shell
id: cpu/cstates
estimated_duration: 10.0
requires:
 executable.name == 'fwts'
 cpuinfo.platform not in ("aarch64", "armv7l", "ppc64el", "ppc64le", "s390x")
user: root
category_id: com.canonical.plainbox::cpu
_summary:
 Run C-States tests
_description:
 Uses the Firmware Test Suite (fwts) to test the power saving states of the CPU.
environ: PLAINBOX_SESSION_SHARE LD_LIBRARY_PATH SNAP
command:
 if [[ -v SNAP ]]; then
     export LD_LIBRARY_PATH=$SNAP/usr/lib/fwts:$LD_LIBRARY_PATH
 fi
 checkbox-support-fwts_test -l "$PLAINBOX_SESSION_SHARE"/fwts_cstates_results.log -t cstates

========
=========== Showing the content of com.canonical.certification::cpu/cstates_results.log
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/cpu/jobs.pxu:249-260
plugin: attachment
category_id: com.canonical.plainbox::cpu
estimated_duration: 0.5
id: cpu/cstates_results.log
requires: cpuinfo.platform not in ("aarch64", "armv7l", "s390x")
after: cpu/cstates
command:
 [ -e "${PLAINBOX_SESSION_SHARE}"/fwts_cstates_results.log ] && cat "${PLAINBOX_SESSION_SHARE}"/fwts_cstates_results.log
_summary:
 Attach C-States test log
_description:
 Attaches the FWTS desktop diagnosis results log to the submission.

========
=========== Showing the content of com.canonical.certification::disk/detect
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/disk/jobs.pxu:1-12
plugin: shell
category_id: com.canonical.plainbox::disk
id: disk/detect
flags: also-after-suspend
requires:
  executable.name == 'lsblk'
_summary: Gathers information about each disk detected
_purpose:
 Uses lsblk to gather information about each disk detected on the system
 under test.
command: disk_info.py
estimated_duration: 0.25

========
=========== Showing the content of com.canonical.certification::disk/stats_sda
========
=========== Showing the content of com.canonical.certification::disk/stats_sdc
========
=========== Showing the content of com.canonical.certification::disk/stats_sdb
========
=========== Showing the content of com.canonical.certification::disk/read_performance_sda
========
=========== Showing the content of com.canonical.certification::disk/read_performance_sdc
========
=========== Showing the content of com.canonical.certification::disk/read_performance_sdb
========
=========== Showing the content of com.canonical.certification::disk/smart_sda
========
=========== Showing the content of com.canonical.certification::disk/smart_sdc
========
=========== Showing the content of com.canonical.certification::disk/smart_sdb
========
=========== Showing the content of com.canonical.certification::disk/fstrim_sda
========
=========== Showing the content of com.canonical.certification::disk/fstrim_sdc
========
=========== Showing the content of com.canonical.certification::disk/fstrim_sdb
========
=========== Showing the content of com.canonical.certification::disk/disk_stress_ng_sda
========
=========== Showing the content of com.canonical.certification::disk/disk_stress_ng_sdc
========
=========== Showing the content of com.canonical.certification::disk/disk_stress_ng_sdb
========
=========== Showing the content of com.canonical.certification::disk/disk_cpu_load_sda
========
=========== Showing the content of com.canonical.certification::disk/disk_cpu_load_sdc
========
=========== Showing the content of com.canonical.certification::disk/disk_cpu_load_sdb
========
=========== Showing the content of com.canonical.certification::config_file_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-certification-server/units/jobs.pxu:8-13
id: config_file_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command: [ -f /etc/xdg/canonical-certification.conf ] && cat /etc/xdg/canonical-certification.conf
_description: Attaches the config file for debugging config issues
_summary: Attach a copy of /etc/xdg/canonical-certification.conf

========
=========== Showing the content of com.canonical.certification::cpuinfo_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:9-15
id: cpuinfo_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command: cat /proc/cpuinfo
estimated_duration: 0.006
_purpose: Attaches a report of CPU information
_summary: Attach a copy of /proc/cpuinfo

========
=========== Showing the content of com.canonical.certification::dkms_info_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:239-246
id: dkms_info_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
requires:
  package.name == 'dkms'
command: dkms_info.py  --format json
_description: Attaches json dumps of installed dkms package information.
_summary: Attaches json dumps of installed dkms package information.

========
=========== Showing the content of com.canonical.certification::dmesg_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:17-29
id: dmesg_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
user: root
command:
 if [ -e /var/log/dmesg ]; then
  ansi_parser.py < /var/log/dmesg
 else
  dmesg | ansi_parser.py
 fi
estimated_duration: 0.640
_purpose: Attaches a copy of /var/log/dmesg or the current dmesg buffer to the test results
_summary: Attach a copy of dmesg or the current dmesg buffer to the test results.

========
=========== Showing the content of com.canonical.certification::dmidecode_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:43-53
id: dmidecode_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
requires:
  executable.name == 'dmidecode'
  dmi_present.state == 'supported'
user: root
command: dmidecode | iconv -t 'utf-8' -c
estimated_duration: 0.030
_description: Attaches dmidecode output
_summary: Attach output of dmidecode

========
=========== Showing the content of com.canonical.certification::dpkg_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:55-63
id: dpkg_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
requires:
  executable.name == 'dpkg'
command: dpkg -l
estimated_duration: 2.0
_summary: Attach dpkg -l output
_purpose: Attach system debian packages status

========
=========== Showing the content of com.canonical.certification::efi_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:74-83
id: efi_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
user: root
command:
  # shellcheck disable=SC2015
  [ -d /sys/firmware/efi ] && grep -m 1 -o --color=never 'EFI v.*' /var/log/kern.log* || true
estimated_duration: 0.5
_summary: Attaches firmware version info
_purpose: Attaches the firmware version

========
=========== Showing the content of com.canonical.certification::info/buildstamp
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:376-406
plugin: attachment
category_id: com.canonical.plainbox::info
id: info/buildstamp
template-engine: jinja2
estimated_duration: 0.1
_description: Attaches the buildstamp identifier for the OS
_summary: Attaches the buildstamp identifier for the OS
command:
    {%- if __on_ubuntucore__ %}
        if [ -s /run/mnt/ubuntu-seed/.disk/info ]; then
            cat /run/mnt/ubuntu-seed/.disk/info
        elif [ -s /writable/system-data/etc/buildstamp ]; then
            cat /writable/system-data/etc/buildstamp
        elif [ -e /var/lib/snapd/seed/seed.yaml ]; then
            echo && date -r /var/lib/snapd/seed/seed.yaml -R
        else
            exit 1
        fi
    {% else -%}
        if [ -s /var/lib/ubuntu_dist_channel ]; then  # PC projects
            cat /var/lib/ubuntu_dist_channel
        elif [ -s /var/log/installer/media-info ]; then  # Stock installer info
            cat /var/log/installer/media-info
        elif [ -s /.disk/info ]; then
            cat /.disk/info
        elif [ -s /etc/media-info ]; then
            cat /etc/media-info
        else
            exit 1
        fi
    {% endif -%}

========
=========== Showing the content of com.canonical.certification::info/disk_partitions
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:367-374
plugin: attachment
category_id: com.canonical.plainbox::info
id: info/disk_partitions
estimated_duration: 1.0
user: root
command: parted -l -s
_purpose: Attaches information about disk partitions
_summary: Attaches info about disk partitions

========
=========== Showing the content of com.canonical.certification::info/network-config
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:554-559
id: info/network-config
plugin: attachment
category_id: com.canonical.plainbox::info
estimated_duration: 0.2
_summary: attach network configuration
command: network_configs.sh

========
=========== Showing the content of com.canonical.certification::installer_debug.gz
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:313-320
plugin: attachment
category_id: com.canonical.plainbox::info
id: installer_debug.gz
user: root
command: [ -d /var/log/installer ] && tar zcvf installer.tgz /var/log/installer
estimated_duration: 0.1
_purpose: Attaches the installer debug log if it exists.
_summary: Attach the installer's debug log for diagnostic purposes.

========
=========== Showing the content of com.canonical.certification::lshw_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:65-72
id: lshw_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
requires: executable.name == 'lshw'
user: root
command: lshw | iconv -t 'utf-8' -c
_summary: Attach lshw output
_purpose: Attaches lshw output

========
=========== Showing the content of com.canonical.certification::lsmod_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:231-237
id: lsmod_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command: lsmod_info.py
estimated_duration: 0.5
_purpose: Attaches a list of the currently running kernel modules.
_summary: Attach a list of currently running kernel modules

========
=========== Showing the content of com.canonical.certification::lspci_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:85-100
id: lspci_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command:
 if [[ ! -d "/proc/bus/pci" ]]; then
   echo "No PCI bus found"
   exit 0
 fi
 if [[ -v SNAP ]]; then
     lspci -i "$SNAP"/usr/share/misc/pci.ids -vvnn
 else
     lspci -vvnn | iconv -t 'utf-8' -c
 fi
estimated_duration: 0.042
_purpose: Attaches very verbose lspci output.
_summary: Attach a list of PCI devices

========
=========== Showing the content of com.canonical.certification::lspci_network_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:102-108
id: lspci_network_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command: lspci -vvnnQ | iconv -t 'utf-8' -c
estimated_duration: 1.322
_purpose: Attaches very verbose lspci output (with central database Query).
_summary: Attach very verbose lspci output for device information.

========
=========== Showing the content of com.canonical.certification::lstopo_verbose_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:533-540
id: lstopo_verbose_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command: lstopo -v
estimated_duration: 0.015
requires: executable.name == 'lstopo'
_purpose: Attaches the system topology as presented by the lstopo command
_summary: Attach the output of lstopo

========
=========== Showing the content of com.canonical.certification::lstopo_visual_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:542-552
id: lstopo_visual_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
estimated_duration: 0.015
requires: executable.name == 'lstopo'
_purpose: Attaches the system topology as presented by the lstopo command
_summary: Attach the output of lstopo command to present system topology.
command:
 lstopo "$PLAINBOX_SESSION_SHARE"/lstopo_visual.png; \
 [ -e "$PLAINBOX_SESSION_SHARE/lstopo_visual.png" ] && \
 cat "$PLAINBOX_SESSION_SHARE/lstopo_visual.png"

========
=========== Showing the content of com.canonical.certification::lsusb_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:118-131
id: lsusb_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
user: root
command:
 if [[ -v SNAP ]]; then
     checkbox-support-lsusb -f "$CHECKBOX_RUNTIME"/var/lib/usbutils/usb.ids
 else
     lsusb -vv | iconv -t 'utf-8' -c
 fi
estimated_duration: 0.700
flags: also-after-suspend
_summary: Attach output of lsusb
_purpose: Attaches a list of detected USB devices.

========
=========== Showing the content of com.canonical.certification::meminfo_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:133-139
id: meminfo_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command: cat /proc/meminfo
estimated_duration: 0.043
_summary: Attach copy of /proc/meminfo
_purpose: Attaches info on system memory as seen in /proc/meminfo.

========
=========== Showing the content of com.canonical.certification::modinfo_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:150-162
id: modinfo_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
_summary: Attach modinfo information
command:
    for mod in $(lsmod | cut -f 1 -d " ")
    do
        printf "%-16s%s\n" "name:" "$mod"
        modinfo "$mod"
        echo
    done
estimated_duration: 1.5
_purpose: Attaches modinfo information for all currently loaded modules

========
=========== Showing the content of com.canonical.certification::modprobe_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:141-148
id: modprobe_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
user: root
command: find /etc/modprobe.* -name \*.conf -exec cat {} +
estimated_duration: 0.015
_description: Attaches the contents of the various modprobe conf files.
_summary: Attach the contents of /etc/modprobe.*

========
=========== Showing the content of com.canonical.certification::modules_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:164-170
id: modules_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command: cat /etc/modules
estimated_duration: 0.004
_description: Attaches the contents of the /etc/modules file.
_summary: Attach the contents of /etc/modules

========
=========== Showing the content of com.canonical.certification::sysctl_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:172-179
id: sysctl_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
user: root
command: find /etc/sysctl.* -name \*.conf -exec cat {} +
estimated_duration: 0.014
_description: Attaches the contents of various sysctl config files.
_summary: Attach sysctl configuration files.

========
=========== Showing the content of com.canonical.certification::udev-summary_attachment
origin: /snap/checkbox24/current/providers/checkbox-provider-certification-server/units/jobs.pxu:1-6
id: udev-summary_attachment
plugin: attachment
category_id: com.canonical.plainbox::info
command: udev_resource -l DISK NETWORK USB
_description: Attaches a summary of devices found via udev
_summary: Attach a summary of udev devices

========
=========== Showing the content of com.canonical.certification::info/secure-boot-check
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/info/jobs.pxu:574-585
id: info/secure-boot-check
plugin: attachment
category_id: com.canonical.plainbox::info
estimated_duration: 0.2
imports: from com.canonical.plainbox import manifest
requires:
 package.name == 'mokutil'
 manifest.has_secure_boot == 'True'
command:
 mokutil --sb-state || true
_summary: Check secure boot state
_purpose: Output whether secure boot is enabled or disabled

========
=========== Showing the content of com.canonical.certification::ethernet/info_automated_server
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/ethernet/jobs.pxu:28-39
plugin: shell
category_id: com.canonical.plainbox::ethernet
id: ethernet/info_automated_server
requires:
 device.category == 'NETWORK'
user: root
command: network_device_info.py info NETWORK --no-nm --fail-on-disconnected
estimated_duration: 2.0
_summary:
 Provide information about detected ethernet devices
_description:
 This job provides detailed information about detected ethernet devices.

========
=========== Showing the content of com.canonical.certification::ethernet/ethertool_check_device1_eth0
========
=========== Showing the content of com.canonical.certification::ethernet/multi_iperf3_nic_device1_eth0
========
=========== Showing the content of com.canonical.certification::memory/info
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/memory/jobs.pxu:1-11
plugin: shell
category_id: com.canonical.plainbox::memory
id: memory/info
estimated_duration: 5.0 
user: root
command: memory_compare.py
_summary:
 Check the amount of memory reported by meminfo against DMI
_purpose:
 This test checks the amount of memory which is reported in meminfo against
 the size of the memory modules detected by DMI.

========
=========== Showing the content of com.canonical.certification::stress/memory_stress_ng
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/stress/jobs.pxu:36-50
plugin: shell
category_id: com.canonical.plainbox::stress
id: stress/memory_stress_ng
estimated_duration: 11000.0
user: root
environ: STRESS_NG_MIN_SWAP_SIZE
requires:
 executable.name == 'stress-ng'
command: systemd-inhibit stress_ng_test.py memory
_summary: Stress test of system memory
_purpose:
 Test to perform some basic stress and exercise of system memory via the
 stress-ng tool. This test also includes an over-commit function to force
 swapping to disk, thus SUTs should have suitably large swap files for the
 amount of RAM they have installed.

========
=========== Showing the content of com.canonical.certification::networking/predictable_names
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/networking/jobs.pxu:94-107
plugin: shell
category_id: com.canonical.plainbox::networking
template-engine: jinja2
id: networking/predictable_names
command: network_predictable_names.sh
_summary: Verify that all network interfaces have predictable names.
_purpose: Verify that all network interfaces have predictable names.
requires:
  {%- if __on_ubuntucore__ %}
  lsb.release >= '20'
  model_assertion.gadget != "pi"
  {%- else %}
  lsb.release >= '18'
  {% endif -%}

========
=========== Showing the content of com.canonical.certification::networking/ntp
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/networking/jobs.pxu:68-76
plugin: shell
category_id: com.canonical.plainbox::networking
id: networking/ntp
flags: also-after-suspend
requires: package.name == 'ntpdate'
user: root
command: network_ntp_test.py
_purpose: Test to see if we can sync local clock to an NTP server
_summary: Test NTP server synchronization capability.

========
=========== Showing the content of com.canonical.certification::nvdimm_resource
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:506-520
id: nvdimm_resource
estimated_duration: 0.25
plugin: resource
category_id: information_gathering
user: root
requires:
  package.name == 'ipmctl' or executable.name == 'ipmctl'
_summary: Resource for NVDIMM detection
command:
 if ipmctl show -dimm &> /dev/null;
 then
     echo "detected: true"
 else
     echo "detected: false"
 fi

========
=========== Showing the content of com.canonical.certification::nvdimm/info
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/nvdimm/jobs.pxu:1-14
plugin: shell
category_id: com.canonical.certification::nvdimm
id: nvdimm/info
estimated_duration: 1.0  
user: root
requires: 
 executable.name == "ipmctl"
 lsb.release >= "18.04"
 nvdimm_resource.detected == "true"
command: ipmctl show -dimm
_summary:
 Verify that NVDIMMs are discovered
_purpose:
 This test will probe any installed NVDIMMs and list them and their capacities.

========
=========== Showing the content of com.canonical.certification::nvdimm/health
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/nvdimm/jobs.pxu:16-29
plugin: shell
category_id: com.canonical.certification::nvdimm
id: nvdimm/health
estimated_duration: 1.0
user: root
requires: 
 executable.name == "ipmctl"
 lsb.release >= "18.04"
 nvdimm_resource.detected == "true"
command: ipmctl show -sensor Health
_summary:
 Report health state of installed NVDIMM devices
_purpose:
 This test will do a quick health check of installed NVDIMM devices.

========
=========== Showing the content of com.canonical.certification::usb/detect
origin: /snap/checkbox24/current/providers/checkbox-provider-base/units/usb/usb.pxu:1-16
plugin: shell
category_id: com.canonical.plainbox::usb
id: usb/detect
flags: also-after-suspend
requires:
 cpuinfo.platform != 's390x'
estimated_duration: 1.0
command:
 set -o pipefail
 if [[ -v SNAP ]]; then
     checkbox-support-lsusb -f "$CHECKBOX_RUNTIME"/var/lib/usbutils/usb.ids 2>/dev/null | sed 's/.*\(ID .*\)/\1/' | head -n 4 || echo "No USB devices were detected" >&2
 else
     lsusb 2>/dev/null | sort || echo "No USB devices were detected" >&2
 fi
_summary: Display USB devices attached to SUT
_purpose: Detects and shows USB devices attached to this system.

========
=========== Showing the content of com.canonical.certification::usb/storage-server
========
=========== Showing the content of com.canonical.certification::usb
origin: /snap/checkbox24/current/providers/checkbox-provider-resource/jobs/resource.pxu:225-240
id: usb
template-engine: jinja2
estimated_duration: 0.33
plugin: resource
category_id: information_gathering
_description: Creates resource info for supported USB versions
_summary: Collect information about supported types of USB
command:
 for version in 2 3; do
     echo -n "usb$version: "
 {%- if __on_ubuntucore__ %}
     checkbox-support-lsusb -f $SNAP/checkbox-runtime/var/lib/usbutils/usb.ids | grep -Pq "Linux Foundation ${version}.\d+ root hub" && echo "supported" || echo "unsupported"
 {% else %}
     lsusb | grep -q "Linux Foundation ${version}.0 root hub" && echo "supported" || echo "unsupported"
 {% endif -%}
 done

========
=========== Showing the content of com.canonical.certification::usb3/storage-server
========
