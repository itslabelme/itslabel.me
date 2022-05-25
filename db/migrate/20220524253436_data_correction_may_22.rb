# Regarding Payment integration task, Delete subscriptions table data and subscription_permissions table date then add new data
class DataCorrectionMay22 < ActiveRecord::Migration[5.2]
  def change
    susbscription = Subscription.all
    susbscription.delete_all
    # drop_table :subscriptions

    susbscription_permission = SubscriptionPermission.all
    susbscription_permission.delete_all
    # drop_table :subscription_permissions

  end
end
