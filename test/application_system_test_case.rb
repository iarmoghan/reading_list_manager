require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # rack_test is stable and doesn’t need Chrome/Selenium
  driven_by :rack_test
end
