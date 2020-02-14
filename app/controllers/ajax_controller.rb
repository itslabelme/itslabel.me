class AjaxController < ApplicationController
  respond_to :json, :html, only: :get_time_zone
  def get_time_zone
      render layout: false
    #inspect.params[:id]
   @time_zones= ActiveSupport::TimeZone.country_zones(params[:id])
   respond_with @time_zones
  end
end
