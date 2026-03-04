
# Instrukcja Laboratoryjna: 
## 1. Wstęp do Terraform, przygotowanie wstępnego środowiska do zabaw z instalacją Terraform, oraz utworzenie konta w chmurze AWS



## Cel lekcji
Celem tej lekcji jest zapoznanie się z koncepcją "Infrastructure as Code" (Infrastruktura jako kod) za pomocą narzędzia Terraform (oraz opcjonalnie OpenTofu). Przygotowane zostanie własne stanowisko pracy, konfigurując system Windows 11 oraz Debian 13, instalując niezbędne oprogramowanie (Visual Studio Code, Terraform) oraz nawiązując połączenie zdalne za pomocą protokołu SSH. Końcowym etapem będzie utworzenie darmowego konta chmurowego AWS (Free-Tier).

## Wymagania wstępne
* Umiejętność obsługi oprogramowania wirtualizacyjnego (np. VirtualBox).
* Wiedza z zakresu podstaw działania sieci komputerowych.
* Podstawy pracy z systemem Linux.
* (Opcjonalnie) Znajomość narzędzi takich jak Git, Docker, Ansible oraz CI/CD.

---

## Część 1: Wprowadzenie koncepcyjne - Terraform vs Ansible

Zanim przystąpimy do zajęć praktycznych, należy zrozumieć różnice między głównymi narzędziami DevOps:
* **Podejście deklaratywne (Terraform):** W Terraform definiujemy stan docelowy (opisujemy, *co* chcemy otrzymać, np. serwery o określonych zasobach). Narzędzie samo planuje i realizuje operacje niezbędne do osiągnięcia tego stanu.
* **Podejście imperatywne (Ansible):** Ansible skupia się na procesie o krokach (definiujemy *jak*, krok po kroku, system ma zostać skonfigurowany).
* **Synergia narzędzi:** Terraform idealnie nadaje się do przygotowania środowiska i samego systemu operacyjnego, natomiast Ansible służy do instalacji i konfiguracji oprogramowania wewnątrz już działającego systemu. 

---

## Część 2: Konfiguracja środowiska w systemie Windows 11

### Zadanie 2.1: Weryfikacja menedżera pakietów Winget
1. Uruchom Wiersz Poleceń (Terminal) z uprawnieniami administratora i wpisz polecenie: 
`winget search chrome`
Jeśli polecenie nie zwróci wyników, zaktualizuj Winget pobierając instalator *Windows App SDK* oraz paczkę aktualizacyjną `.msixbundle` z oficjalnego repozytorium GitHub. Czyli wykonaj wtedy kolejne kroki 2-5: 
2. Wejdź na stronę pobierania Windows App SDK i w sekcji Windows App Runtime pobierz instalator zgodny ze swoją architekturą, np. `windowsappuntimeinstall-x64.exe`
3. Uruchom pobrany plik .exe jako administrator i zakończ instalację.
4. Przejdź na stronę wydań winget-cli w serwisie GitHub (https://github.com/microsoft/winget-cli/releases), kliknij w najnowszą wersję i zlokalizuj plik z rozszerzeniem `.msixbundle` do pobrania.
5. Uruchom wiersz poleceń z uprawnieniami administratora, przejdź do folderu pobierania i zainstaluj aktualizację poleceniem:
   `Add-AppxPackage -Path Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle`

### Zadanie 2.2: Instalacja przeglądarki i edytora kodu
Zainstaluj oprogramowanie wymagane do zajęć, używając menedżera pakietów Winget:
1. Przeglądarka Google Chrome: 
`winget install Google.Chrome`
2. Edytor kodu Visual Studio Code: 
`winget install Microsoft.VisualStudioCode` 
(Opcjonalnie, instalator można pobrać ze strony `https://code.visualstudio.com/download`).

### Zadanie 2.3: Instalacja Terraform
Masz do wyboru dwie metody instalacji narzędzia Terraform. Zaleca się metodę automatyczną (Metoda A).

**Metoda A: Automatyczna przez Winget (Rekomendowana)**
1. Wpisz polecenie w Wierszu Poleceń: 
`winget install HashiCorp.Terraform`
3. Po zakończeniu instalacji zamknij i uruchom ponownie Wiersz Poleceń (Terminal).
4. Wykonaj polecenie `terraform version`, aby sprawdzić, czy narzędzie działa prawidłowo. Zaletą tej metody jest łatwa aktualizacja narzędzia poleceniem `winget upgrade --all` lub `winget upgrade -h`.

**Metoda B: Ręczna przez plik ZIP**
5. Wejdź na stronę `https://developer.hashicorp.com/terraform/install` i pobierz wersję dla Windows amd64.
6. Utwórz katalog, np. `C:\terraform`, i rozpakuj do niego pobrany plik ZIP.
7. Dodaj utworzoną ścieżkę do zmiennej systemowej PATH. W tym celu przejdź do "Zaawansowane ustawienia systemu", kliknij "Zmienne środowiskowe", wybierz "Path" i kliknij "Edytuj", a następnie "Nowy" i wklej `C:\terraform`.

### Zadanie 2.4: Konfiguracja Visual Studio Code
Uruchom edytor Visual Studio Code i zainstaluj niezbędne rozszerzenia, przechodząc do zakładki *Extensions* w lewym menu:
* **Polish Language Pack** (opcjonalnie, tłumaczy interfejs na język polski). Po instalacji konieczny jest restart edytora.
* **HashiCorp Terraform** (oficjalne rozszerzenie ułatwiające pracę z językiem HCL poprzez podświetlanie składni i autouzupełnianie).

---

## Część 3: Konfiguracja środowiska w systemie Debian 13 (Trixie)

Uruchom maszynę wirtualną z systemem Debian 13 i zaloguj się. 

### Zadanie 3.1: Wstępna konfiguracja systemu
Zaloguj się na konto administratora (root). Następnie wykonaj polecenia:
1. Zmień nazwę hosta: 
`hostnamectl set-hostname terraform` 
Wymagane jest przelogowanie, aby zobaczyć zmianę.
2. Zaktualizuj system operacyjny: 
`apt update && apt upgrade -y`
3. Zainstaluj dodatkowe niezbędne pakiety: 
`apt install sudo curl mc -y` 
(Narzędzie "mc" to Midnight Commander, menedżer plików i edytor tekstu przydatny w terminalu).

---

## Część 4: Praca zdalna - Konfiguracja SSH i VS Code

Najwydajniejszym modelem pracy jest edytowanie plików za pomocą Visual Studio Code w systemie Windows (gospodarzu), łącząc się zdalnie do systemu Linux, co oszczędza zasoby komputera.

### Zadanie 4.1: Wygenerowanie kluczy asymetrycznych w Windows
1. Uruchom Wiersz Poleceń w Windows i wygeneruj klucz poleceniem: 
`ssh-keygen -t ed25519 -b 521`
2. Podczas pytań instalatora naciśnij dwukrotnie Enter (w środowisku szkoleniowym nie będziemy konfigurować hasła do klucza prywatnego).
3. Otwórz wygenerowany klucz publiczny w Notatniku, poleceniem: 
`notepad.exe .\.ssh\id_ed25519.pub` 
i skopiuj jego zawartość (Ctrl+A, Ctrl+C).

### Zadanie 4.2: Import klucza w systemie Debian
1. Wróć do maszyny z systemem Linux i upewnij się, że jesteś na koncie zwykłego użytkownika (np. `user`).
2. Utwórz ukryty katalog `.ssh`: 
`mkdir .ssh`
3. Utwórz plik z autoryzowanymi kluczami i otwórz go w edytorze tekstowym Midnight Commander: 
`mcedit .ssh/authorized_keys`
4. Wklej skopiowany z Windowsa klucz publiczny, zapisz plik (F2) i wyjdź (Escape dwukrotnie).
5. Utwórz katalog roboczy na projekt: 
`mkdir ~/terraform`

### Zadanie 4.3: Weryfikacja połączenia i konfiguracja VS Code Remote-SSH
1. W Wierszu Poleceń w Windows spróbuj połączyć się z Linuxem (upewnij się co do poprawnego adresu IP maszyny, np. tryb zmostkowany): `ssh user@<ADRES_IP_LINUXA>`. Jeśli nie zostaniesz zapytany o hasło, konfiguracja kluczy przebiegła pomyślnie. Zamknij połączenie poleceniem `exit`.
2. W Visual Studio Code otwórz zakładkę *Extensions* i zainstaluj "Remote-SSH" (autor: Microsoft).
3. W lewym dolnym rogu VS Code kliknij ikonę nawiasów `><` i wybierz opcję "Connect to Host..." z menu na górze.
4. Wybierz "Dodaj nowego hosta" i wpisz `user@<ADRES_IP_LINUXA>`. Wskaż system operacyjny hosta jako Linux.
5. Po nawiązaniu połączenia wybierz opcję otwierania folderu i wskaż wcześniej utworzony folder `/home/user/terraform/`.

---

## Część 5: Konfiguracja konta chmurowego AWS (Free-Tier)

W celu budowy testowej infrastruktury, wykorzystamy darmowy plan chmury Amazon Web Services (AWS). Usługa oferuje środowisko testowe, z pulą 100 dolarów przyznawaną na 6 miesięcy, co idealnie wystarczy na potrzeby kursu.

### Zadanie 5.1: Rejestracja
1. Przejdź pod adres: `https://aws.amazon.com/free/` i kliknij "Create a Free Account".
2. Podaj adres e-mail, wymyśloną nazwę konta i naciśnij "Verify email address".
3. Skopiuj kod weryfikacyjny otrzymany na podany e-mail i wpisz w formularzu.
4. Utwórz silne hasło do konta.
5. Wybierz darmowy wariant planu ("choose free plan") i uzupełnij prawidłowe dane kontaktowe.

### Zadanie 5.2: Weryfikacja płatności i tożsamości
AWS oraz większość dostawców chmurowych wymaga podpięcia karty płatniczej w celu weryfikacji tożsamości (minimalizuje to ryzyko nadużyć). Z konta blokowana jest i odblokowywana kwota ok. 1 EUR/USD.
* **Ważna wskazówka:** Aby zadbać o bezpieczeństwo swoich finansów, wygeneruj w swoim banku **Wirtualną Kartę Płatniczą** lub użyj karty z konta Revolut, na którą przelejesz minimalną kwotę weryfikacyjną (np. 5 PLN).
* Następnie podaj poprawny numer telefonu. AWS dokona ostatecznej weryfikacji tożsamości wysyłając Ci SMS z kolejnym kodem. Wpisanie fałszywego numeru uniemożliwi dokończenie rejestracji.

### Zadanie 5.3: Pierwsze logowanie i MFA
1. Zaloguj się z użyciem opcji "Sign in using root user email" wprowadzając e-mail i hasło pod adresem `https://aws.amazon.com/console/`.
2. Podczas pierwszego logowania po rejestracji system wymusi konfigurację mechanizmu uwierzytelniania dwuskładnikowego (MFA - Multi-factor authentication).
3. Pobierz na telefon aplikację np. *Google Authenticator*, wybierz w przeglądarce opcję "Authenticator App", zeskanuj kod QR (lub wywołaj go kliknięciem).
4. AWS wymaga podania dwóch sekwencyjnych kodów jednorazowych wygenerowanych przez aplikację – wpisz aktualnie widoczny kod, odczekaj i wpisz następny wygenerowany. 

Po pomyślnym zalogowaniu się z wykorzystaniem kodów MFA maszyna z środowiskiem pracy do laboratorium Terraform jest gotowa. Na kolejnych zajęciach zaczniemy ręcznie "wyklikiwać" infrastrukturę chmurową, aby następnie wykonać ten sam proces automatycznie w Terraform, uzyskując precyzyjny obraz działania tego narzędzia.
