class AdminUser < ApplicationRecord
  
  include Itslabel::Permissions::AdminUserPermissions

  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # , :registerable,

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, on: :create
  validates :password, presence: true, on: :create
  validates_confirmation_of :password
  # validates :password, confirmation: { case_sensitive: true }
  
  def display_name
    [first_name, last_name].compact.join(" ")
  end

end
