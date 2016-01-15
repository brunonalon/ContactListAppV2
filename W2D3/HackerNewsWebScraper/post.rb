class Post
  attr_reader :title, :url, :comments, :points, :item_id
  def initialize (title, url, points,comments, item_id )
    @title = title
    @url = url
    @points  = points
    @comments = comments
    @item_id = item_id
  end 


  def add_comment(user_name, comment) 
    @comments.push(Comment.new(user_name, comment))
  end 

end