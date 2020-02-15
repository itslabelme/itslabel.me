module User
class AjaxCallController < User::BaseController
  
  def get_time_zone
     # render layout: false
    #inspect.params[:id]
   @time_zones= ActiveSupport::TimeZone.country_zones(params[:id])
    render :json => @time_zones
     # respond_to do |format|
       # format.js
      
       #format.json { render :json => @time_zones }
   # end
  end
end
end