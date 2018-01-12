require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_not_signed_in_error(body)
    error_msg = 'You need to sign in or sign up before continuing.'
    assert_equal error_msg, JSON.parse(body)['errors'][0]
  end

  def assert_not_permitted_error(body)
    error_msg = 'you do not have permission to access this resource'
    assert_equal error_msg, JSON.parse(body)['error']
  end
end
