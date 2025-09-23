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

<img width="1395" height="780" alt="image" src="https://github.com/user-attachments/assets/5bd419ec-7a2a-4adc-b6d2-54eabd88a5b4" />

<img width="1079" height="1251" alt="478970731-8e69417a-aab8-4185-99e3-4db199cc2bae" src="https://github.com/user-attachments/assets/029fce28-a29a-4f6a-ae13-0df3ac114d1d" />

<img width="1021" height="525" alt="478970803-d26d85fe-393f-4bbe-8acf-3e49ab7eacd1" src="https://github.com/user-attachments/assets/de9117b5-d5f1-4f3a-b013-e46f61693e2c" />

<img width="2562" height="1756" alt="image" src="https://github.com/user-attachments/assets/627d0fb2-d6f4-4bbf-b4f0-3e57d82a02c6" />

<img width="2024" height="2472" alt="image" src="https://github.com/user-attachments/assets/12b16c66-1940-4aae-9ac2-29b961679959" />

<img width="2874" height="2472" alt="image" src="https://github.com/user-attachments/assets/4aba3b4f-212c-4d37-a64d-c390ab3b13f6" />

<img width="3444" height="2326" alt="image" src="https://github.com/user-attachments/assets/aa202da1-4b84-4403-a1fb-f6813dc13ea7" />

<img width="2980" height="2308" alt="image" src="https://github.com/user-attachments/assets/276e756d-e6cd-45a9-90aa-ca48403345ae" />







