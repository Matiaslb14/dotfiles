#!/usr/bin/env bash
set -euo pipefail

# === Config por defecto (puedes exportarlas antes de correr) ===
GITHUB_USER="${GITHUB_USER:-Matiaslb14}"
EMAIL="${EMAIL:-lagos.barra.m@gmail.com}"
PROJECTS_DIR="${PROJECTS_DIR:-$HOME/github-projects}"

usage() {
  echo "Uso: $0 [--all] [--clone] [--switch-ssh] [--pull-all] [--status-all]"
  echo "  --all         : instala + configura + SSH + clona (HTTPS) + cambia a SSH"
  echo "  --clone       : clona todos los repos del usuario"
  echo "  --switch-ssh  : convierte remotos origin a SSH"
  echo "  --pull-all    : git pull --ff-only en todos los repos"
  echo "  --status-all  : git status -s en todos los repos"
  echo
  echo "Variables opcionales: GITHUB_USER, EMAIL, PROJECTS_DIR, GITHUB_TOKEN"
  echo "Si exportas GITHUB_TOKEN, también traerá repos PRIVADOS."
  exit 1
}

install_pkgs() {
  if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y git jq curl openssh-client
  else
    echo "[!] No encuentro apt. Instala git/jq/curl/openssh manualmente."
  fi
}

config_git() {
  git config --global user.name "$GITHUB_USER"
  git config --global user.email "$EMAIL"
  git config --global init.defaultBranch main
  git config --global pull.rebase false
}

setup_ssh() {
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"

  if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$HOME/.ssh/id_ed25519" -N ""
  fi

  eval "$(ssh-agent -s)" >/dev/null
  ssh-add "$HOME/.ssh/id_ed25519" >/dev/null

  ssh-keyscan -H github.com >> "$HOME/.ssh/known_hosts" 2>/dev/null || true

  echo
  echo "===== AGREGA ESTA CLAVE A GITHUB (Settings → SSH and GPG keys → New SSH key) ====="
  cat "$HOME/.ssh/id_ed25519.pub"
  echo "==================================================================================="
  echo "Tip: después de pegarla en GitHub, prueba: ssh -T git@github.com"
  echo
}

fetch_repo_names() {
  if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    curl -s -H "Authorization: token $GITHUB_TOKEN" \
      "https://api.github.com/user/repos?per_page=100&visibility=all" \
      | jq -r '.[].name'
  else
    curl -s "https://api.github.com/users/${GITHUB_USER}/repos?per_page=100" \
      | jq -r '.[].name'
  fi
}

clone_all() {
  mkdir -p "$PROJECTS_DIR"
  cd "$PROJECTS_DIR"

  echo "[*] Obteniendo lista de repos de $GITHUB_USER ..."
  mapfile -t REPOS < <(fetch_repo_names)

  for name in "${REPOS[@]}"; do
    [[ -z "$name" || "$name" == "null" ]] && continue
    if [[ -d "$name/.git" ]]; then
      echo "[=] Ya existe: $name (saltando)"
      continue
    fi
    if [[ -n "${GITHUB_TOKEN:-}" ]]; then
      url="https://$GITHUB_TOKEN@github.com/${GITHUB_USER}/${name}.git"
    else
      url="https://github.com/${GITHUB_USER}/${name}.git"
    fi
    echo "[+] Clonando $name ..."
    git clone "$url" || echo "[!] Falló $name (continuo con el resto)"
  done
}

switch_all_to_ssh() {
  mkdir -p "$PROJECTS_DIR"
  cd "$PROJECTS_DIR"
  for d in */; do
    [[ -d "$d/.git" ]] || continue
    current=$(git -C "$d" remote get-url origin)
    if [[ "$current" =~ ^https://github.com/ || "$current" =~ ^https://[^@]+@github.com/ ]]; then
      ssh_url="${current/https:\/\/github.com\//git@github.com:}"
      ssh_url="${ssh_url//@/}"
      git -C "$d" remote set-url origin "$ssh_url"
      echo "[OK] $d -> $ssh_url"
    else
      echo "[=] $d ya está en SSH"
    fi
  done
}

pull_all() {
  cd "$PROJECTS_DIR"
  for d in */; do
    [[ -d "$d/.git" ]] || continue
    echo "== $d"
    git -C "$d" pull --ff-only || echo "[!] Pull falló en $d"
  done
}

status_all() {
  cd "$PROJECTS_DIR"
  for d in */; do
    [[ -d "$d/.git" ]] || continue
    echo "== $d"
    git -C "$d" status -s
  done
}

if [[ $# -eq 0 ]]; then usage; fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --all)
      install_pkgs
      config_git
      setup_ssh
      clone_all
      switch_all_to_ssh
      ;;
    --clone)       clone_all ;;
    --switch-ssh)  switch_all_to_ssh ;;
    --pull-all)    pull_all ;;
    --status-all)  status_all ;;
    *) usage ;;
  esac
  shift
done


