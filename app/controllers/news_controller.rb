class NewsController < ApplicationController
  before_action :set_news, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  #before_action :anti_troleo, only: %i[edit update destroy]

  before_action only: [:destroy] do
    authorize_request(["admin"])
    end

  before_action only: [:new, :create, :edit] do
    authorize_request(["author", "normal_user"])
    end

  # GET /news or /news.json
  def index
    @news = News.includes(:comments).all
  end

  # GET /news/1 or /news/1.json
  def show
    @news = News.find(params[:id])
    @comments = @news.comments
    @comment = Comment.new
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news or /news.json
  def create
    @news = News.new(news_params)
    @news.user = current_user
    respond_to do |format|
      if @news.save
        format.html { redirect_to news_url(@news), notice: "News was successfully created." }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1 or /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to news_url(@news), notice: "News was successfully updated." }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1 or /news/1.json
  def destroy
    @news = News.find(params[:id])
    authorize_request(["admin"])

    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url, notice: "News was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def news_params
      params.require(:news).permit(:image, :title, :description, :user_id)
    end

    #def anti_troleo 
     #if current_user.id != @news.user_id
     # redirect_to  news_index_path, notice: "No tienes acceso para eso"
     #end
  #end


end
