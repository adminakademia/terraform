# Instrukcja Laboratoryjna: Podstawy Terraform i konfiguracja środowiska roboczego

## Krok 1: Przygotowanie systemu Windows 11 i menedżera pakietów Winget
1. Sprawdź w systemie Windows, czy winget działa prawidłowo, uruchamiając wiersz poleceń z uprawnieniami administratora i wpisując polecenie: `winget search chrome`.
2. Jeśli polecenie nie daje żadnego wyniku, wejdź na stronę pobierania Windows App SDK i w sekcji Windows App Runtime pobierz instalator zgodny ze swoją architekturą, np. `windowsappuntimeinstall-x64.exe`.
3. Uruchom pobrany plik .exe jako administrator i zakończ instalację.
4. Przejdź na stronę wydań winget-cli w serwisie GitHub (https://github.com/microsoft/winget-cli/releases), kliknij w najnowszą wersję i zlokalizuj plik z rozszerzeniem `.msixbundle` do pobrania.
5. Uruchom wiersz poleceń z uprawnieniami administratora, przejdź do folderu pobierania i zainstaluj aktualizację poleceniem:
   `Add-AppxPackage -Path Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle`

## Krok 2: Instalacja narzędzia Terraform w systemie Windows
1. Pobierz najnowszą wersję aplikacji Terraform dla Windows (wybierając architekturę amd64) ze strony pobierania firmy HashiCorp.
2. Rozpakuj pobrane archiwum ZIP do folderu, na przykład `C:\terraform` (utwórz ten katalog, jeśli jeszcze nie istnieje).
3. Otwórz "Ustawienia systemu" -> "Zaawansowane ustawienia systemu" w systemie Windows.
4. Kliknij w "Zmienne środowiskowe", następnie w sekcji "Zmienne systemowe" edytuj zmienną "Path", wybierz "Nowy" i wklej ścieżkę `C:\terraform`. Zapisz zmiany klikając "OK".
5. Otwórz wiersz poleceń jako zwykły użytkownik i zweryfikuj instalację wpisując polecenie: `terraform version`.
6. Alternatywnie, instalację narzędzia możesz przeprowadzić za pomocą menedżera winget, używając poleceń:
   `winget search terraform`
   `winget install HashiCorp.Terraform`
   `winget upgrade --all`

## Krok 3: Instalacja Visual Studio Code i niezbędnych rozszerzeń
1. Zainstaluj edytor Visual Studio Code korzystając z polecenia: `winget install Microsoft.VisualStudioCode` (lub pobierz go bezpośrednio ze strony https://code.visualstudio.com/download).
2. Zainstaluj również przeglądarkę (opcjonalnie): `winget install Google.Chrome`.
3. Uruchom zainstalowany edytor VS Code i doinstaluj w nim rozszerzenia: `Polish Language Pack` oraz `HashiCorp Terraform`.

## Krok 4: Przygotowanie środowiska Debian 13 dla Terraform
1. Zaloguj się w systemie Debian 13 jako użytkownik "root", a następnie nadaj nazwę hosta dla systemu poleceniem: `hostnamectl set-hostname terraform`.
2. Zaktualizuj oprogramowanie systemowe wykonując komendę: `apt update && apt upgrade -y`.
3. Zainstaluj potrzebne pakiety narzędziowe wpisując: `apt install sudo curl mc -y`.
4. Przejdź na oficjalną stronę instalacji Terraform (HashiCorp), wyszukaj instrukcje dedykowane dla systemu Debian, skopiuj odpowiednie polecenia i wklej je do wiersza poleceń użytkownika "root".

## Krok 5: Konfiguracja uwierzytelniania SSH między Windows a systemem Linux
1. W systemie Windows wygeneruj klucz SSH poleceniem: `ssh-keygen -t ed25519 -b 521`.
2. W celach szkoleniowych, po zapytaniu o hasło do klucza prywatnego, naciśnij Enter pomijając jego podawanie (w środowisku produkcyjnym należy stosować silne hasła).
3. Zobacz klucz publiczny, aby móc go skopiować: `notepad.exe .\.ssh\id_ed25519.pub`.
4. Przejdź na system Linux i utwórz katalog dla wybranego konta użytkownika za pomocą polecenia: `mkdir .ssh`.
5. Zaimportuj swój klucz publiczny SSH z Windowsa edytując plik poleceniem: `mcedit .ssh/authorized_keys` (i wklejając tam zawartość klucza).
6. Utwórz folder roboczy wpisując: `mkdir ~/terraform`.
7. Przetestuj działanie połączenia wracając do systemu Windows i wpisując komendę np. `ssh user@192.168.111.134`.

## Krok 6: Konfiguracja zdalnej pracy w Visual Studio Code (Remote-SSH)
1. Otwórz VS Code w systemie Windows.
2. Przejdź do zakładki Extensions (ikona puzzla po lewej lub Ctrl+Shift+X) i wyszukaj "Remote-SSH" (autor: Microsoft), a następnie kliknij "Install".
3. Naciśnij przycisk `><` zlokalizowany w lewym dolnym rogu ekranu i wybierz opcję "Connect to Host..." z górnego menu.
4. Ewentualnie możesz wywołać paletę poleceń (klawisz F1 lub Ctrl+Shift+P) i wpisać "Remote-SSH: Connect to Host...".
5. Wprowadź poświadczenia dokładnie w formacie `uzytkownik@IP_lub_nazwahosta` (np. `user@192.168.100.162`) i zatwierdź wybór klawiszem Enter.
6. Gdy program o to poprosi, wybierz system operacyjny hosta jako "Linux".
7. Po nawiązaniu połączenia otwórz przygotowany wcześniej folder `/home/user/terraform/`.

## Krok 7: Założenie konta chmurowego AWS (Free-Tier)
1. Przejdź pod adres `https://aws.amazon.com/free/` i rozpocznij zakładanie konta klikając opcję "Create a Free Account".
2. Podaj swój adres email oraz preferowaną nazwę konta.
3. Kliknij w przycisk "Verify email address" i wprowadź kod weryfikacyjny, który przyszedł na Twoją skrzynkę email.
4. Podaj docelowe silne hasło, którego chcesz używać do logowania.
5. Wybierz z listy plan darmowy, a następnie uzupełnij wymagane dane kontaktowe oraz informacje z karty płatniczej.
6. Zwróć uwagę, że z podanej karty w celach weryfikacyjnych pobierana jest kwota 1 euro.
7. Zakończ proces autoryzacji wpisując kod z wiadomości SMS, który został wysłany na podany przez Ciebie numer telefonu.
8. Zaloguj się na utworzone konto poprzez stronę `https://aws.amazon.com/console/`, wybierając pozycję "Sign in using root user email", a następnie "Root user".
