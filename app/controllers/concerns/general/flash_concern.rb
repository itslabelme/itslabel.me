# This module has a method which deals with flash object
module General
  module FlashConcern
    
    extend ActiveSupport::Concern

    private

    # This function will set a flash message depending up on the request type (ajax - xml http or direct http)
    # Example
    #   set_flash_message("The message has been sent successfully", :success, false)
    #   set_flash_message("Permission denied", :error)
    #
    # Difference between flash and flash.now
    # http://trace.adityalesmana.com/2010/10/difference-between-flash-and-flash-now-in-ruby/
    def set_flash_message(message, type, now=true)
      if now
        flash.now[type] = message
      else
        flash[type] = message
      end
    end
  
  end
end