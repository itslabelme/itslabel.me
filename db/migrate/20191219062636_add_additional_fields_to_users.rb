class AddAdditionalFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :first_name, :string
    add_column :admin_users, :last_name, :string
    add_column :admin_users, :phone, :bigint
    add_column :admin_users, :organisation, :string

    add_column :client_users, :first_name, :string
    add_column :client_users, :last_name, :string
    add_column :client_users, :phone, :bigint
    add_column :client_users, :organisation, :string
  end
end
