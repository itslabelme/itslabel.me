# This module adds basic project related methods required by some controllers like users and roles
module Itslabel
  module TableSettings
    module TranslationsTs

      extend ActiveSupport::Concern

      private

      def default_table_settings
        # {
        #   action_buttons: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :view_icon, 
        #     name: "Actions", 
        #     col_visible: true, 
        #     col_hideable: false, 
        #     col_orderable: false, 
        #     col_searchable: false
        #   ),

        #   checkbox: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :checkbox, 
        #     name: "", 
        #     col_visible: true, 
        #     col_hideable: false, 
        #     col_orderable: false, 
        #     col_searchable: false
        #   ),
          
        #   employee_code: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :employee_code, 
        #     name: "Employee Code", 
        #     col_visible: true, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   ),            

        #   employee: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :employee, 
        #     name: "Employee", 
        #     col_visible: true, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   ),

        #   biometric_code: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :biometric_code, 
        #     name: "Biometric Code", 
        #     col_visible: true, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   ), 

        #   date: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :date, 
        #     name: "Date", 
        #     col_visible: true, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   ),

        #   in_time: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :in_time, 
        #     name: "In Time", 
        #     col_visible: true, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   ),

        #   out_time: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :out_time, 
        #     name: "Out Time", 
        #     col_visible: true, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   ),

        #   hours_worked: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :hours_worked, 
        #     name: "Hours Worked", 
        #     col_visible: true, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   ),

        #   overtime: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :overtime, 
        #     name: "Overtime", 
        #     col_visible: true, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   ),
          
        #   status: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :status, 
        #     name: "Status", 
        #     col_visible: true, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   ),

        #   errors: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :errors, 
        #     name: "Errors", 
        #     col_visible: true, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   ),

        #   site: ActiveSupport::HashWithIndifferentAccess.new( 
        #     code: :site, 
        #     name: "Company", 
        #     col_visible: false, 
        #     col_hideable: true, 
        #     col_orderable: true, 
        #     col_searchable: true
        #   )
          
        # }
      end

      def configure_translation_table_settings
        @table_settings = default_table_settings
      end
    end
  end
end