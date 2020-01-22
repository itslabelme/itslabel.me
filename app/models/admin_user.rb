class AdminUser < ApplicationRecord
  
  include Itslabel::Permissions::AdminUserPermissions

  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # , :registerable,

  validates :first_name, presence: true, length: {maximum: 256}, allow_blank: false
  validates :last_name, length: {maximum: 256}, allow_blank: true
  validates :mobile_number, length: {maximum: 24}, allow_blank: true
  
  # validates :email, presence: true, uniqueness: true, on: :create
  # validates :password, presence: true, on: :create
  # validates_confirmation_of :password
  
  def display_name
    [first_name, last_name].compact.join(" ")
  end

end
