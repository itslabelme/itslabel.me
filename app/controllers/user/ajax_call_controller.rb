module User
class AjaxCallController < User::BaseController
  
  def get_time_zone
      render layout: false
    #inspect.params[:id]
   @time_zones= ActiveSupport::TimeZone.country_zones(params[:id])
    if request.xhr?
      respond_to do |format|
    format.js
  end
  end
  end
end
end