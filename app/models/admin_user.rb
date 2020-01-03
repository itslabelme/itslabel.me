class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # , :registerable,
 include Itslabel::Permissions::AdminUserPermissions
  devise :database_authenticatable, :recoverable, :rememberable
  #validates :first_name,:last_name,:password, :email, presence: true
  validates :email, presence: true, uniqueness: true, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, on: :create
 # validates :password, confirmation: { case_sensitive: true }
  validates_confirmation_of:password
  def display_name
    [first_name, last_name].compact.join(" ")
  end
end
