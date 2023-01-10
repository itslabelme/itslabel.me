class CreateZohoTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :zoho_tokens do |t|
      t.string :access_token, null: false   
      t.string :refresh_token, null: false   
      t.string :token_expires_in, null: false   
      t.timestamps 
    end
  end
end