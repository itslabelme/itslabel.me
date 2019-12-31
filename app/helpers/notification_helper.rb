# This module creates basic reporting UI elements like filter drop downs etc
module NotificationHelper
  
  private

  def default_notification_configuration
    {
      success: false,
      title: "<NOT SET>",
      message: "<NO MESSAGE SET>"
    }
  end

  def configure_notification
    if defined?(@notification)
      @notification.reverse_merge!(default_notification_configuration)
    else
      @notification = default_notification_configuration
    end
  end
  
  # This function will set a notification message depending up on the request type (ajax - xml http or direct http)
  # Example
  #   set_notification("Success", "The message has been sent successfully")
  #   set_notification("Success", "Permission denied")
  def set_notification(success, title, message)
    @notification[:success] = success
    @notification[:title] = title
    @notification[:message] = message
  end

  def set_resource_notification(obj)
    if obj.errors.any?
      @notification[:success] = false
      @notification[:title] = I18n.translate("status.error")
      @notification[:message] = obj.errors.full_messages.join("<br>")
    else
      @notification[:success] = true
      @notification[:title] = I18n.translate("status.success")
      @notification[:message] = I18n.translate("success.saved", item: default_item_name.titleize)
    end
  end

  # Displays Full errors with basic alert styles
  # Example
  #   felix_compact_form_errors(@user)
  def notify_form_errors(object, **options)
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