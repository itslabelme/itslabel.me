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
    strong_text = 'Danger!' if flash.now[:error] || flash[:error]

    message = message.strip if message

    content_tag(:div, class: "alert #{cls_name} alert-dismissible fade show", data: "alert") do
      content_tag(:strong, strong_text, class: "mr-3") + raw(message) + 
      content_tag(:button, class: "close", "data-dismiss" => "alert") do
        content_tag(:span, raw("&times;"), "aria-hidden" => "true")
      end
    end unless message.blank?
  end
  
end