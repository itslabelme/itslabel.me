class ChangeIntegerLimitInAdminUsers < ActiveRecord::Migration[5.2]
  def change
     change_column :admin_users, :phone, :bigint
  end
end
