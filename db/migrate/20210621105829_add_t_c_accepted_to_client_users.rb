class AddTCAcceptedToClientUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :client_users, :t_c_accepted, :boolean
  end
end
