# Regarding Payment integration task, Delete subscriptions table data and subscription_permissions table date then add new data
class DataCorrectionPopulateMay22 < ActiveRecord::Migration[5.2]
  def change


    susbscription_date = [
          { title: 'Free',  price: 0, status: "Active"}, 
          { title: 'Premium',  price: 49, status: "Active"} 
      ]

    susbscription_date.each do |sub_data|
      susbscription = Subscription.new
      susbscription.title = sub_data[:title]
      susbscription.price = sub_data[:price]
      susbscription.status = sub_data[:status]

      if susbscription.valid?
        susbscription.save
      else
        puts "Couldn't save susbscription with title #{sub_data[:title]}".red
      end
    end


  end
end



 