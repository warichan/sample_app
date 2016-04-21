class RemoveResetSendAtToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :reset_send_at, :string
  end
end
