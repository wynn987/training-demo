# model for grant application
class GrantApplication < ApplicationRecord
  before_save { application_type.upcase }
  VALID_APPLICANT_NAME_REGEX = /[A-Z]/i

  belongs_to :user
  validates_presence_of :user
  validates :applicant_name, presence: true, length: { maximum: 50 },
                             format: { with: VALID_APPLICANT_NAME_REGEX }
  validates :application_type, presence: true
  validate :valid_application_type

  def valid_application_type
    valid_application_type_list = %w[SME MNC]
    errors.add(:application_type, 'is invalid') unless
      valid_application_type_list.include? application_type
  end
end
