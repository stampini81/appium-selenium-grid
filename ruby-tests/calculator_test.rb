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
