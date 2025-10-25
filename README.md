# ⚡ Dotfiles / Bootstrap  
### (Configuración Automática de Entorno)

---

## 📌 Description / Descripción  

**EN:**  
Bash script to automatically configure a new Linux machine and clone all your GitHub repositories in just a few minutes.  
Includes automation for Git setup, SSH key generation, and repository synchronization — perfect for developers, sysadmins, and DevSecOps engineers who frequently reinstall or set up multiple systems.  

**ES:**  
Script en Bash para configurar automáticamente una nueva máquina Linux y clonar todos tus repositorios de GitHub en pocos minutos.  
Incluye automatización para la configuración de Git, generación de claves SSH y sincronización de repositorios — ideal para desarrolladores, sysadmins e ingenieros DevSecOps que reinstalan o configuran varios sistemas con frecuencia.

---

## 🚀 Features / Funciones  

| Feature (EN) | Función (ES) |
|---------------|--------------|
| Installs base packages: `git`, `jq`, `curl`, `openssh-client` | Instala paquetes base: `git`, `jq`, `curl`, `openssh-client` |
| Configures Git (name/email) | Configura Git (nombre y correo electrónico) |
| Generates and uploads SSH key | Genera y sube la clave SSH |
| Clones all repositories (public; private optional with token) | Clona todos los repositorios (públicos; privados opcional con token) |
| Switches remotes to SSH for push without token | Cambia los remotos a SSH para hacer push sin token |
| Utilities for checking repo status and pulling all at once | Utilidades para verificar estado y actualizar todos los repos |

---

## ⚙️ Requirements / Requisitos  

**EN:**  
- Debian/Ubuntu/Kali with `apt`  
- GitHub account  
- Internet connection  

**ES:**  
- Debian/Ubuntu/Kali con `apt`  
- Cuenta de GitHub  
- Conexión a Internet  

---

## 🧪 Quick Start / Inicio Rápido  

**EN:**  
For fresh machines (download and execute the script directly):  

bash -c 'sudo apt update && sudo apt install -y curl && \
curl -fsSL https://raw.githubusercontent.com/Matiaslb14/dotfiles/main/bootstrap_github.sh | bash -s -- --all'

During execution, you’ll see your SSH public key.
Copy and paste it into:
GitHub → Settings → SSH and GPG keys → New SSH key

Then test your connection:

ssh -T git@github.com

**ES:**
Para máquinas recién instaladas (descarga y ejecuta el script directamente):

bash -c 'sudo apt update && sudo apt install -y curl && \
curl -fsSL https://raw.githubusercontent.com/Matiaslb14/dotfiles/main/bootstrap_github.sh | bash -s -- --all'

Durante la ejecución, verás tu clave pública SSH.
Cópiala y pégala en:
GitHub → Settings → SSH and GPG keys → New SSH key

Luego prueba la conexión:

ssh -T git@github.com

🛠️ Local Usage / Uso Local

**EN:**

chmod +x bootstrap_github.sh
./bootstrap_github.sh --all

Options available:

--all → install + configure + SSH + clone + switch to SSH

--clone → only clone (HTTPS)

--switch-ssh → convert remotes to SSH

--pull-all → run git pull --ff-only on all repos

--status-all → show git status -s for all repos

**ES:**

chmod +x bootstrap_github.sh
./bootstrap_github.sh --all

Opciones disponibles:

--all → instalar + configurar + SSH + clonar + cambiar a SSH

--clone → solo clonar (HTTPS)

--switch-ssh → convertir remotos a SSH

--pull-all → ejecutar git pull --ff-only en todos los repositorios

--status-all → mostrar git status -s para todos los repos

🧠 Commands Used / Comandos Utilizados

| Command                               | Description (EN)                  | Descripción (ES)                 |
| ------------------------------------- | --------------------------------- | -------------------------------- |
| `git`, `curl`, `jq`, `ssh-keygen`     | Installation and configuration    | Instalación y configuración      |
| `git clone`, `git remote`, `git pull` | Repository management             | Gestión de repositorios          |
| `chmod`, `bash`, `read`               | Execution and permission handling | Ejecución y manejo de permisos   |
| `printf`, `echo`, `tee`               | Output and logging                | Salida y registro de información |

📘 Notes / Notas

**EN:**
This project focuses on reproducibility and speed when setting up a development environment.
It ensures that your GitHub workspace is fully configured for SSH-based workflows without manual setup.

**ES:**
Este proyecto se centra en la reproducibilidad y rapidez al configurar un entorno de desarrollo.
Garantiza que tu entorno de trabajo con GitHub esté completamente configurado para flujos basados en SSH sin configuración manual.

👨‍💻 Developed by / Desarrollado por
Matías Lagos Barra — Cloud & DevSecOps Engineer
