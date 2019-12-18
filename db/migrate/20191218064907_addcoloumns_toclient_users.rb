class AddcoloumnsToclientUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :client_users, :first_name, :string
    add_column :client_users, :last_name, :string
    add_column :client_users, :phone, :integer
    add_column :client_users, :organisation, :string
  end
end
