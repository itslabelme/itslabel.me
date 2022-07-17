# Regarding Payment integration task, Delete subscriptions table data and subscription_permissions table date then add new data
class DataCorrectionJun21 < ActiveRecord::Migration[5.2]
  def change
    susbscription = Subscription.find_by_title('Premium')

    susbscription_permission = SubscriptionPermission.where(subscription_id: susbscription.id)

    susbscription_permission.delete_all

    susbscription.delete

  end
end
