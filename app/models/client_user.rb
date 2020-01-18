class ClientUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      # max_paginates_per 2
      
   def display_name
    [first_name, last_name].compact.join(" ")
  end
end
