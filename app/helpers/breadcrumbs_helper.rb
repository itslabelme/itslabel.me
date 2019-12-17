# This module adds helper methods to generate breadcrumbs
module BreadcrumbsHelper
  
  # helper method to use in views - this will generate a typical greadcrumb with ol,li tags.
  # This method will inspect the variable @breadcrumbs set via controlller configuration 
  # and will generate the breadcrumb html accordingly
  # 
  # e.g 1: <%= breadcrumb() %>
  # e.g 2: <%= breadcrumb(ol_class: "breadcrumb float-left breadcrumb-model-2 mt-1") %>
  # e.g 3: <%= breadcrumb(ol_class: "breadcrumb float-left breadcrumb-model-2 mt-1", a_class: "a-class-btn-link") %>
  
  # this method will generate a code something like below:
  # <ol class="breadcrumb float-right breadcrumb-model-2 mt-1">
  #   <li class="breadcrumb-item">Demo</li>
  #   <li class="breadcrumb-item">
  #     <a href="reports-employee-list-of-air-fare.html" class="btn-link">Books</a>
  #   </li>
  # </ol>
  def breadcrumb(**options)
    return if @breadcrumbs.nil? || @breadcrumbs.empty?
    options.reverse_merge!({
      ol_class: "breadcrumb float-left breadcrumb-model-2 mt-1 hidden-xs",
      li_class: "breadcrumb-item",
      a_class: "btn-link",
      i_class: "mr-1",
    })

    content_tag(:ol, class: options[:ol_class]) do
      li_array = []
      @breadcrumbs.each do |item|
        li_class = item[:active] == true ? "active" : ""
        li_array << content_tag(:li, class: options[:li_class]) do
          i_tag = item.has_key?(:icon) ? "<i class='#{item[:icon]} #{options[:i_class]}'></i>" : ""
          if item[:active]
            raw("#{i_tag}<strong>#{item[:name]}</strong>")
          else
            link_to(raw("#{i_tag} #{item[:name]}"), item[:link], class: options[:a_class] )
          end
        end
      end
      raw(li_array.join(" "))
    end
  end
  
end
