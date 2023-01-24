class ClientUser < ApplicationRecord
  
  # Include default devise modules. Others available are: :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,:omniauthable, :trackable

  # Includes
  include Itslabel::Scopes::ClientUserScopes

  # paranoid gem for enable soft delet
  acts_as_paranoid

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

  has_one :user_subscription, class_name: "UserSubscription", foreign_key: :user_id
  has_one :zoho_sub_data, class_name: "ZohoSubData"

  # Callback
  after_create :create_default_folder

  #call back function to create default(free) subscription plan after registration
  after_create :create_user_subscription
  after_create :create_zoho_free_plan_subscription #move this code to controller no need call back


  # TODO:- For Welcome mail for new user
  after_create :send_welcome_email
  #commented by Athira
  #after_create :send_welcome_email, unless: Proc.new { self.flag == false } 

   
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

  def create_zoho_free_plan_subscription
    if self.zoho_sub_data
      self.zoho_sub_data.update(subscription_id: Subscription.find_by_title("Free").id)
    else
      zoho_sub_data = ZohoSubData.new
      zoho_sub_data.client_user_id = self.id
      zoho_sub_data.subscription_id = Subscription.find_by_title("Free").id

      refresh_token = Rails.application.secrets.zoho_refresh_token
      parameters = {
                    'refresh_token': refresh_token,
                    'display_name': "#{self.first_name} #{self.last_name}",
                    'first_name': self.first_name,
                    'last_name': self.last_name,
                    'email': self.email,
                    'company_name': self.organisation
                  }
      free_subscription_data = ZohoSubscription.new(parameters).create_zoho_free_subscription


      if free_subscription_data[:status]
        zoho_sub_data.zoho_customer_id = free_subscription_data[:data]['subscription']['customer']['customer_id']
        zoho_sub_data.zoho_subscription_id = free_subscription_data[:data]['subscription']['subscription_id']
        zoho_sub_data.zoho_plan_code = free_subscription_data[:data]['subscription']['plan']['plan_code']
        zoho_sub_data.status = "FREE"
      else
        zoho_sub_data.zoho_customer_id = "1"
        zoho_sub_data.zoho_subscription_id = "1"
        zoho_sub_data.zoho_plan_code = "Free"
        zoho_sub_data.status = "FREE"
      end

      if zoho_sub_data.valid?
        zoho_sub_data.save
      end
    end
  end

  def create_user_subscription
    if self.user_subscription
      self.user_subscription.update(subscription_id: Subscription.find_by_title("Free").id)
    else
      user_subscription = UserSubscription.new
      user_subscription.user_id = self.id
      # user_subscription.subscription_id = 1
      user_subscription.subscription_id = Subscription.find_by_title("Free").id
      if user_subscription.valid?
        user_subscription.save
      end
    end
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

end