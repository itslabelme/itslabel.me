# This module creates basic reporting UI elements like filter drop downs etc
module PaginationHelper

  def serial_number(i, cls="fa fa-check text-success")
    if i < 0
      raw(content_tag(:i, "", class: cls))
    else
      raw(i + 1 + (@per_page.to_i * (@current_page.to_i - 1)))
    end
  end

  def parse_pagination_params
    items_per_list = (@controller_options && @controller_options[:items_per_list] ? @controller_options[:items_per_list] : nil) || 2
    max_items_per_list = (@controller_options && @controller_options[:max_items_per_list] ? @controller_options[:max_items_per_list] : nil) || 501
    
    @current_page = params[:page] || "1"
    @per_page = params[:per_page] || items_per_list

    @per_page = items_per_list.to_s if @per_page && @per_page.to_i > max_items_per_list
    @offset = (@current_page.to_i - 1) * (@per_page.to_i)
  end

end