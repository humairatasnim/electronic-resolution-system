class ResolutionsController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    conference = Conference.find(params[:conference_id])
    @resos = conference.resolutions

    @q = @resos.search(params[:q])
    @resolutions = @q.result(distinct: true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resolutions }
    end
  end

  def search
    index
  end

  def show
    conference = Conference.find(params[:conference_id])
    @resolution = conference.resolutions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resolution }
    end
  end

  def new
    conference = Conference.find(params[:conference_id])
    @resolution = conference.resolutions.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resolution }
    end
  end

  def edit
    conference = Conference.find(params[:conference_id])
    @resolution = conference.resolutions.find(params[:id])
  end

  def create
    conference = Conference.find(params[:conference_id])
    @resolution = conference.resolutions.create(params[:resolution])

    respond_to do |format|
      if @resolution.save
        format.html { redirect_to [@resolution.conference, @resolution], notice: 'Your resolution has been successfully registered.' }
        format.json { render json: @resolution, status: :created, location: @resolution }
      else
        format.html { render action: "new" }
        format.json { render json: @resolution.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    conference = Conference.find(params[:conference_id])
    @resolution = conference.resolutions.find(params[:id])

    respond_to do |format|
      if @resolution.update_attributes(params[:resolution])
        format.html { redirect_to [@resolution.conference, @resolution], notice: 'Resolution was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resolution.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    conference = Conference.find(params[:conference_id])
    @resolution = conference.resolutions.find(params[:id])
    @resolution.destroy

    respond_to do |format|
      format.html { redirect_to conference_resolutions_url }
      format.json { head :no_content }
    end
  end

  def find_resolutions
    redirect_to conference_resolutions_path(current_user.conference_id)
  end

  # Different pages for resolutions with different statuses
  def my_resolutions
    conference = Conference.find(params[:conference_id])
    @resos = conference.resolutions.where(:user_id => current_user.id)

    @q = @resos.search(params[:q])
    @resolutions = @q.result(distinct: true)
  end

  def registered
    conference = Conference.find(params[:conference_id])
    @resos = conference.resolutions.where(:status_id => 1)

    @q = @resos.search(params[:q])
    @resolutions = @q.result(distinct: true)
  end

  def approved
    conference = Conference.find(params[:conference_id])
    @resos = conference.resolutions.where(:status_id => 2)

    @q = @resos.search(params[:q])
    @resolutions = @q.result(distinct: true)
  end

  def passed
    conference = Conference.find(params[:conference_id])
    @resos = conference.resolutions.where(:status_id => 3)

    @q = @resos.search(params[:q])
    @resolutions = @q.result(distinct: true)
  end

  def failed
    conference = Conference.find(params[:conference_id])
    @resos = conference.resolutions.where(:status_id => 4)

    @q = @resos.search(params[:q])
    @resolutions = @q.result(distinct: true)
  end

  def undebated
    conference = Conference.find(params[:conference_id])
    @resos = conference.resolutions.where(:status_id => 5)

    @q = @resos.search(params[:q])
    @resolutions = @q.result(distinct: true)
  end

  # Download methods

  def download_all
    require 'zip/zip'
    require 'zip/zipfilesystem'

    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions

    t = Tempfile.new('tmp-zip-' + request.remote_ip)
    Zip::ZipOutputStream.open(t.path) do |zos|
      @resolutions.each do |file|
        zos.put_next_entry(file.document_file_name)
        zos.print IO.read(file.document.path)
      end
    end

    send_file t.path, :type => "application/zip", :filename => "AllResolutions.zip"

    t.close
  end

  def download_registered
    require 'zip/zip'
    require 'zip/zipfilesystem'

    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions.where(:status_id => 1)

    t = Tempfile.new('tmp-zip-' + request.remote_ip)
    Zip::ZipOutputStream.open(t.path) do |zos|
      @resolutions.each do |file|
        zos.put_next_entry(file.document_file_name)
        zos.print IO.read(file.document.path)
      end
    end

    send_file t.path, :type => "application/zip", :filename => "RegisteredResolutions.zip"

    t.close
  end

  def download_approved
    require 'zip/zip'
    require 'zip/zipfilesystem'

    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions.where(:status_id => 2)

    t = Tempfile.new('tmp-zip-' + request.remote_ip)
    Zip::ZipOutputStream.open(t.path) do |zos|
      @resolutions.each do |file|
        zos.put_next_entry(file.document_file_name)
        zos.print IO.read(file.document.path)
      end
    end

    send_file t.path, :type => "application/zip", :filename => "ApprovedResolutions.zip"

    t.close
  end

  def download_passed
    require 'zip/zip'
    require 'zip/zipfilesystem'

    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions.where(:status_id => 3)

    t = Tempfile.new('tmp-zip-' + request.remote_ip)
    Zip::ZipOutputStream.open(t.path) do |zos|
      @resolutions.each do |file|
        zos.put_next_entry(file.document_file_name)
        zos.print IO.read(file.document.path)
      end
    end

    send_file t.path, :type => "application/zip", :filename => "PassedResolutions.zip"

    t.close
  end

  def download_failed
    require 'zip/zip'
    require 'zip/zipfilesystem'

    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions.where(:status_id => 4)

    t = Tempfile.new('tmp-zip-' + request.remote_ip)
    Zip::ZipOutputStream.open(t.path) do |zos|
      @resolutions.each do |file|
        zos.put_next_entry(file.document_file_name)
        zos.print IO.read(file.document.path)
      end
    end

    send_file t.path, :type => "application/zip", :filename => "FailedResolutions.zip"

    t.close
  end
  
  def download_undebated
    require 'zip/zip'
    require 'zip/zipfilesystem'

    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions.where(:status_id => 5)

    t = Tempfile.new('tmp-zip-' + request.remote_ip)
    Zip::ZipOutputStream.open(t.path) do |zos|
      @resolutions.each do |file|
        zos.put_next_entry(file.document_file_name)
        zos.print IO.read(file.document.path)
      end
    end

    send_file t.path, :type => "application/zip", :filename => "UndebatedResolutions.zip"

    t.close
  end

end
