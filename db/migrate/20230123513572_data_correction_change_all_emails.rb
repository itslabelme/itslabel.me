class DataCorrectionChangeAllEmails < ActiveRecord::Migration[5.2]
  def change
    ClientUser.all.each do |user|
      next if user.destroyed? 
      user.email = "#{user.id}-#{user.email}"
      user.position = "Not Mentioned" if user.position.blank?
      user.save
      user.destroy
    end
  end
end



 