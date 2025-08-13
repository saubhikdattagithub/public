# Run debuginfod locally

## 📚 Table of Contents

- [Overview](#-overview)
- [Steps](#-steps)
- [Outcome](#-outcome)
- [debuginfod-server-intiate](#-debuginfod-server-intiate)

## 🧰 Overview 
_This space provides the steps to run debuginfod locally for debug and debug-symbol files availability required for GNU Debugger (gdb). As per design, debuginfod indexes ELF binaries, debug files and source codes in pre-defined directory_

## 🚀 Steps

- Install debuginfod
  - ```apt install elfutils debuginfod```
   
- Define a pre-defined directory for debiginfod
  - ```mkdir -p /srv/debug_data```

- Extract all debug files in /srv/debug_data
  - ```dpkg-deb -x "PACKAGE" /srv/debug_data```
  - This directory should now contain the debug and debug symbol files for the built packages which our local debuginfod server can fetch/obtain

- Initiate debuginfod server (Any free port)
  - ```debuginfod --port=8802 --verbose /srv/debug_data```
 
- Register the ENV variable to reach the debuginfod local server initiated above
  - ```export DEBUGINFO_URLS="http://localhost_IP:8802"```
  
## 🚀 Outcome

 * We should now be having our own debuginfod server and tools like gdb, perf etc should fetch debug information automatically

Eg:
```
gdb /usr/bin/dpkg
```

## 🚀 debuginfod-server-intiate
```
(checkbox_venv) root@garden:~/checkbox/providers# debuginfod --port=8802 --verbose /srv/debug_data/
[Tue Aug 12 16:44:30 2025] (30581/30581): warning: without -F -R -U -Z, ignoring PATHs
[Tue Aug 12 16:44:30 2025] (30581/30581): opened database /root/.debuginfod.sqlite rw ro
[Tue Aug 12 16:44:30 2025] (30581/30581): sqlite version 3.46.1
[Tue Aug 12 16:44:30 2025] (30581/30581): service mode active
[Tue Aug 12 16:44:30 2025] (30581/30581): libmicrohttpd version 1.0.1
[Tue Aug 12 16:44:30 2025] (30581/30581): started http server on IPv4 IPv6 port=8802
[Tue Aug 12 16:44:30 2025] (30581/30581): search concurrency 10
[Tue Aug 12 16:44:30 2025] (30581/30581): webapi connection pool 10
[Tue Aug 12 16:44:30 2025] (30581/30581): rescan time 300
[Tue Aug 12 16:44:30 2025] (30581/30581): scan checkpoint 256
[Tue Aug 12 16:44:30 2025] (30581/30581): fdcache mbs 1155
[Tue Aug 12 16:44:30 2025] (30581/30581): fdcache prefetch 64
[Tue Aug 12 16:44:30 2025] (30581/30581): fdcache tmpdir /tmp
[Tue Aug 12 16:44:30 2025] (30581/30581): fdcache tmpdir min% 25
[Tue Aug 12 16:44:30 2025] (30581/30581): groom time 86400
[Tue Aug 12 16:44:30 2025] (30581/30581): forwarded ttl limit 8
[Tue Aug 12 16:44:30 2025] (30581/30581): upstream debuginfod servers: https://debuginfod.debian.net
[Tue Aug 12 16:44:31 2025] (30581/30592): grooming database
[Tue Aug 12 16:44:31 2025] (30581/30592): database record counts:
[Tue Aug 12 16:44:31 2025] (30581/30592): file d/e 0
[Tue Aug 12 16:44:31 2025] (30581/30592): file s 0
[Tue Aug 12 16:44:31 2025] (30581/30592): archive d/e 0
[Tue Aug 12 16:44:31 2025] (30581/30592): archive sref 0
[Tue Aug 12 16:44:31 2025] (30581/30592): archive sdef 0
[Tue Aug 12 16:44:31 2025] (30581/30592): buildids 0
[Tue Aug 12 16:44:31 2025] (30581/30592): filenames 0
[Tue Aug 12 16:44:31 2025] (30581/30592): fileparts 0
[Tue Aug 12 16:44:31 2025] (30581/30592): files scanned (#) 0
[Tue Aug 12 16:44:31 2025] (30581/30592): files scanned (mb) 0
[Tue Aug 12 16:44:31 2025] (30581/30592): index db size (mb) 0
[Tue Aug 12 16:44:31 2025] (30581/30592): groomed database in 0.00916245s
```

---
