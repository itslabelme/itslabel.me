class AddPhoneNumberToadminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :phone, :integer
  end
end
