# Regarding Payment integration task, Delete subscriptions table data and subscription_permissions table date then add new data
class DataCorrectionAddUserSubDataToZohoSub < ActiveRecord::Migration[5.2]
  def change

    user_sub_datas = UserSubscription.all
    if user_sub_datas.length > 1
      user_sub_datas.each do |each_user_sub_datas|
        if each_user_sub_datas

          zoho_user_exist = ZohoSubData.find_by_client_user_id(each_user_sub_datas.user_id)
          if zoho_user_exist
            zoho_user_exist.subscription_id = each_user_sub_datas.subscription_id
            if zoho_user_exist.valid?
              zoho_user_exist.save
            else
              puts "couldn't update zoho user data".green
            end
          else
            zoho_sub_data = ZohoSubData.new
            zoho_sub_data.client_user_id = each_user_sub_datas.user_id
            zoho_sub_data.subscription_id = each_user_sub_datas.subscription_id

            zoho_sub_data.zoho_customer_id = "1"
            zoho_sub_data.zoho_subscription_id = "1"
            zoho_sub_data.zoho_plan_code = "1"
            
            if zoho_sub_data.valid?
              zoho_sub_data.save
            else
              puts "Couldn't save zoho_sub_data with access_token".red
            end
          end


        end
      end
    end
  end
end



 