class ClientUser < ApplicationRecord
  
  # Include default devise modules. Others available are: :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,:omniauthable, :trackable

  # Includes
  include Itslabel::Scopes::ClientUserScopes
  
  # Validations
  validates :first_name, presence: true, length: {maximum: 256}, allow_blank: false
  validates :last_name, presence: true, length: {maximum: 256}, allow_blank: false
  validates :mobile_number, presence: true, length: {maximum: 24}, allow_blank: false
  validates :organisation, presence: true, allow_blank: false
  validates :country, presence: true, allow_blank: false
  validates :position, presence: true, allow_blank: false
  validates_acceptance_of :t_c_accepted, :allow_nil => false, :accept => true, :on => :create

  # Associations
  has_many :documents, class_name: "DocumentView", foreign_key: :user_id
  has_many :document_folders, class_name: "DocumentFolder", foreign_key: :user_id

  # Callback
  after_create :create_default_folder
  # TODO:- For Welcome mail for new user
  after_create :send_welcome_email

   
  # ----------------
  # Instance Methods
  # ----------------
  def send_welcome_email
    UserMailerNotification.send_welcome_email(self).deliver
  end

  def display_name
    [first_name, last_name].compact.join(" ").titleize  
  end
  
  def display_initials
    [first_name[0], last_name[0]].compact.join("")
  end

  def country_name
    country1 = ISO3166::Country[country]
    # country1.translations[I18n.locale.to_s] || country1.name
    country1.try(:name)
  end

  def create_default_folder
    default_folder = default_folder || self.document_folders.create(title: "Default")
  end

  def default_folder
    self.document_folders.where(title: "Default").first
  end


  # ----------------
  # Class Methods
  # ----------------
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  #def self.create_or_fetch_fb_user(auth)
    #email = auth.info.email
    #names = auth.info.name.split(' ')
    #if names.size > 1
      #first_name = names[0..-2].join(' ')
      #last_name = names[-2]
    #else
      #first_name = auth.info.name
      #last_name = ''
    #end
#
    ## Check if the user with this email id has previously registered using our registered form or with google
    ## If so, just convert the user to facebook user
    #user = ClientUser.where(email: email).first
    #if user
      #case user.provider
      #when nil
        #user.first_name = first_name
        #user.last_name = last_name
        #user.provider = auth.provider
        #user.uid = auth.uid
      #when "facebook"
        #if user.uid == auth.uid
          #user.first_name = first_name
          #user.last_name = last_name
        #else
          ## edge case, if the uid coming is different from what we have in our db,
          ## we update the latest uid
          #user.uid = auth.uid
        #end
      #when "google"
        #user.first_name = first_name
        #user.last_name = last_name
        #user.provider = auth.provider
        #user.uid = auth.uid
      #end
    #else
      ## The user doesn't exist. 
      ## So create a new user with provider = "facebook" and with fb uid
      #user = ClientUser.new
      #user.email = email
      #user.password = Devise.friendly_token[0,20]
      #user.first_name = first_name
      #user.last_name = last_name
      #user.provider = auth.provider
      #user.uid = auth.uid
    #end
#
    ## Setting Defaults
    #user.mobile_number = '' unless user.mobile_number
    #user.organisation = '' unless user.organisation
    #user.country = '' unless user.country
#
    ## Saving the User (This will update the user first name and last name in case if the user has changed it in facebook)
    #user.save
#    
    ## user = ClientUser.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    ##   user.email = email
    ##   user.password = Devise.friendly_token[0,20] unless user.password
    ##   user.first_name = first_name
    ##   user.last_name = last_name
    ##   user.mobile_number = '' unless user.mobile_number
    ##   user.organisation = ''
    ##   user.country = ''
    ##   # TODO - Copy Image to Avatar Later
    ##   #user.image = auth.info.image # assuming the user model has an image
    ## end
    #return user
#
  #end
  
  #def self.create_or_fetch_google_user(access_token, signed_in_resource=nil)
    #data = access_token.info
    #user = ClientUser.where(:provider => access_token.provider, :uid => access_token.uid ).first
    #if user
      #return user
    #else
      #registered_user = ClientUser.where(:email => access_token.info.email).first
      #if registered_user
        #return registered_user
      #else
        #fullname = data['name'].split(' ')
        #first_name, last_name = fullname[0], fullname[1]
        #user = ClientUser.create(first_name: first_name,
          #last_name: last_name,
          #provider:access_token.provider,
          #email: data["email"],
          #uid: access_token.uid ,
          #password: Devise.friendly_token[0,20],
          #mobile_number: 123455678,
          #t_c_accepted: true,
        #)
      #end
    #end
  #end

  #Edited by Athira for fix the validation bugs in google signup 
  def self.create_or_fetch_google_user(access_token, signed_in_resource=nil)
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
          email: data["email"],
          provider:access_token.provider,
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
          mobile_number: 123455678,
          organisation: "Default Organisation",
          country: "AE",
          position: "Default Position",
          t_c_accepted: true,
        )
      end
    end
  end

  #Edited by Athira for fix the validation bugs in Facebook signup 
  def self.create_or_fetch_fb_user(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        fullname = data['name'].split(' ')
        first_name, last_name = fullname[0], fullname[1]
        user = User.create(first_name: first_name,
          last_name: last_name,
          email: data["email"],
          provider:access_token.provider,
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
          mobile_number: 123455678,
          organisation: "Default Organisation",
          country: "AE",
          position: "Default Position",
          t_c_accepted: true,
        )
      end
    end
  end

end