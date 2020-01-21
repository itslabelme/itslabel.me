class ClientUser < ApplicationRecord

  # Include default devise modules. 
  # Others available are:
  # :lockable, :timeoutable and :omniauthable
  # max_paginates_per 2
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  validates :first_name, presence: true, length: {maximum: 256}, allow_blank: false
  validates :last_name, length: {maximum: 256}, allow_blank: true
  validates :mobile_number, length: {maximum: 256}, allow_blank: true
  validates :organisation, length: {maximum: 256}, allow_blank: true
  validates :country, :presence=> true

  # validates :email, presence: true, uniqueness: true, on: :create
  # validates :password, presence: true, on: :create
  # validates_confirmation_of :password
      
  def display_name
    [first_name, last_name].compact.join(" ")
  end
  
end
