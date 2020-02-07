class ClientUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,:omniauthable, :trackable
  # max_paginates_per 2

  validates :first_name, presence: true, length: {maximum: 256}, allow_blank: false
  validates :last_name, length: {maximum: 256}, allow_blank: true
  validates :mobile_number, length: {maximum: 24}, allow_blank: true
  validates :organisation, presence: true
  validates :country, presence: true
      
  def display_name
    [first_name, last_name].compact.join(" ")
  end
  
  def display_initials
     [first_name[0], last_name[0]].compact.join("")
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      fullname = auth.info.name.split(' ')
      first_name, last_name = fullname[0], fullname[1]
      user.first_name = first_name
      user.last_name = last_name
      user.mobile_number = 123455678
      #user.name = auth.info.name # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
    end
  end
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = ClientUser.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = ClientUser.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        fullname = data['name'].split(' ')
        first_name, last_name = fullname[0], fullname[1]
        user = ClientUser.create(first_name: first_name,
          last_name: last_name,
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
          mobile_number: 123455678
        )
      end
    end
  end
  
end