class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.references :client_user, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
