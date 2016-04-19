class AddAdminToUsers < ActiveRecord::Migration
  def change
    # default: falseを与えなくてもadminはdefaultでnil(falseと同じ意味)。明示する事で分かりやすくする為。
    add_column :users, :admin, :boolean, default: false
  end
end
