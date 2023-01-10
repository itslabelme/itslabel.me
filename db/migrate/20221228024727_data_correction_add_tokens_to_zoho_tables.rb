# Regarding Payment integration task, Delete subscriptions table data and subscription_permissions table date then add new data
class DataCorrectionAddTokensToZohoTables < ActiveRecord::Migration[5.2]
  def change

    zoho_tokens = ZohoToken.all
    if zoho_tokens.length > 1
      zoho_tokens.each do |each_zoho_tokens|
        if each_zoho_tokens
          each_zoho_tokens.delete
          puts "Zoho Token exist so deleted"
        end
      end
    end


    zoho_token = ZohoToken.new
    zoho_token.access_token = "1000.efd0a30f2a064e9bd060e497cc5ffbe4.721a3358fea351183c687e2b4daeece8"
    zoho_token.refresh_token = "1000.1f60701ed10cd9e4218ce6269fac16d2.9e36c2a7b3f94bb542d5073b9d542d59"
    zoho_token.token_expires_in = "3600"

    if zoho_token.valid?
      zoho_token.save
    else
      puts "Couldn't save zoho_token with access_token #{zoho_token.access_token}".red
    end

  end
end



 