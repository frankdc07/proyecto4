class VideosController < ApplicationController

  skip_before_action :verify_authenticity_token

  before_action :set_video, only: [:show, :edit]
  before_action :set_contest, only: [:index, :show]

  # All published videos
  def index
    @videos = Video.where(status: 'Generado', contest_id: params[:contest_id]).paginate(:page =>params[:page], :per_page => 50)
  end

  def show
  end

  def new
    @video = Video.new
  end

  def edit
  end

  def create
    @video = Video.new(video_params)
    sqscl = Aws::SQS::Client.new(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], region: ENV['AWS_REGION'])

    @video.contest_id = params[:contest_id]
    @video.status = 'En Proceso'

    respond_to do |format|
      if @video.save
        resp=sqscl.send_message({queue_url: 'https://sqs.us-west-2.amazonaws.com/629329712201/smart_tools_convert_video', message_body: @video.id.to_s})
        format.html { redirect_to '/contest/'+params[:contest_id]+'/videos/show/'+@video.id.to_s, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: '/contest/'+params[:contest_id]+'/videos/show/'+@video.id.to_s }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_video
    @video = Video.find(params[:id])
  end

  private
  def set_contest
    @contest = Contest.find(params[:contest_id])
  end

  def video_params
    params.require(:video).permit(:filename, :description, :link_original, :user_name, :user_lastname, :user_email, :user_comments, :link_original, :contest_id)

  end
end
