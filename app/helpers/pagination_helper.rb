# This module creates basic reporting UI elements like filter drop downs etc
module PaginationHelper

  def serial_number(i, cls="fa fa-check text-success")
    if i < 0
      raw(content_tag(:i, "", class: cls))
    else
      raw(i + 1 + (@per_page.to_i * (@current_page.to_i - 1)))
    end
  end

end