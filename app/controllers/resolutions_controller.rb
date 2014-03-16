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
    require 'zip'
    GC.disable
    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions

    zip_filename = "#{conference.title} - All.zip"
    tmp_filename = "#{Rails.root}/tmp/#{zip_filename}"
    Zip::File.open(tmp_filename, Zip::File::CREATE) do |zip|
      @resolutions.each { |e| 
        document = Paperclip.io_adapters.for(e.document)
        zip.add("#{e.document.original_filename}", document.path)
      }
    end
    send_data(File.open(tmp_filename, "rb+").read, :type => 'application/zip', :disposition => 'attachment', :filename => zip_filename)
    File.delete tmp_filename
    GC.enable
    GC.start
  end

  def download_registered
    require 'zip'
    GC.disable
    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions.where(:status_id => 1)

    zip_filename = "#{conference.title} - Registered.zip"
    tmp_filename = "#{Rails.root}/tmp/#{zip_filename}"
    Zip::File.open(tmp_filename, Zip::File::CREATE) do |zip|
      @resolutions.each { |e| 
        document = Paperclip.io_adapters.for(e.document)
        zip.add("#{e.document.original_filename}", document.path)
      }
    end
    send_data(File.open(tmp_filename, "rb+").read, :type => 'application/zip', :disposition => 'attachment', :filename => zip_filename)
    File.delete tmp_filename
    GC.enable
    GC.start
  end

  def download_approved
    require 'zip'
    GC.disable
    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions.where(:status_id => 2)

    zip_filename = "#{conference.title} - Approved.zip"
    tmp_filename = "#{Rails.root}/tmp/#{zip_filename}"
    Zip::File.open(tmp_filename, Zip::File::CREATE) do |zip|
      @resolutions.each { |e| 
        document = Paperclip.io_adapters.for(e.document)
        zip.add("#{e.document.original_filename}", document.path)
      }
    end
    send_data(File.open(tmp_filename, "rb+").read, :type => 'application/zip', :disposition => 'attachment', :filename => zip_filename)
    File.delete tmp_filename
    GC.enable
    GC.start
  end

  def download_passed
    require 'zip'
    GC.disable
    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions.where(:status_id => 3)

    zip_filename = "#{conference.title} - Passed.zip"
    tmp_filename = "#{Rails.root}/tmp/#{zip_filename}"
    Zip::File.open(tmp_filename, Zip::File::CREATE) do |zip|
      @resolutions.each { |e| 
        document = Paperclip.io_adapters.for(e.document)
        zip.add("#{e.document.original_filename}", document.path)
      }
    end
    send_data(File.open(tmp_filename, "rb+").read, :type => 'application/zip', :disposition => 'attachment', :filename => zip_filename)
    File.delete tmp_filename
    GC.enable
    GC.start
  end

  def download_failed
    require 'zip'
    GC.disable
    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions.where(:status_id => 4)

    zip_filename = "#{conference.title} - Failed.zip"
    tmp_filename = "#{Rails.root}/tmp/#{zip_filename}"
    Zip::File.open(tmp_filename, Zip::File::CREATE) do |zip|
      @resolutions.each { |e| 
        document = Paperclip.io_adapters.for(e.document)
        zip.add("#{e.document.original_filename}", document.path)
      }
    end
    send_data(File.open(tmp_filename, "rb+").read, :type => 'application/zip', :disposition => 'attachment', :filename => zip_filename)
    File.delete tmp_filename
    GC.enable
    GC.start
  end

  def download_undebated
    require 'zip'
    GC.disable
    conference = Conference.find(params[:conference_id])
    @resolutions = conference.resolutions.where(:status_id => 5)

    zip_filename = "#{conference.title} - Undebated.zip"
    tmp_filename = "#{Rails.root}/tmp/#{zip_filename}"
    Zip::File.open(tmp_filename, Zip::File::CREATE) do |zip|
      @resolutions.each { |e| 
        document = Paperclip.io_adapters.for(e.document)
        zip.add("#{e.document.original_filename}", document.path)
      }
    end
    send_data(File.open(tmp_filename, "rb+").read, :type => 'application/zip', :disposition => 'attachment', :filename => zip_filename)
    File.delete tmp_filename
    GC.enable
    GC.start
  end

end
