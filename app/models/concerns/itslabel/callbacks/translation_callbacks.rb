module Itslabel::Callbacks::TranslationCallbacks
  
  extend ActiveSupport::Concern
  
  def sanitize_phrases
    self.english_phrase.strip!
    self.arabic_phrase.strip!
    self.french_phrase.strip!
  end
  
end