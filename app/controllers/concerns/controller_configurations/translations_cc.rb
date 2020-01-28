module ControllerConfigurations
  module TranslationsCc
    
    extend ActiveSupport::Concern
  
    private

    # ----------------------
    # Configuration Methods
    # ----------------------

    def controller_configuration
      {
        # Resource Names - Used internally to make use of common js and html templates for rendering
        class: Translation,
        collection_name: :translations,
        item_name: :translation,

        # Controller Settings
        # -------------------

        # Just configure the page title and page heading here and resource helper will automatically set @page_heading and @page_heading
        # and you may call <%= page_heading -%> from your layout file <layout-name>.html.erb
        # If page title is not configured page_title = page_heading
        page_heading: {
          index: "Translations",
          show: "Translation",
          new: "Add a Translation",
          edit: "Edit Translation",
          destroy: "Delete Translation"
        },

        # This is set as current navigation and is used by sidebar and/or navbar
        current_nav: "admin/translation",

        # Just configure the meta tags here and resource helper will automatically set @meta_tags 
        # and you may call <%= meta_tags -%> from your layout file <layout-name>.html.erb
        # meta_tags: {},

        breadcrumbs: [],

        # Feature Name should be set to enable permission checks.
        # This page is visible to the current user only 
        # if the user has read permission set for this feature
        # Requires Feature Class
        feature_name: nil,

        # Turn this on if you like to reload the 
        # screen with the list after saving a resource
        get_collections_after_save_resource: false,

        # Turn this on if you want to set flash messages.
        # This would need Flash Helper
        enable_flash_messages: true,

        # Mention all checkbox fields so that it will resource controller will set that value to be false when the update action is called
        # if @controller_options[:checkbox_fields] && @controller_options[:checkbox_fields].any?
        #  @controller_options[:checkbox_fields].each do |field|
        #    @r_object.write_attribute(field, false)
        #  end
        # end
        # This is a tricky solution to update bolean fields which are shown as checkbox.
        checkbox_fields: [],

        # Pagination - Defaults - This is quite handy while initializing @per_page and @current_page
        items_per_list: 40,
        max_items_per_list: 200,

        # View Settings
        # -------------

        # Model Size can be large or generic
        form_model_size: :generic,
        show_model_size: :generic,

        # Ajax Settings
        show_modal_after_create: false,
        show_modal_after_update: false,

        workflow: "swan",

        # Load Libraries
        # --------------
        # The following configurations are checked at the time of rendering the layout header.

        # The javascript libraries mentioned below are included 
        js_libraries_to_load: {
          # amcharts_core: {url: "https://www.amcharts.com/lib/4/core.js", defer: false},
          # amcharts_charts: {url: "https://www.amcharts.com/lib/4/charts.js", defer: false},
          # amcharts_animated: {url: "https://www.amcharts.com/lib/4/themes/animated.js", defer: false},
        },

        # The css libraries mentioned below are included 
        css_libraries_to_load: {
          # # Generic CSS
          # layout_color: "http://mukkutti.themes.felixkoders.com/assets/css/color/#{@current_theme}.css",
          
          # # Not sure if jQuery UI is required
          # jquery_ui: "http://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css",
          
          # # Left Sidebar is required when the index is called from Project Pages (where it loads documents related to that Project)
          # left_sidebar: "http://mukkutti.themes.felixkoders.com/assets/css/felix-form-left-sidebar.css",

          # # Charts
          # amcharts:"http://mukkutti.themes.felixkoders.com/assets/css/felix-dashboard.css",
          # amcharts_animation: "http://mukkutti.themes.felixkoders.com/assets/plugins/am-charts/am-charts-animation.css",
          
        },

        # Default partial opens show and form partial according to the model_size configuration
        # It also respect the configuration layout and refresh the page element on both cases - i.e layout is table or feed

        # Set Layout 
        layout: {
          current_layout: "admin",
          # theme_color: "#898989",
          # page_theme: "#{@current_theme}",
          # page_font: "felix-font-small",
        },

        partials_path: {
          new_form: "/admin/translations/form/form",
          edit_form: "/admin/translations/form/form",
          show: "/admin/translations/show",
          table: "/admin/translations/index/table",
          row: "/admin/translations/index/row",
          new_controls: "/admin/translations/form/controls",
          edit_controls: "/admin/translations/form/controls",
          filters: "/admin/translations/index/filters"
        }
      }
    end

    def breadcrumbs_configuration
      {
        heading: "Translation",
        description: "A Glimpse of Employee Details",
        # links: [{name: "Dashboard", link: yojana.admin_dashboard_path, icon: 'fa-dashboard'}]
      }
    end

    
    # --------------
    # Filter Methods
    # --------------

    def configure_filter_settings
      @filter_settings = {
        string_filters: [
          { filter_name: :query },
          { filter_name: :status }
        ],
        boolean_filters: [],
        reference_filters: [],
        variable_filters: [],
      }
    end

    def configure_filter_param_mapping
      @filter_param_mapping = default_filter_param_mapping
      @filter_param_mapping.merge!({})
    end

  end
end