# This controller handles calls related to GrantApplication and uses Device to
# authenticate requests
class GrantApplicationsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @grant_applications = GrantApplication.all
    render json: @grant_applications
  end

  def create
    @grant_application = GrantApplication.new(create_params)

    @grant_application = determine_grant_application_status(@grant_application)

    if @grant_application.save
      render json: @product, status: :success
    else
      rend json: @product.errors, status: :failure
    end
  end

  private

  def determine_grant_application_status(grant_application)
    grant_application.status =
      if not_fraud_check(grant_application)
        'PENDING'
      else
        'FLAGGED'
      end
    grant_application
  end

  # stub function for fraud detection
  def not_fraud_check(grant_application)
    grant_application
  end

  def create_params
    params.require(:grant_application).permit(:applicant_name, :application_type)
  end
end
