class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # , :registerable,
  #attr_accessor :email, :first_name,:last_name,:organisation,:phone, :password, :password_confirmation
  #has_secure_password
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  #validates :first_name,:last_name,:password, :email, presence: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, on: :create
 # validates :password, confirmation: { case_sensitive: true }
  validates_confirmation_of:password
end
