module Itslabel::Callbacks::TranslationCallbacks
  
  extend ActiveSupport::Concern
  
  def sanitize_phrases
    self.input_phrase.strip!
    self.output_phrase.strip!
  end
  
end