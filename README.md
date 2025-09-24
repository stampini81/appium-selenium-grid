# Appium + Selenium Grid + Ruby + WinAppDriver

![Selenium Grid](IMG/SELENIUM.png)
![Appium Logo](IMG/APPIUM.png)
![Ruby Logo](https://www.ruby-lang.org/images/header-ruby-logo.png)
![WinAppDriver Logo](IMG/WINAPP%20DRIVE.png)

## Visão Geral
Este projeto demonstra como orquestrar testes automatizados usando Selenium Grid, Ruby, e WinAppDriver para automação da Calculadora do Windows.

> **Atenção:** WinAppDriver só funciona em Windows. Para rodar tudo em containers, é necessário Docker com suporte a containers Windows. Em ambientes Linux (ex: Codespaces), só é possível rodar testes web ou mobile Android.

---

## Estrutura do Projeto

```
appium-selenium-grid/
├── docker-compose.yml
├── winappdriver-node/
│   └── Dockerfile
├── ruby-tests/
│   ├── Dockerfile
│   ├── Gemfile
│   ├── Gemfile.lock
│   ├── calculator_test.rb
│   └── features/
│       ├── soma.feature
│       ├── step_definitions/
│       │   └── calculadora_steps.rb
│       └── support/
│           └── hooks.rb
```

---

## Ferramentas Utilizadas

- **Selenium Grid** ![Selenium Grid](IMG/SELENIUM.png)
  - Orquestra e distribui os testes.
- **WinAppDriver** ![WinAppDriver](IMG/WINAPP%20DRIVE.png)
  - Permite automação de apps Windows.
- **Ruby** ![Ruby Logo](https://www.ruby-lang.org/images/header-ruby-logo.png)
  - Linguagem dos testes.
- **Appium Lib** ![Appium Logo](IMG/APPIUM.png)
  - Biblioteca Ruby para automação.
- **Cucumber** ![Cucumber Logo](IMG/CUCUMBER.png)
  - BDD para Ruby.
- **Docker Compose** ![Docker Logo](https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png)
  - Orquestração dos containers.

---

## Como Executar

### 1. Pré-requisitos
- Windows 10/11 Pro/Enterprise ou Windows Server
- Docker Desktop configurado para containers Windows

### 2. Clone o repositório
```sh
git clone https://github.com/seu-usuario/appium-selenium-grid.git
cd appium-selenium-grid
```

### 3. Build e execução dos containers
```sh
docker-compose up --build
```

### 4. Resultado
O Cucumber executa o teste BDD na Calculadora do Windows. O resultado aparece no terminal do container `ruby-tests`.

---

## Exemplos de Código

### docker-compose.yml
```yaml
version: '3.8'

services:
  selenium-hub:
    image: selenium/hub:4.21.0
    container_name: selenium-hub
    ports:
      - "4444:4444"
    networks:
      - grid

  winappdriver-node:
    build:
      context: ./winappdriver-node
      dockerfile: Dockerfile
    container_name: winappdriver-node
    environment:
      - SE_EVENT_BUS_HOST=selenium-hub
      - SE_EVENT_BUS_PUBLISH_PORT=4442
      - SE_EVENT_BUS_SUBSCRIBE_PORT=4443
    ports:
      - "4723:4723" # WinAppDriver default
    networks:
      - grid
    depends_on:
      - selenium-hub

  ruby-tests:
    build:
      context: ./ruby-tests
      dockerfile: Dockerfile
    container_name: ruby-tests
    networks:
      - grid
    depends_on:
      - selenium-hub
      - winappdriver-node
    command: ["cucumber"]

networks:
  grid:
    driver: bridge

```

### calculator_test.rb
```ruby
require 'appium_lib'
require 'rspec'

desired_caps = {
  caps: {
    platformName: 'Windows',
    deviceName: 'WindowsPC',
    app: 'Microsoft.WindowsCalculator_8wekyb3d8bbwe!App',
  },
  appium_lib: {
    server_url: 'http://winappdriver-node:4723'
  }
}

RSpec.describe 'Calculadora do Windows' do
  before(:all) do
    @driver = Appium::Driver.new(desired_caps, true)
    @driver.start_driver
  end

  after(:all) do
    @driver.quit_driver
  end

  it 'soma 1 + 2' do
    @driver.find_element(:name, 'Um').click
    @driver.find_element(:name, 'Mais').click
    @driver.find_element(:name, 'Dois').click
    @driver.find_element(:name, 'Igual a').click
    resultado = @driver.find_element(:accessibility_id, 'CalculatorResults').text
    expect(resultado).to include('3')
  end
end
```

### features/soma.feature
```gherkin
Feature: Addition in Windows Calculator
  As a user
  I want to add two numbers
  So that I get the correct result

  Scenario: Add 1 + 2
    Given the Calculator is open
    When I press "1"
    And I press +
    And I press "2"
    And I press =
    Then the result should be 3
```

---

## Observações
- Para automação web ou mobile, adapte o setup conforme necessário.
- Para rodar WinAppDriver, containers Windows são obrigatórios.
- Em ambientes Linux/Codespaces, use apenas Selenium Grid para web ou Appium para Android.

---

## Créditos
- [SeleniumHQ](https://www.selenium.dev/)
- [Appium](https://appium.io/)
- [WinAppDriver](https://github.com/microsoft/WinAppDriver)
- [Ruby](https://www.ruby-lang.org/)
- [Cucumber](https://cucumber.io/)
- [Docker](https://www.docker.com/)
