class TranslationQueryHistory < ApplicationRecord

  # Constants
  LANGUAGES = ["ENGLISH", "ARABIC", "FRENCH"].freeze

  # Set Table Name
  self.table_name = "translation_query_histories"

  # Includes
  include Itslabel::Status::DocumentStatus
  include Itslabel::Scopes::TranslationQueryHistoryScopes
  include Itslabel::Permissions::TranslationQueryHistoryPermissions

  # Associations
  belongs_to :client_user, class_name: "ClientUser", optional: true

  
  # ----------------
  # Instance Methods
  # ----------------

  def display_name
    "#{input_phrase} - #{output_phrase}"
  end
  
end