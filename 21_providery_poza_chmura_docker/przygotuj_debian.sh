#!/bin/bash
# ==========================================================================================
# przygotuj_debian.sh - maszyna Debian jako serwer Dockera (kurs Terraform/OpenTofu, lekcja 21)
#
# Na swiezo zaimportowanym Debianie 13 (plik OVA z materialow kursu, uzytkownik "kursant"):
#   1) aktualizuje system i instaluje pakiety potrzebne do dodania repozytorium Dockera,
#   2) instaluje Docker Engine z oficjalnego repozytorium Dockera (wedlug dokumentacji
#      docs.docker.com) i dodaje uzytkownika do grupy "docker",
#   3) dopisuje klucz SSH z Windows do ~/.ssh/authorized_keys (jak w lekcji 1).
# Terraformu, AWS CLI ani Ansible tu nie instalujemy: Terraform i OpenTofu pracuja na Windows,
# a Debian jest tylko serwerem Dockera, z ktorym provider laczy sie przez SSH.
# Skrypt mozna uruchamiac wielokrotnie - to, co juz jest zainstalowane, zostaje pominiete.
#
# Uzycie (jako root):   bash przygotuj_debian.sh <uzytkownik> [plik_z_kluczem_publicznym]
#
# Z Windows (PowerShell), w katalogu ze skryptem:
#   scp .\przygotuj_debian.sh $env:USERPROFILE\.ssh\id_ed25519.pub kursant@<ADRES_DEBIANA>:
#   ssh -t kursant@<ADRES_DEBIANA> "sudo bash przygotuj_debian.sh kursant id_ed25519.pub"
# Dawna maszyna z lekcji 1-10 (uzytkownik "user" bez sudo) - skrypt uruchamiamy jako root:
#   ssh -t user@<ADRES_DEBIANA> "su -c 'bash przygotuj_debian.sh user id_ed25519.pub'"
# ==========================================================================================
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

krok() { echo; echo "===== $* ====="; }
blad() { echo "BLAD: $*" >&2; exit 1; }

[ "$(id -u)" -eq 0 ] || blad "uruchom skrypt jako root (su -c '...' albo sudo ...)"

UZYTKOWNIK="${1:-${SUDO_USER:-}}"
[ -n "$UZYTKOWNIK" ] || blad "podaj uzytkownika, np.: bash przygotuj_debian.sh user id_ed25519.pub"
id "$UZYTKOWNIK" >/dev/null 2>&1 || blad "uzytkownik '$UZYTKOWNIK' nie istnieje"
GRUPA=$(id -gn "$UZYTKOWNIK")
DOM=$(getent passwd "$UZYTKOWNIK" | cut -d: -f6)

KLUCZ="${2:-}"
if [ -n "$KLUCZ" ] && [ ! -f "$KLUCZ" ] && [ -f "$DOM/$KLUCZ" ]; then KLUCZ="$DOM/$KLUCZ"; fi
[ -z "$KLUCZ" ] || [ -f "$KLUCZ" ] || blad "nie znaleziono pliku z kluczem: $KLUCZ"

. /etc/os-release
[ "${ID:-}" = "debian" ] || echo "UWAGA: skrypt przygotowano dla Debiana 13, wykryto: ${PRETTY_NAME:-nieznany system}"

krok "1/3 Aktualizacja systemu i pakiety potrzebne do repozytorium Dockera"
# Dawne maszyny mialy czasem aktywne zrodlo "deb cdrom:", ktore przerywa apt-get update
sed -i '/^deb cdrom:/s/^/#/' /etc/apt/sources.list 2>/dev/null || true
apt-get update -qq
echo "(aktualizacja systemu moze potrwac kilka minut)"
apt-get upgrade -y -qq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold >/dev/null
apt-get install -y -qq ca-certificates curl >/dev/null
echo "Pakiety ca-certificates i curl: OK"

krok "2/3 Docker Engine z oficjalnego repozytorium Dockera i grupa docker"
if ! command -v docker >/dev/null 2>&1; then
  # Metoda zalecana w dokumentacji: https://docs.docker.com/engine/install/debian/
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian ${VERSION_CODENAME} stable" > /etc/apt/sources.list.d/docker.list
  apt-get update -qq
  apt-get install -y -qq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >/dev/null
else
  echo "Docker byl juz zainstalowany - pomijam instalacje."
fi
systemctl enable --now docker >/dev/null 2>&1 || true
usermod -aG docker "$UZYTKOWNIK"
docker version --format 'Docker Engine {{.Server.Version}} ({{.Server.Os}})'
# Pobrania obrazow nie moga przerwac skryptu (np. limit Docker Hub) - klucz SSH w etapie 3 jest wazniejszy
docker run --rm hello-world | grep 'Hello from Docker' || echo "UWAGA: test hello-world nieudany (limit Docker Hub?) - powtorz pozniej: docker run --rm hello-world"
docker pull -q nginx:1.30-alpine || echo "UWAGA: nie pobrano nginx:1.30-alpine - Terraform pobierze obraz w trakcie lekcji"

krok "3/3 Klucz SSH z Windows w ~/.ssh/authorized_keys (lekcja 1)"
install -d -m 700 -o "$UZYTKOWNIK" -g "$GRUPA" "$DOM/.ssh"
if [ -n "$KLUCZ" ]; then
  k=$(tr -d '\r' < "$KLUCZ" | sed -n 1p)
  case "$k" in
    ssh-*|ecdsa-*) ;;
    *) blad "plik $KLUCZ nie wyglada na klucz publiczny SSH (powinien zaczynac sie od ssh-...)" ;;
  esac
  touch "$DOM/.ssh/authorized_keys"
  grep -qxF "$k" "$DOM/.ssh/authorized_keys" || echo "$k" >> "$DOM/.ssh/authorized_keys"
  chown "$UZYTKOWNIK:$GRUPA" "$DOM/.ssh/authorized_keys"
  chmod 600 "$DOM/.ssh/authorized_keys"
  echo "Klucz w authorized_keys: $(echo "$k" | cut -d' ' -f1) ... $(echo "$k" | cut -d' ' -f3-)"
else
  echo "Pominieto klucz SSH (nie podano pliku z kluczem publicznym)."
fi

krok "PODSUMOWANIE"
echo "Adresy IPv4 tej maszyny:"
ip -4 -br addr | grep -v '^lo'
echo "Uzytkownik $UZYTKOWNIK nalezy do grup: $(id -nG "$UZYTKOWNIK")"
echo "GOTOWE. Grupa 'docker' zadziala od NASTEPNEGO logowania uzytkownika $UZYTKOWNIK."
