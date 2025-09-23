require 'appium_lib'

module WinAppDriverWorld
  def driver
    @driver ||= Appium::Driver.new({
      caps: {
        platformName: 'Windows',
        deviceName: 'WindowsPC',
        app: 'Microsoft.WindowsCalculator_8wekyb3d8bbwe!App',
      },
      appium_lib: {
        server_url: 'http://winappdriver-node:4723'
      }
    }, true)
    @driver.start_driver unless @driver.driver
    @driver
  end
end

World(WinAppDriverWorld)

Before do
  driver
end

After do
  driver.quit_driver if @driver
end
