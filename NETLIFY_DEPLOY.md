# Netlify par HubSchool Pro deploy kaise karein

## Build (pehle ye chalaayein)

```bash
flutter build web -t lib/main_web.dart --base-href "/"
```

Output folder: **build/web**

---

## Netlify par upload

### Option A: Drag & Drop (sabse aasaan)

1. **Netlify Dashboard** → Your site → **Deploys** → **Drag and drop your site output folder**
2. **Sirf `build/web` folder ke andar ki cheezein** upload karein:
   - `build/web` folder kholen
   - **Us folder ke andar** jo bhi hai (index.html, main.dart.js, flutter_bootstrap.js, assets, canvaskit, icons, _redirects, etc.) — in **sab** files/folders ko select karke drag-and-drop karein
3. Ye ensure karein ki site root par **index.html** ho (URL open karte hi yahi load ho)

**Galti mat karein:**  
- Poora **project folder** ya **build** folder mat chahiye  
- Sirf **build/web** ke andar wali contents chahiye (taaki index.html site ki root par ho)

### Option B: Git se deploy

1. Netlify pe repo connect karein
2. **Build command:** `flutter build web -t lib/main_web.dart --base-href "/"`
3. **Publish directory:** `build/web`
4. Netlify par Flutter install karna hoga (e.g. build image ya plugin se)

---

## Agar ab bhi white screen aaye

- Browser **Developer Tools** (F12) → **Console** check karein — koi error dikh raha hai?
- **Network** tab mein dekhein — kya **main.dart.js** aur **flutter_bootstrap.js** 200 OK se load ho rahe hain?
- Confirm karein ki aapne **build/web** ki contents hi upload ki hain, poora project ya `build` folder nahi

---

Site URL: https://splendorous-meringue-ae47e2.netlify.app/
