class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
    @comment = Comment.new
  end

  # GET /comments/new
  def new
    @news = News.find(params[:news_id])
    @comment = @news.comments.build
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    @news = News.find(params[:news_id])
    @comment = @news.comments.new(comment_params)
    @comment = @news.comments.build(comment_params)
    @comment.user = current_user
  
    if @comment.save
      redirect_to news_path(@news), notice: "Comment was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to news_path(@comment.news), notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  
    redirect_to news_path(@comment.news), notice: "Comment was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    #def comment_params
     # params.fetch(:comment, {})
    #end
    
    def comment_params
      params.require(:comment).permit(:content, :author, :user_id)
    end
end
