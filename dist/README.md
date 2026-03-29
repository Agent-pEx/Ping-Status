# `.rmskin` itt (kiadás)

**Mit tegyél ide:** a Rainmeter **Skin Packager** által készített fájlt, fix névvel:

`Ping-Status-by-A-pEx-v1.0.rmskin`  
(új főverziónál: `v1.1`, `v2.0`, stb.)

**Gyors másolás a gyökérből:** ha a csomag a repo gyökerébe került (véletlenül), futtasd a gyökérből:

```powershell
.\scripts\prepare-dist-rmskin.ps1 -Version 1.0
```

Ez a `dist/` mappába másolja az első talált `.rmskin` fájlt a megadott verziószámmal a névben.

**GitHub Release (ugyanahhoz a verzióhoz):**

1. `git add dist/`, commit, push.
2. Tag már létezik? Új verzió: `git tag -a v1.1 -m "…"` majd `git push origin v1.1`.
3. Böngésző: [új release a repóban](https://github.com/Agent-pEx/Ping-Status-by-A-pEx/releases/new) → válaszd a taget → töltsd fel **ugyanazt** a `dist/*.rmskin` fájlt csatolmányként.

A **weboldal** „Latest release” gombja ide mutat: a felhasználók innen töltik a `.rmskin`-t, ha feltöltötted a Release-hez.
