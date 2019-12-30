class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # , :registerable,
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  def display_name
    [first_name, last_name].compact.join(" ")
  end

end
