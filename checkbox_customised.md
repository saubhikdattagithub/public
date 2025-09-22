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

## 🧩 Simply said

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

## 🎉 Screenshots

<img width="1079" height="1251" alt="Image" src="https://github.com/user-attachments/assets/8e69417a-aab8-4185-99e3-4db199cc2bae" />

<img width="1021" height="525" alt="Image" src="https://github.com/user-attachments/assets/d26d85fe-393f-4bbe-8acf-3e49ab7eacd1" />

<img width="1281" height="878" alt="Image" src="https://github.com/user-attachments/assets/e2f3bf5a-2b68-417d-87b7-3c1815ad9f49" />

<img width="1012" height="1236" alt="Image" src="https://github.com/user-attachments/assets/49aa87ec-c59f-4d87-881f-78d9e95aaa7b" />

<img width="1437" height="1236" alt="Image" src="https://github.com/user-attachments/assets/d8ff7fbb-4721-4aee-a68b-dc7e41a4e3be" />

<img width="1722" height="1163" alt="Image" src="https://github.com/user-attachments/assets/df22e62f-f232-47dd-99db-f48fc8f7b6a6" />

<img width="1490" height="1154" alt="Image" src="https://github.com/user-attachments/assets/ca8bbc39-696c-432e-8a44-2206e9a48f84" />

