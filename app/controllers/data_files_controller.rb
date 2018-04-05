class DataFilesController < ApplicationController
  before_action :set_file, only: [:download, :destroy]
  before_action :check_can_download, only: [:download]
  before_action :check_can_destroy, only: [:destroy]

  def create
    uploaded_io = params[:data_file][:data]
    @file = DataFile.new(file_params)
    @file.uuid = SecureRandom.uuid
    @file.name = uploaded_io.original_filename

    if uploaded_io.size > 100.megabytes
      flash[:danger] = "File too large (>100MB)"
      redirect_to @file.repository
      return
    end

    unless @file.repository.can_upload_files?(current_user)
      redirect_to root_url
      return
    end

    Dir.mkdir Rails.root.join('public', 'uploads', @file.uuid)
    File.open(Rails.root.join('public', 'uploads', @file.uuid, uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    flash[:danger] = "Error creating file" unless @file.save
    redirect_to @file.repository
  end

  def download
    send_file @file.file_path
  end

  def destroy
    @file.destroy
    redirect_to @file.repository
  end

  private
    def set_file
      @file = DataFile.find(params[:id])
    end

    def file_params
      params.require(:data_file).permit(:repository_id, :repository_type)
    end

    def check_can_download
      redirect_to root_url unless @file.repository.can_download_files?(current_user)
    end

    def check_can_destroy
      redirect_to root_url unless @file.repository.can_upload_files?(current_user)
    end
end
