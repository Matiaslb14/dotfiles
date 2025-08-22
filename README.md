# ⚡ Dotfiles / Bootstrap (by Matías Lagos)

Script to set up a fresh machine and clone all my GitHub repositories in minutes.  

## 🚀 Features
- Installs base packages: `git`, `jq`, `curl`, `openssh-client`  
- Configures Git (name/email)  
- Generates and uploads SSH key  
- Clones all repositories (public; private optional with token)  
- Switches remotes to SSH for push without token  
- Utilities for checking repo status and pulling all at once  

## ⚙️ Requirements
- Debian/Ubuntu/Kali with `apt`  
- GitHub account  
- Internet connection  

## 🧪 Quick Start (one-liner)

For fresh machines (download and execute the script directly):  

```bash
bash -c 'sudo apt update && sudo apt install -y curl && \
curl -fsSL https://raw.githubusercontent.com/Matiaslb14/dotfiles/main/bootstrap_github.sh | bash -s -- --all'

During execution, you’ll see your SSH public key. Copy and paste it into:
GitHub → Settings → SSH and GPG keys → New SSH key

Then test your connection:
ssh -T git@github.com

🛠️ Local Usage

chmod +x bootstrap_github.sh
./bootstrap_github.sh --all

Options available:

--all → install + configure + SSH + clone + switch to SSH

--clone → only clone (HTTPS)

--switch-ssh → convert remotes to SSH

--pull-all → run git pull --ff-only on all repos

--status-all → show git status -s for all repos
