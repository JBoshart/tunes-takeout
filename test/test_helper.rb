ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/spec'
require "minispec-metadata"
require 'vcr'
require 'minitest-vcr'
require 'webmock/minitest'
require "minitest/reporters"

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
MinitestVcr::Spec.configure!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # From Jeremy's lecture on testing, I've added it to come back to if I have time: 
  # OmniAuth.config.test_mode = true
  # OmniAuth.config.mock_auth[:spotify_known] = OmniAuht:AuthHash.new(
  # { provider: 'spotify', info: { id: "known_user", display_name: "known_user" }
  # })
end
