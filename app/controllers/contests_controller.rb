class ContestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contest, only: [:show, :edit, :update, :destroy]  
  before_action :set_current_user, only: [:create, :index]

  # All published contests
  def index
    @contests = Contest.where(user_id: @user.id)
  end

  def show
  end

  def new
    @contest = Contest.new
  end

  def edit
  end

  def create
    @contest = Contest.new(contest_params)

    @contest.user_id = @user.id

    auxurl = @contest.title
    url = auxurl.gsub(/\s+/, "")
    @contest.url = url

    respond_to do |format|
      if @contest.save
        format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
        format.json { render :show, status: :created, location: @contest }
      else
        format.html { render :new }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contests/1
  # PATCH/PUT /contests/1.json
  def update
    respond_to do |format|
      if @contest.update(contest_params)
        format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
        format.json { render :show, status: :ok, location: @contest }
      else
        format.html { render :edit }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    @contest.destroy
    respond_to do |format|
      format.html { redirect_to contests_url, notice: 'Contest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_contest
    @contest = Contest.find(params[:id])
    @videos = @contest.videos.paginate(:page =>params[:page], :per_page => 50)
  end

  def set_current_user
    @user = current_user
  end  

  def contest_params
    params.require(:contest).permit(:title, :banner, :url, :date_ini, :date_end, :award, :user_id)
  end
end