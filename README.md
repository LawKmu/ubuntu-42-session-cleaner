# Ubuntu 42 Session Cleaner

**A full garbage cleaner script for 42 students and Ubuntu users.**  
Cleans trash, caches, logs, temporary files, apt cache, docker garbage, and more.  
Keep your system fresh, light, and ready to hack!

---

## ✨ Features

- 🧹 **Basic Cleaning**  
  Clears user cache, trash, and application junk (VSCode, Discord, Slack, Chrome, Brave...).

- 🚀 **Full System Cleaning (`--full`)**  
  Removes system logs, apt cache, old temporary files.

- 🐳 **Docker Cleaning (`--docker`)**  
  Cleans dangling Docker containers, volumes, images.

- 🖥️ **Safe for Active Sessions**  
  Does not kill running apps or remove user files.

- 📜 **Verbose Mode (`-p` or `--print`)**  
  Displays what is being deleted.

---

## 📦 Installation

```bash
git clone https://github.com/YOUR_USERNAME/Ubuntu_Session_Cleaner.git
cd Ubuntu_Session_Cleaner
chmod +x Ubuntu_Cleaner_42.sh
```
## 🚀 Usage

### Basic cleaning:
```bash
./Ubuntu_Cleaner_42.sh
```

### Verbose mode (print deleted files):
```bash
./Ubuntu_Cleaner_42.sh --print
```

### Full cleaning (including system garbage):
```bash
./Ubuntu_Cleaner_42.sh --full
```

### Docker garbage cleaning:
```bash
./Ubuntu_Cleaner_42.sh --docker
```

### Combine all modes:
```bash
./Ubuntu_Cleaner_42.sh --print --full --docker
```

## ⚙️ What it Cleans

| Target  | Description |
|:-------:|:------------|
| **Trash** | Empties `~/.local/share/Trash/files/` |
| **App Caches** | Cleans cached files from apps like VSCode, Slack, Discord, Chrome, Brave |
| **Temporary Files** | Deletes unnecessary files from `/tmp` and `/var/tmp` |
| **APT Cache** | Clears package cache from `/var/cache/apt/archives` |
| **System Logs** | Removes old compressed logs (`/var/log/*.gz`) and journal logs |
| **Docker Garbage** | Prunes unused Docker containers, images, volumes, and networks |
| **Browser Storage** | Clears Service Workers, Application Caches, and File Systems from browsers |
| **Piscine Leftovers** | Removes old 42 piscine rules videos and unnecessary files |
| **.DS_Store Files** | Cleans hidden `.DS_Store` files from Desktop and other directories |
| **Spotify Cache** | Deletes PersistentCache used by Spotify app |

## 📢 Issues / Contributions

If you find a bug, have a suggestion, or want to add new features:

- Feel free to open an **Issue** on this [GitHub repository](https://github.com/LawKmu/ubuntu-42-session-cleaner/issues).
- You can also fork the project and submit a **Pull Request** with your improvements!

We welcome all contributions, whether it's code, ideas, or documentation fixes.  
Together we can make this cleaner even better! 🚀

---

> Make sure to clearly describe the problem or the feature you want to add when opening an issue.

