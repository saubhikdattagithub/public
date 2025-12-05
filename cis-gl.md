# 🛡️ CIS Hardening Compliance Summary

This document describes our current **CIS Benchmark compliance** implementation based on the
[`cis-hardening`](https://github.com/ovh/debian-cis) framework integrated under `/opt/cis-hardening/`.

 - All tests are defined as configuration files in:

```bash
/opt/cis-hardening/etc/conf.d/
```

 - On installation of the package `cis-hardening` within the Garden Linux repository, the configuration files are initiated as below during image creation:

```bash
/opt/cis-hardening/bin/hardening.sh --create-config-files-only --allow-unsupported-distribution
```

 - Each test defines:
- `status=audit` → runs the check in audit mode (report only)
- `status=enabled` → enforces the check actively
- `status=disabled` → skipped intentionally (documented below)

---

## 🧪 Run Compliance Audit

A live compliance report could be generated at any time:

```bash
cd /opt/cis-hardening
./bin/hardening.sh --audit | tee /tmp/cis_audit_summary.log

# Review failed (KO) checks
grep '\[ KO \]' /tmp/cis_audit_summary.log | grep -v "Check Failed"
```

🚫 Disabled CIS Tests and Justifications

The following tests are disabled `(status=disabled)` due to platform design with alternative implementations already present in the Garden Linux design.

|  **CIS ID**  | **Test File**                         | **Description**                     | **Explanation (Why Disabled)**                                       |
| :----------: | ------------------------------------- | ----------------------------------- | -------------------------------------------------------------------- |
|  **1.1.1.7** | restrict_fat.cfg                      | Disable FAT filesystem support      | Not applicable for cloud or virtualized images (no removable media). |
|   **1.1.6**  | var_partition.cfg                     | Separate `/var` partition           | Unified filesystem model                                             |
|  **1.1.6.1** | var_nodev.cfg                         | `/var` nodev option                 | Unified filesystem model                                             |
|  **1.1.6.2** | var_nosuid.cfg                        | `/var` nosuid option                | Unified filesystem model                                             |
|   **1.1.7**  | var_tmp_partition.cfg                 | Separate `/var/tmp` partition       | Unified filesystem model                                             |
|   **1.1.8**  | var_tmp_nodev.cfg                     | `/var/tmp` nodev option             | Unified filesystem model                                             |
|   **1.1.9**  | var_tmp_nosuid.cfg                    | `/var/tmp` nosuid option            | Unified filesystem model                                             |
|  **1.1.10**  | var_tmp_noexec.cfg                    | `/var/tmp` noexec option            | Controlled via `/tmp.mount` with equivalent restrictions.            |
|  **1.1.11**  | var_log_partition.cfg                 | Separate `/var/log` partition       | Unified filesystem model                                             |
| **1.1.11.1** | var_log_noexec.cfg                    | `/var/log` noexec option            | Unified filesystem model                                             |
| **1.1.11.2** | var_log_nosuid.cfg                    | `/var/log` nosuid option            | `/var/log` is not executable — not required.                         |
| **1.1.11.3** | var_log_nodev.cfg                     | `/var/log` nodev option             | `/var/log` not a device mount point.                                 |
|  **1.1.12**  | var_log_audit_partition.cfg           | Separate `/var/log/audit` partition | Unified filesystem model                                             |
| **1.1.12.1** | var_log_audit_noexec.cfg              | `/var/log/audit` noexec option      | Unified filesystem model                                             |
| **1.1.12.2** | var_log_audit_nosuid.cfg              | `/var/log/audit` nosuid option      | Unified filesystem model                                             |
| **1.1.12.3** | var_log_audit_nodev.cfg               | `/var/log/audit` nodev option       | Unified filesystem model                                             |
|  **1.1.13**  | home_partition.cfg                    | Separate `/home` partition          | Unified filesystem model                                             |
|  **1.1.14**  | home_nodev.cfg                        | `/home` nodev option                | Unified filesystem model                                             |
| **1.1.14.1** | home_nosuid.cfg                       | `/home` nosuid option               | Unified filesystem model                                             |
|  **1.1.15**  | run_shm_nodev.cfg                     | `/run/shm` nodev                    | `/run/shm` merged into `/dev/shm` with secure mount options.         |
|  **1.1.17**  | run_shm_noexec.cfg                    | `/run/shm` noexec                   | `/dev/shm` tmp.mount removed noexec support long ago.                |
|   **1.4.1**  | install_tripwire.cfg                  | Install Tripwire                    | Replaced by AIDE for integrity checking.                             |
|   **1.3.3**  | logfile_sudo.cfg                      | /var/log/sudo.log in /etc/sudoers   | Not required/handled within GL.                                      |
|   **1.4.2**  | tripwire_cron.cfg                     | Schedule Tripwire checks            | Replaced by `aide-check.timer`.                                      |
|   **1.5.1**  | bootloader_ownership.cfg              | Ensure bootloader ownership         | Managed during image build process.                                  |
|   **1.5.2**  | bootloader_password.cfg               | Require bootloader password         | Managed during image build process.                                  |
|   **1.6.1**  | enable_nx_support.cfg                 | Enable NX support                   | Enabled by default via kernel build flags.                           |
|  **1.7.1.1** | install_apparmor.cfg                  | Install AppArmor                    | Disabled intentionally.                                              |
|  **1.7.1.2** | enable_apparmor.cfg                   | Enable AppArmor service             | Disabled intentionally.                                              |
|  **1.7.1.3** | enforce_or_complain_apparmor.cfg      | Enforce AppArmor profiles           | Disabled intentionally.                                              |
|  **1.7.1.4** | enforcing_apparmor.cfg                | Set AppArmor enforcing mode         | Disabled intentionally.                                              |
|  **2.2.1.3** | configure_chrony.cfg                  | Configure chrony NTP                | Replaced by `systemd-timesyncd`.                                     |
|  **2.2.1.4** | configure_ntp.cfg                     | Configure ntpd                      | Deprecated.                                                          |
|   **3.1.1**  | disable_ipv6.cfg                      | Disable IPv6                        | IPv6 required by Gardeneer and other stakeholders                    |
|   **3.1.3**  | disable_source_routed_packets.cfg     | Disable IPv6 loopback interface     | IPv6 required by Gardeneer and other stakeholders                    |
|   **3.2.2**  | disable_ip_forwarding.cfg             | Disable IP forwarding               | Controlled centrally via sysctl.                                     |
|   **3.3.9**  | disable_ipv6_router_advertisement.cfg | Disable IPv6 RA                     | RA enabled for managed subnets.                                      |
|  **4.1.1.3** | audit_bootloader.cfg                  | Audit bootloader configuration      | Managed by Garden Linux build.                                       |
|  **4.1.1.4** | audit_backlog_limit.cfg               | Audit backlog size                  | Tuned via kernel parameters.                                         |
|  **4.2.1.1** | install_syslog-ng.cfg                 | Install syslog-ng                   | Replaced by rsyslog.                                                 |
|  **4.2.1.2** | enable_syslog-ng.cfg                  | Enable syslog-ng                    | Not applicable.                                                      |
|  **4.2.1.3** | configure_syslog-ng.cfg               | Configure syslog-ng                 | Not applicable.                                                      |
|  **4.2.1.4** | syslog_ng_logfiles_perm.cfg           | syslog-ng log permissions           | Not applicable.                                                      |
|  **4.2.1.5** | syslog-ng_remote_host.cfg             | syslog-ng remote logging            | Not applicable.                                                      |
|  **4.2.1.6** | remote_syslog-ng_acl.cfg              | syslog-ng remote ACL                | Not applicable.                                                      |
|   **4.2.3**  | logs_permissions.cfg                  | Ensure log files permissions        | Handled by logrotate.                                                |
|   **5.1.1**  | enable_cron.cfg                       | Enable cron daemon                  | Replaced by systemd timers.                                          |
|  **6.1.13**  | find_suid_files.cfg                   | SUID exceptions update              | Added dbus + polkit helpers.                                         |
|  **6.1.14**  | find_sgid_files.cfg                   | SGID exceptions update              | Added systemd-cron helper.                                           |
|   **99.99**  | check_distribution.cfg                | Validate distribution               | Not relevant — Garden Linux base is verified and GNU License         |


🧾 Example Commands

To verify disabled test configuration:
```bash
grep 'status=' /opt/cis-hardening/etc/conf.d/*.cfg | grep 'status=disabled'
```

To re-enable a specific control (for test or policy change):
```bash
sed -i 's|status=disabled|status=audit|' /opt/cis-hardening/etc/conf.d/<test>.cfg
```

📘 Notes

All disabled tests would be periodically re-evaluated for future hardening releases.
Several functionality are replaced by modern equivalents (e.g., Tripwire → AIDE, syslog-ng → rsyslog)

This README is intended for internal and audit documentation of CIS deviation rationale.

🧾 Screenshots

`./build kvm-cis_dev`
<img width="954" height="241" alt="image" src="https://github.com/user-attachments/assets/168ade01-e886-4c5d-9059-9e1605e4605d" />

`./bin/start-vm ./.build/kvm-cis_dev-arm64-today-local.raw`
<img width="1521" height="348" alt="image" src="https://github.com/user-attachments/assets/188577db-4189-420b-a304-6a12a0380005" />

`/opt/cis-hardening/bin/hardening.sh --audit --allow-unsupported-distribution | tee /tmp/cis_audit_summary.log`
<img width="957" height="295" alt="image" src="https://github.com/user-attachments/assets/7fc1407a-b3d1-4624-a5e2-76066a1090fa" />

