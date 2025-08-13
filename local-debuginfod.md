# Run debuginfod locally

## 📚 Table of Contents

- [Overview](#-overview)
- [Steps](#-steps)
- [Outcome](#-outcome)

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
  

## ⚙️ Outcome

 * We should now be having our own debuginfod server and tools like gdb, perf etc should fetch debug information automatically

Eg:
```
gdb /usr/bin/dpkg
```
   
---
