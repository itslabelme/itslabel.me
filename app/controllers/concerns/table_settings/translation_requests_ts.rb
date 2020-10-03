# This module adds basic project related methods required by some controllers like users and roles
module TableSettings
  module TranslationRequestsTs

    extend ActiveSupport::Concern

    private

    def default_table_settings
      {
        si_no: ActiveSupport::HashWithIndifferentAccess.new( 
          code: :si_no, 
          name: "#", 
          col_visible: true, 
          col_hideable: true, 
          col_orderable: true, 
          col_searchable: true
        ),
        requested_by: ActiveSupport::HashWithIndifferentAccess.new( 
          code: :requested_by, 
          name: "Requested By", 
          col_visible: true, 
          col_hideable: false, 
          col_orderable: false, 
          col_searchable: false
        ),
        input_language: ActiveSupport::HashWithIndifferentAccess.new( 
          code: :input_language, 
          name: "Input Language", 
          col_visible: true, 
          col_hideable: false, 
          col_orderable: false, 
          col_searchable: false
        ),
        input_phrase: ActiveSupport::HashWithIndifferentAccess.new( 
          code: :input_phrase, 
          name: "Input Phrase", 
          col_visible: true, 
          col_hideable: true, 
          col_orderable: true, 
          col_searchable: true
        ),            
        output_language: ActiveSupport::HashWithIndifferentAccess.new( 
          code: :output_language, 
          name: "Output Language", 
          col_visible: true, 
          col_hideable: true, 
          col_orderable: true, 
          col_searchable: true
        ),
        output_phrase: ActiveSupport::HashWithIndifferentAccess.new( 
          code: :output_phrase, 
          name: "Output Phrase", 
          col_visible: true, 
          col_hideable: true, 
          col_orderable: true, 
          col_searchable: true
        ), 
        doc_type: ActiveSupport::HashWithIndifferentAccess.new( 
          code: :doc_type, 
          name: "Doc Type", 
          col_visible: true, 
          col_hideable: true, 
          col_orderable: true, 
          col_searchable: true
        ),
        created_at: ActiveSupport::HashWithIndifferentAccess.new( 
          code: :created_at, 
          name: "Created Date", 
          col_visible: true, 
          col_hideable: true, 
          col_orderable: true, 
          col_searchable: true
        )
      }
    end

    def configure_translation_requests_table_settings
      @table_settings = default_table_settings
    end
  end
end