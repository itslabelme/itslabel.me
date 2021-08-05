class AddFlagToClientUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :client_users, :flag, :boolean
  end
end
