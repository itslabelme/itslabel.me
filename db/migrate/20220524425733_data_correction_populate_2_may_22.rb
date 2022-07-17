# Regarding Payment integration task, Delete subscriptions table data and subscription_permissions table date then add new data
class DataCorrectionPopulate2May22 < ActiveRecord::Migration[5.2]
  def change



 susbscription_permission_data = [
        { title: 'Free',  permission_id: 1, subscription_id: 1}, 
        { title: 'Free',  permission_id: 2, subscription_id: 1}, 
        { title: 'Free',  permission_id: 3, subscription_id: 1}, 
        { title: 'Free',  permission_id: 4, subscription_id: 1}, 
        { title: 'Free',  permission_id: 5, subscription_id: 1}, 
        { title: 'Free',  permission_id: 6, subscription_id: 1}, 


        { title: 'Premium',  permission_id: 1, subscription_id: 2}, 
        { title: 'Premium',  permission_id: 2, subscription_id: 2}, 
        { title: 'Premium',  permission_id: 3, subscription_id: 2}, 
        { title: 'Premium',  permission_id: 4, subscription_id: 2}, 
        { title: 'Premium',  permission_id: 5, subscription_id: 2}, 
        { title: 'Premium',  permission_id: 6, subscription_id: 2}, 
        { title: 'Premium',  permission_id: 7, subscription_id: 2}, 
        { title: 'Premium',  permission_id: 8, subscription_id: 2}, 
        { title: 'Premium',  permission_id: 9, subscription_id: 2}, 
        { title: 'Premium',  permission_id: 10, subscription_id: 2}, 
        { title: 'Premium',  permission_id: 11, subscription_id: 2}, 
     
     ]
     
    susbscription_permission_data.each do |sub_per_data|
      susbscription_perm = SubscriptionPermission.new
      susbscription_perm.title = sub_per_data[:title]
      susbscription_perm.permission_id = Permission.find_by_id(sub_per_data[:permission_id]).id
      susbscription_perm.subscription_id = Subscription.find_by_title(sub_per_data[:title]).id

      if susbscription_perm.valid?
        susbscription_perm.save
      else
        puts "Couldn't save Subscription Permission with title #{sub_per_data[:title]}".red
      end
    end
  end
end



 