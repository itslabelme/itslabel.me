# Regarding Payment integration task, Delete subscriptions table data and subscription_permissions table date then add new data
class DataCorrectionPopulateJun21 < ActiveRecord::Migration[5.2]
  def change


    susbscription_date = [
          { title: 'Monthly',  price: 49.99, status: "Active"}, 
          { title: '3 Months',  price: 149.99, status: "Active"},
          { title: '6 Months',  price: 269.99, status: "Active"}, 
          { title: '12 Months',  price: 509.99, status: "Active"}, 
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



 