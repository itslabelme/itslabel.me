module Itslabel::Callbacks::TemplateDocumentCallbacks
  
  extend ActiveSupport::Concern

  def translate
    self.skip_callback = true
    html_doc = Translation.translate_html(self.input_html_source, input_language: self.input_language, output_language: self.output_language)
    self.update_attribute(:output_html_source, html_doc.to_html)
    # if self.new_record?
    #   self.output_html_source = Translation.translate_html(self.input_html_source, input_language: self.input_language, output_language: self.output_language)
    #   self.update_attribute(:output_html_source, translated_html)
    # else
    # end
    self.skip_callback = false
  end
  
end