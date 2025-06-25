# Garden Linux ECS #20250625

## 📚 Table of Contents

- [Overview](#-overview)
- [Steps](#-steps)
- [Identification](#-identification)
- [Solution](#-solution)

## 🧰 Overview 
_This space describes the methodology to make Garden Linux ECS compatible_

## ✨ Steps

- 1. BTP : Package build - oasis-ng and perl-os-library
- 2. BTP : Build feature in Garden Linux with necessary ECS packages and export an image for Azure
- 3. ECS : Create Azure Image and Image definition in ECS HecOnAzure subscription for Production and TIC reachability
- 4. ECS : Create VM from TIC available image of Garden Linux

## 🚀 Packages and Image building

 * Packages are built with details:

 * Image is built by forking the gardenlinux repo in github.tools.sap to keep the packages and proprietary information internal to SAP
   - 

## ⚙️ Solution

 * We identify the source of the package and modify the way the package is built from source in 2 step procedure below:

  - https://packages.debian.org/search?keywords=libxml2 reports libxml2 is not available for "trixie" (unstable/stable)
  ![Screenshot](libxml_unav_trixie.jpg)

```bash
  git clone https://github.com/gardenlinux/package-build
```

  - In this case,
     - we need to alter the prepare source and
     - update the procedure to build the package
     - using apt_src instead of Debian git src
  - Ref: https://github.com/gardenlinux/package-build/bin/source (apt_src Usage)

 ```bash
  git clone https://github.com/gardenlinux/package-libxml2
```
**Fix::** 
   - https://github.com/gardenlinux/package-libxml2/pull/3
   - https://github.com/gardenlinux/package-libxml2/commit/247c84c2966b99636d55e93cf8ddcf081ee3adf7
   - The above would ideally now fix the libxml2 package build during Image creation
---
