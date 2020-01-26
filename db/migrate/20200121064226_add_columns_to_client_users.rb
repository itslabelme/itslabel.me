class AddColumnsToClientUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :client_users, :provider, :string
    add_column :client_users, :uid, :string
    add_column :client_users, :image, :text
  end
end
