module Itslabel::Callbacks::DocumentCallbacks
  
  extend ActiveSupport::Concern

  def translate
    self.skip_callback = true
    translated_html = Translation.translate_html(self.input_html_source, input_language: self.input_language, output_language: self.output_1_language)
    binding.pry
    self.update_attribute(:output_html_source, translated_html)
    # if self.new_record?
    #   self.output_html_source = Translation.translate_html(self.input_html_source, input_language: self.input_language, output_language: self.output_1_language)
    #   self.update_attribute(:output_html_source, translated_html)
    # else
    # end
    self.skip_callback = false
  end
  
end