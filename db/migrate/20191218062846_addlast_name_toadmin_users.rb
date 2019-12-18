class AddlastNameToadminUsers < ActiveRecord::Migration[5.2]
  def change
     add_column :admin_users, :last_name, :string
  end
end
