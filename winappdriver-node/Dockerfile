# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2022

SHELL ["cmd", "/S", "/C"]

# Instala o Chocolatey para facilitar instalações
RUN powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Instala WinAppDriver
RUN choco install winappdriver --version=1.2.1 -y

# Instala Java (necessário para Selenium Node)
RUN choco install openjdk --version=17.0.10 -y

# Baixa Selenium Server
ADD https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.21.0/selenium-server-4.21.0.jar C:/selenium-server.jar

# Expõe as portas necessárias
EXPOSE 4723 5555

# Inicia WinAppDriver e Selenium Node
CMD start /B WinAppDriver.exe 4723 & java -jar C:/selenium-server.jar node --override-max-sessions true --max-sessions 1 --detect-drivers false --port 5555 --register --hub http://selenium-hub:4444/grid/register
