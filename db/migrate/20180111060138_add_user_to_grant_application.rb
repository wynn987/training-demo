class AddUserToGrantApplication < ActiveRecord::Migration[5.1]
  def change
    add_reference :grant_applications, :user, foreign_key: true
  end
end
