class DataCorrectionAddFiledForParanoid < ActiveRecord::Migration[5.2]
  def change
    # add_column :client_users, :deleted_at, :datetime
    add_index :client_users, :deleted_at
  end
end



 