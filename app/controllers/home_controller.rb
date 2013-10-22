class HomeController < ApplicationController

  @@upload_service = $api.buildUploadService

  def index
   	begin
  	  @upload = @@upload_service.get_all_files
    rescue Exception => e
      "#{e.message}"	
    end
  end
end
