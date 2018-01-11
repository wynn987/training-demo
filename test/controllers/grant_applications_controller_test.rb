require 'test_helper'

class GrantApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_one = users(:one).create_new_auth_token
    @auth_headers = @user_one
  end

  test 'should not get index if not signed in' do
    get grant_applications_url

    assert_response 401
    assert_not_signed_in_error response.body
  end

  test 'should get index' do
    get grant_applications_url, headers: @auth_headers, as: :json

    assert_response :success

    existing_grants = users(:one).grant_application
    expected = existing_grants.as_json

    assert_equal expected.to_json, response.body
  end

  test 'should not create if not signed in' do
    @grant_application = {
      applicant_name: 'wynn',
      application_type: 'SME'
    }
    assert_no_difference('GrantApplication.count') do
      post grant_applications_url,
           params: { grant_application: @grant_application },
           as: :json
    end
  end

  test 'should create' do
    @grant_application = {
      applicant_name: 'wynn',
      application_type: 'SME'
    }
    assert_difference('GrantApplication.count', 1) do
      post grant_applications_url,
           headers: @auth_headers,
           params: { grant_application: @grant_application },
           as: :json
    end
  end
end
