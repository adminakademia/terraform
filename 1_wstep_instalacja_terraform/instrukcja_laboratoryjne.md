# 1. Wstęp do Terraform, przygotowanie wstępnego środowiska do zabaw z instalacją Terraform, oraz utworzenie konta w chmurze AWS


## Krok 1: Przygotowanie systemu Windows 11 i menedżera pakietów Winget
1. [cite_start]Sprawdź w systemie Windows czy winget działa prawidłowo, uruchamiając wiersz poleceń z uprawnieniami administratora i wpisując polecenie `winget search chrome`[cite: 1].
2. Jeśli polecenie nie daje żadnego wyniku, wejdź na stronę pobierania Windows App SDK i w sekcji Windows App Runtime pobierz instalator zgodny ze swoją architekturą, np. [cite_start]`windowsappuntimeinstall-x64.exe`[cite: 1].
3. [cite_start]Uruchom pobrany plik .exe jako administrator i zakończ instalację[cite: 1].
4. [cite_start]Przejdź na stronę wydań winget-cli w serwisie GitHub (https://github.com/microsoft/winget-cli/releases), kliknij w najnowszą wersję i zlokalizuj plik z rozszerzeniem `.msixbundle` do pobrania[cite: 2].
5. [cite_start]Uruchom wiersz poleceń z uprawnieniami administratora, przejdź do folderu pobierania i zainstaluj aktualizację poleceniem `Add-AppxPackage -Path Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle`[cite: 2].

## Krok 2: Instalacja narzędzia Terraform w systemie Windows
1. [cite_start]Pobierz najnowszą wersję aplikacji Terraform dla Windows (wybierając architekturę amd64) ze strony pobierania firmy HashiCorp[cite: 2].
2. [cite_start]Rozpakuj pobrane archiwum ZIP do folderu, na przykład `C:\terraform` (utwórz ten katalog, jeśli jeszcze nie istnieje)[cite: 3].
3. [cite_start]Otwórz "Zaawansowane ustawienia systemu" w systemie Windows[cite: 3].
4. [cite_start]Kliknij w "Zmienne środowiskowe", następnie w sekcji "Zmienne systemowe" edytuj zmienną "Path", wybierz "Nowy" i wklej ścieżkę `C:\terraform`[cite: 4].
5. [cite_start]Otwórz wiersz poleceń jako zwykły użytkownik i zweryfikuj instalację wpisując polecenie `terraform version`[cite: 5].
6. [cite_start]Alternatywnie, instalację narzędzia możesz przeprowadzić za pomocą menedżera winget, używając polecenia `winget install HashiCorp.Terraform`[cite: 5].

## Krok 3: Instalacja Visual Studio Code i niezbędnych rozszerzeń
1. [cite_start]Zainstaluj edytor Visual Studio Code korzystając z polecenia `winget install Microsoft.VisualStudioCode`[cite: 5].
2. [cite_start]Uruchom zainstalowany edytor i doinstaluj w nim rozszerzenia: "Polish Language Pack" oraz "HashiCorp Terraform"[cite: 5].

## Krok 4: Przygotowanie środowiska Debian 13 dla Terraform
1. [cite_start]Zaloguj się w systemie Debian 13 jako użytkownik "root", a następnie nadaj nazwę hosta dla systemu poleceniem `hostnamectl set-hostname terraform`[cite: 6].
2. [cite_start]Zaktualizuj oprogramowanie systemowe wykonując komendę `apt update && apt upgrade -y`[cite: 6].
3. [cite_start]Zainstaluj potrzebne pakiety narzędziowe wpisując `apt install sudo curl mc -y`[cite: 6].
4. [cite_start]Przejdź na oficjalną stronę instalacji Terraform (HashiCorp), wyszukaj polecenia dedykowane dla systemu Debian, skopiuj je i wklej do wiersza poleceń użytkownika "root"[cite: 6].

## Krok 5: Konfiguracja uwierzytelniania SSH między Windows a systemem Linux
1. [cite_start]W systemie Windows wygeneruj klucz SSH poleceniem `ssh-keygen -t ed25519 -b 521`[cite: 9].
2. [cite_start]W celach szkoleniowych, po zapytaniu o hasło do klucza prywatnego, naciśnij Enter pomijając jego podawanie[cite: 9].
3. [cite_start]Przejdź na system Linux i utwórz katalog dla wybranego konta użytkownika za pomocą polecenia `mkdir .ssh`[cite: 9].
4. [cite_start]Zaimportuj swój klucz publiczny SSH edytując plik poleceniem `mcedit .ssh/authorized_keys`[cite: 9].
5. [cite_start]Utwórz folder roboczy wpisując `mkdir ~/terraform`[cite: 9].
6. Przetestuj działanie połączenia wracając do systemu Windows i wpisując komendę np. [cite_start]`ssh user@192.168.111.134`[cite: 9].

## Krok 6: Konfiguracja zdalnej pracy w Visual Studio Code (Remote-SSH)
1. [cite_start]Systemem Debian 13 można teraz sterować z poziomu środowiska Visual Studio Code[cite: 8].
2. [cite_start]Otwórz VS Code, przejdź do zakładki Extensions i zainstaluj rozszerzenie "Remote-SSH" autorstwa Microsoft[cite: 9, 10].
3. [cite_start]Naciśnij przycisk "><" zlokalizowany w lewym dolnym rogu ekranu i wybierz opcję "Connect to Host..." z górnego menu[cite: 11].
4. [cite_start]Ewentualnie możesz wywołać paletę poleceń (klawisz F1 lub Ctrl+Shift+P) i wpisać "Remote-SSH: Connect to Host..."[cite: 12].
5. [cite_start]Wprowadź poświadczenia dokładnie w formacie `user@adres_ip` (np. `user@192.168.100.162`) i zatwierdź wybór Enterem[cite: 13].
6. [cite_start]Gdy program o to poprosi, wybierz system operacyjny hosta jako Linux[cite: 13].
7. [cite_start]Po nawiązaniu połączenia otwórz przygotowany wcześniej folder `/home/user/terraform/`[cite: 14].

## Krok 7: Założenie konta chmurowego AWS (Free-Tier)
1. [cite_start]Przejdź pod adres `https://aws.amazon.com/free/` i rozpocznij zakładanie konta klikając opcję "Create a Free Account"[cite: 14].
2. [cite_start]Podaj swój adres email oraz preferowaną nazwę konta[cite: 14].
3. [cite_start]Kliknij w przycisk "Verify email address" i wprowadź kod weryfikacyjny, który przyszedł na Twoją skrzynkę[cite: 15].
4. [cite_start]Podaj docelowe hasło, którego chcesz używać do logowania[cite: 16].
5. [cite_start]Wybierz z listy plan darmowy, a następnie uzupełnij wymagane dane kontaktowe oraz informacje z karty płatniczej[cite: 16].
6. [cite_start]Pamiętaj, że z podanej karty pobierana jest opłata weryfikacyjna w wysokości jednego euro[cite: 17].
7. [cite_start]Zakończ proces wpisując kod z wiadomości SMS, który został wysłany na podany numer telefonu[cite: 17].
8. [cite_start]Zaloguj się na utworzone konto poprzez stronę `https://aws.amazon.com/console/`, wybierając pozycję "Sign in using root user email"[cite: 18].
