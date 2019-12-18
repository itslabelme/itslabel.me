class AddOrganisationToadminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :organisation, :string
  end
end
