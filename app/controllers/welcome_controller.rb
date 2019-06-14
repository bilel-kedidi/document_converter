class WelcomeController < ApplicationController
  def index
  end

  def upload_document
    @file_uplaod = FileUpload.new
    @file_uplaod.file = params[:file] # Assign a file like this, or
    @file_uplaod.save
  end

  def download
    key = params[:key]
    @file = FileUpload.find_by_token key
    send_file @file.csv_path
  end
end
