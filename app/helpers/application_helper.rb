module ApplicationHelper

  def display_parsley_error(obj, field_name)
    if obj.errors[field_name].any?
      content_tag(:ul, class: "parsley-errors-list filled", style: "padding-left:15px;") do
        # contents = []
        # obj.errors[field_name].each do |x|
        #   contents << raw(content_tag(:li, x, class: "parsley-required"))
        # end
        # raw(contents.join(' '))
        raw(content_tag(:li, obj.errors[field_name].first, class: "parsley-required"))        
      end
    end
  end

end
