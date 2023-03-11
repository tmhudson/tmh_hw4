class PostsController < ApplicationController

  # do I need the below?
  def index
    @posts = Post.all
    @current_user = User.find_by({ "id" => session["user_id"] })
  end
  
  def new
    @post = Post.new
    @post.place_id = params["place_id"]
  end

  def create
    if @current_user
      @post = Post.new
      @post["title"] = params["post"]["title"]
      @post["description"] = params["post"]["description"]
      @post["posted_on"] = params["post"]["posted_on"]
      @post["place_id"] = params["post"]["place_id"]
      @post.uploaded_image.attach(params["post"]["uploaded_image"])
      @post.save
      redirect_to "/places/#{@post["place_id"]}"
         
    else
      flash["notice"] = "Login first."
      redirect_to "/login"
    end
  end

end
