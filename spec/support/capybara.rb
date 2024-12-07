# spec/support/capybara.rb
require Rails.root.join("spec", "support", "download_helper")
Capybara.server = :puma, { Silent: true }
# Set the host and port
Capybara.server_host = ENV.fetch("LOCAL_IP", IPSocket.getaddress(Socket.gethostname))
Capybara.server_port = 4000
Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
SELENIUM_URL = ENV.fetch("SELENIUM_URL", "http://selenium:4444/wd/hub")

## Allow file downloads in Google Chrome when headless!!!
# :reek:UtilityFunction
def configure_download_behavior(driver)
  driver.browser.execute_cdp("Page.setDownloadBehavior",
                             behavior: "allow",
                             downloadPath: DownloadHelpers::DOWNLOAD_PATH.to_s)
end
# Browser option block
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument("--headless")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--window-size=1400,1400")

options.add_preference(:download, prompt_for_download: false, default_directory: DownloadHelpers::DOWNLOAD_PATH.to_s)
options.add_preference(:browser, set_download_behavior: { behavior: "allow" })
options.add_preference("profile.content_settings.exceptions.clipboard", {
                         "*": { setting: 1 }
                       })
options.add_argument("--allow-insecure-localhost")
options.add_argument("--unsafely-treat-insecure-origin-as-secure=#{Capybara.app_host}")

# Register chrome headless remote driver
Capybara.register_driver :chrome_headless_remote do |app|
  driver = Capybara::Selenium::Driver.new(app, browser: :remote, url: SELENIUM_URL, options:)
  configure_download_behavior(driver)
  driver
end

# Register chrome headless local driver
Capybara.register_driver :chrome_headless do |app|
  driver = Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
  configure_download_behavior(driver)
  driver
end
# Select javascript driver
javascript_driver = case ENV.fetch("CAPYBARA_DRIVER", nil)
                    when /chrome_headless_remote/
                      :chrome_headless_remote
                    else
                      ENV.fetch("HEADLESS", false) ? :selenium_chrome : :chrome_headless
                    end
# Setup Capybara
Capybara.javascript_driver = javascript_driver
# Setup rspec
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, :js, type: :system) do
    driven_by javascript_driver
  end
end
