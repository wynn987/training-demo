require 'test_helper'

class GrantApplicationTest < ActiveSupport::TestCase
  def setup
    @grant_application = GrantApplication.first
  end

  test 'should be valid' do
    assert @grant_application.valid?
  end

  test 'applicant name should be present' do
    @grant_application.applicant_name = ' '
    assert_not @grant_application.valid?
  end

  test 'application type should be present' do
    @grant_application.application_type = ' '
    assert_not @grant_application.valid?
  end

  test 'name should not be too long' do
    @grant_application.applicant_name = 'a' * 51
    assert_not @grant_application.valid?
  end

  test 'application type must be valid should not be too long' do
    @grant_application.application_type = 'aaaa'
    assert_not @grant_application.valid?
  end

  test 'application name should not have numbers' do
    @grant_application.applicant_name = '51'
    assert_not @grant_application.valid?
  end
end
