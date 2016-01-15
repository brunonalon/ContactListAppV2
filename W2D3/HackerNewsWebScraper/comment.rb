class Comment
  attr_reader :user_name, :comment
  def initialize(user_name, comment)
    @user_name = user_name
    @comment = comment
  end
end