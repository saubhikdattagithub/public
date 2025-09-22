# ⚙️ Checkbox Customisation (Made Simple)

This script is like a **magic helper** 🪄 that takes the official Checkbox testing tool 🧰 and **reshapes it to include your own stuff**.

Script for customised checkbox test suite for Garden Linux in CCloud --> [1877.gardenlinux.certification:ccloud](https://github.com/saubhikdattagithub/public/blob/main/generate_checkbox_env.sh)

# 🔗 checkbox Official Guide:

 - [Official Document](https://canonical-checkbox.readthedocs-hosted.com/latest/)

 - [Tutorial](https://canonical-checkbox.readthedocs-hosted.com/latest/tutorial/)

 - [How Tos](https://canonical-checkbox.readthedocs-hosted.com/latest/how-to/)

 - [Writing a custom test plan](https://canonical-checkbox.readthedocs-hosted.com/latest/tutorial/writing-tests/test-case/)

# 📝 **_checkbox Components_**

- namespace
- provider
- test plan
- units, job and tests

---
## 🏗️ What it actually builds

1. 🏠 **A private home for Checkbox**  
   - Instead of messing with the system, it makes a **sandbox** 🏖️ where Checkbox lives.  
   - Think of it like giving Checkbox its own apartment so it doesn’t fight with your system apps.  

2. 📦 **Your very own provider (`ccloud`)**  
   - A *provider* in Checkbox is just a **folder of tests** 📑.  
   - The script plugs in your folder, so Checkbox now knows about **your tests** just like it knows about Canonical’s official ones.  

3. 📝 **Your custom test plan (`server-certification-full`)**  
   - A *test plan* is like a **playlist of songs** 🎶 — except it’s a playlist of tests.  
   - The script registers your playlist, so when you open Checkbox you see *your plan* ready to run ✅.  

4. 🔗 **Wires everything together**  
   - It links Checkbox → `ccloud` → `server-certification-full`.  
   - So when Checkbox runs, it automatically offers your tests as if they were built-in.  

---

## 🧩 In plain English

- Checkbox is the **toolbox** 🧰.  
- Providers are **drawers inside the toolbox** 🗂️ (your drawer = `ccloud`).  
- Test plans are **the shopping list** 📝 of which tools to use together (yours = `server-certification-full`).  
- The script is the **handyman** 👷 who sets up the toolbox, installs your drawer, and fills it with your shopping list — all at once.  

---

## 🎉 End Result

When the script finishes:  
- Checkbox behaves like the normal official one ⚡  
- But it also has **your own provider + test plan** baked in 🧩  
- Meaning your tests look and feel **official**, not like an add-on 🚀  

---

