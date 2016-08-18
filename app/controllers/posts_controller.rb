class PostsController < Controller
  def index
    @posts = Post.all
  end
end