class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # , :registerable,
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  validates :first_name,:last_name,:password, :email, presence: true
  validates :email, uniqueness: true
end
