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

**Automatikus Release (ajánlott):** a repóban van **GitHub Actions** (`.github/workflows/release.yml`). Amikor **felpusholsz egy `v*` taget** (pl. `v1.1`), a GitHub **magától** létrehozza a Release-t és feltölti a **`dist/*.rmskin`** fájlokat. Ehhez **nem kell** személyes token a gépen; Max is „meg tudja csinálni”, ha **taget pushol** a megfelelő commitról (ahol már benne van a `dist/` csomag).

**Fontos:** a tag által mutatott commitban legyen a kívánt `.rmskin` a `dist/` mappában. Ha a `v1.0` tag már korábban kiment workflow nélkül, egy új tag (pl. `v1.0.1`) vagy tag újraírása az utolsó `main` commitra triggereli az első automata release-t.

---

**GitHub Release kézzel (API / token):** hozz létre egy személyes tokent ([GitHub → Settings → Developer settings](https://github.com/settings/tokens)), majd:

```powershell
$env:GITHUB_TOKEN = 'ghp_…'   # vagy fine-grained token
cd "…\Ping Status by A-pEx"
.\scripts\publish-github-release.ps1 -Tag v1.0
```

A szkript létrehozza a Release-t a taghez (ha még nincs), és feltölti a `dist/Ping-Status-by-A-pEx-v1.0.rmskin` fájlt. Jogosultság: classic **repo**, vagy fine-grained: **Releases: Read and write** erre a repóra.
