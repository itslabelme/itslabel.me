# Regarding Payment integration task, Delete subscriptions table data and subscription_permissions table date then add new data
class DataCorrectionAddUserSub1May22 < ActiveRecord::Migration[5.2]
  def change

    users = ClientUser.all

    users.each do |each_user|
      if each_user.user_subscription
        puts "User sub exist"
      else
        user_subscription = UserSubscription.new
        user_subscription.user_id = each_user.id
        user_subscription.subscription_id = Subscription.find_by_title("Free").id

        if user_subscription.valid?
          user_subscription.save
        end
      end
    end
  end
end



 