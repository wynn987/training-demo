class CreateGrantApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :grant_applications do |t|
      t.string :applicant_name
      t.string :application_type
      t.string :status

      t.timestamps
    end
  end
end
