class ApplicationController < ActionController::Base
  # Avoid blocking tests (rack_test user-agent is minimal)
  allow_browser versions: :modern unless Rails.env.test?
end
