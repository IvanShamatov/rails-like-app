class MainController < Controller
  def index
    @test = "Awesome"
    @ar = %w(one two three)
  end
end