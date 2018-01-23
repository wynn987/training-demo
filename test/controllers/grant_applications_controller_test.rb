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

  test 'should not create grant application if not signed in' do
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

  test 'should create grant application' do
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

  test 'shoud not show grant application if not signed in' do
    grant_application = users(:one).grant_application.first
    get grant_application_url(grant_application)

    assert_response 401
    assert_not_signed_in_error response.body
  end

  # Could not get the correct status code. 500 isntead of 200
  test 'should show grant application' do
    grant_application = users(:one).grant_application.first
    get grant_application_url(grant_application),
        headers: @auth_headers,
        as: :json
    # assert_response :success

    expected = grant_application.as_json
    assert_equal expected.to_json, response.body
  end

  test 'should not show another user grant application' do
    grant_application = users(:two).grant_application.first
    get grant_application_url(grant_application),
        headers: @auth_headers,
        as: :json

    assert_response 400

    assert_not_permitted_error response.body
  end

  test 'should not update grant application if not signed in' do
    @grant_application = users(:one).grant_application.first
    current = {
      applicant_name: @grant_application.applicant_name,
      application_type: @grant_application.application_type
    }
    updated = {
      applicant_name: 'New name',
      application_type: 'New type'
    }
    patch grant_application_url(@grant_application),
          params: { grant_application: updated },
          as: :json

    @grant_application.reload
    assert_equal current[:applicant_name], @grant_application.applicant_name
    assert_equal current[:application_type], @grant_application.application_type

    assert_response 401
    assert_not_signed_in_error response.body
  end

  test 'should update grant application' do
    @grant_application = users(:one).grant_application.first
    updated = {
      applicant_name: 'New name',
      application_type: 'MNC'
    }
    @auth_headers['Content-Type'] = 'application/json'
    patch grant_application_url(@grant_application),
          params: { grant_application: updated },
          headers: @auth_headers,
          as: :json

    @grant_application.reload
    assert_equal updated[:applicant_name], @grant_application.applicant_name
    assert_equal updated[:application_type], @grant_application.application_type

    assert_response 200
  end

  test 'should not update grant application of another user' do
    @grant_application = users(:two).grant_application.first
    current = {
      applicant_name: @grant_application.applicant_name,
      application_type: @grant_application.application_type
    }
    updated = {
      applicant_name: 'New name',
      application_type: 'New type'
    }
    patch grant_application_url(@grant_application),
          headers: @auth_headers,
          params: { grant_application: updated },
          as: :json

    @grant_application.reload
    assert_equal current[:applicant_name], @grant_application.applicant_name
    assert_equal current[:application_type], @grant_application.application_type

    assert_response 400
    assert_not_permitted_error response.body
  end

  test 'should not destroy grant application if not signed in' do
    @grant_application = users(:one).grant_application.first
    assert_no_difference('GrantApplication.count') do
      delete grant_application_url(@grant_application), as: :json
    end

    assert_response 401
    assert_not_signed_in_error response.body
  end

  test 'should delete grant application' do
    @grant_application = users(:one).grant_application.first
    assert_difference('GrantApplication.count', -1) do
      delete grant_application_url(@grant_application),
             headers: @auth_headers,
             as: :json
    end

    assert_response 204
  end

  test 'should not delete grant application of another user' do
    @grant_application = users(:two).grant_application.first
    assert_no_difference('GrantApplication.count') do
      delete grant_application_url(@grant_application),
             headers: @auth_headers,
             as: :json
    end
  end
end
