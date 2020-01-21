# This module creates basic reporting UI elements like filter drop downs etc
module FlashHelper
  
  # Example
  # <div id="div_flash_message">
  #   <%= flash_message() -%>
  # </div>
  def flash_message(now=true)
    if now
      message = flash.now[:success] || flash.now[:notice] || flash.now[:alert] || flash.now[:error]
    else
      message = flash[:success] || flash[:notice] || flash[:alert] || flash[:error]
    end
    
    cls_name = "alert-info"
    cls_name = 'alert-success' if flash.now[:success] || flash[:success]
    cls_name = 'alert-warning' if flash.now[:alert] || flash[:alert]
    cls_name = 'alert-danger' if flash.now[:error] || flash[:error]

    strong_text = "Info!"
    strong_text = 'Success!' if flash.now[:success] || flash[:success]
    strong_text = 'Warning!' if flash.now[:alert] || flash[:alert]
    strong_text = 'Error!' if flash.now[:error] || flash[:error]

    message = message.strip if message

    content_tag(:div, class: "alert #{cls_name} alert-dismissible fade show", data: "alert") do
      content_tag(:strong, strong_text, class: "mr-3") + raw(message) + 
      content_tag(:button, class: "close", "data-dismiss" => "alert") do
        content_tag(:span, raw("&times;"), "aria-hidden" => "true")
      end
    end unless message.blank?
  end

  # Displays Full errors with basic alert styles
  # Example
  #   error_message(@user)
  def error_message(object, **options)
    options.reverse_merge!(
      row_class: "row m-b-1",
      col_class: "col-md-12",
      alert_class: "alert alert-danger",
      ul_class: "",
      ul_style: "margin-bottom: 0px;",
      li_class: "",
      li_style: ""
    )
    if object.errors.any?
      content_tag(:div, class: options[:row_class]) do 
        content_tag(:div, class: options[:col_class]) do 
          content_tag(:div, class: options[:alert_class]) do 
            content_tag(:ul, class: options[:ul_class], style: options[:ul_style]) do 
              li_array = []
              object.errors.each do |attr, msg|
                next unless object.errors[attr].last == msg
                li_array << content_tag(:li, class: options[:li_class], style: options[:li_style]) do 
                  # If the error is base, dont show the text base
                  ( attr.to_s == "base" ? "" : content_tag(:strong, "#{attr.to_s.titleize}: ") ) + msg
                end
              end
              raw(li_array.join(" "))
            end
          end
        end
      end
    end
  end
  
end