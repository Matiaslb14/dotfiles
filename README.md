# dotfiles / bootstrap (by Matías Lagos)

Script para dejar una máquina **nueva** lista y clonar **todos** mis repos de GitHub en minutos.

## 🚀 ¿Qué hace?
- Instala paquetes base: `git`, `jq`, `curl`, `openssh-client`.
- Configura Git (nombre/correo).
- Genera y carga **clave SSH**.
- Clona **todos** los repos (públicos; opcional privados con token).
- Cambia remotos a **SSH** para `push` sin token.
- Utilidades para `status` y `pull` en todos los repos.

## ⚙️ Requisitos
- Debian/Ubuntu/Kali con `apt`.
- Cuenta GitHub.
- Internet.

## 🧪 Uso rápido (one-liner)
> Para máquinas nuevas (descarga y ejecuta el script directamente):
```bash
bash -c 'sudo apt update && sudo apt install -y curl && \
curl -fsSL https://raw.githubusercontent.com/Matiaslb14/dotfiles/main/bootstrap_github.sh | bash -s -- --all'

Durante la ejecución verás tu clave pública SSH. Cópiala y pégala en:
GitHub → Settings → SSH and GPG keys → New SSH key.
Prueba luego:

ssh -T git@github.com

🛠️ Uso local

chmod +x bootstrap_github.sh
./bootstrap_github.sh --all

Opciones disponibles:

--all → instala + configura + SSH + clona + cambia a SSH

--clone → solo clona (HTTPS)

--switch-ssh → convierte remotos a SSH

--pull-all → git pull --ff-only en todos

--status-all → git status -s en todos


