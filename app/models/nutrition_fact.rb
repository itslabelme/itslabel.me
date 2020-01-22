class NutritionFact < ApplicationRecord
   
  # Constants
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "documents"

  # Includes
  include Itslabel::Status::DocumentStatus
  include Itslabel::Scopes::DocumentScopes
  include Itslabel::Permissions::DocumentPermissions
  include Itslabel::Validations::DocumentValidations
  include Itslabel::Callbacks::DocumentCallbacks

  # Validations
  validates :title, presence: true, length: {maximum: 256}
  validates :description, presence: true, length: {maximum: 1024}
  
  validates :input_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_1_language, presence: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_2_language, allow_blank: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_3_language, allow_blank: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_4_language, allow_blank: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }
  validates :output_5_language, allow_blank: true, :inclusion => {:in => LANGUAGES, :message => "is not a valid language" }

  # Associations
  belongs_to :user, class_name: "ClientUser"
  has_and_belongs_to_many :tags, class_name: "Tag"

  

  # General Methods
  # ---------------
  
  def display_name
    self.title
  end

end
