class RemoveAuthorFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :remenber_degest, :string
  end
end
