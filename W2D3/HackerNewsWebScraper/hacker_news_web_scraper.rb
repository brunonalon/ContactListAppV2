require 'open-uri'
require 'nokogiri' 
require 'colorize'

require_relative 'post'
require_relative 'comment'

class HackerNewsWebScraper
  attr_reader :doc
  def initialize (url)
    begin
      @doc = Nokogiri::HTML(open(url))
    rescue 
      raise Exception.new("Ops!!!! Web page can not be open")
    end 
  end  

  def print_post(post)
      puts "Title: #{post.title.green}"
      puts "URL: #{post.url.blue}"
      puts "Points: #{post.points.red}"
      puts "Item: #{post.item_id.yellow}"

      post.comments.each do |comment|
        puts comment.comment
        puts comment.user_name.blue
      end 
  end 
  def get_post
    title = @doc.css(".title").text
    url = @doc.search(".title").search("a")[0]["href"] 
    points  = @doc.search(".score").inner_text.slice(/\d*/)
    comments = get_comments
    item_id_string = @doc.search(".subtext").search("a")[4]["href"]
    item_id = item_id_string.slice(8,item_id_string.length)
    Post.new(title, url, points, comments, item_id) 
  end 

  def get_comments
   user_name = []
    @doc.search(".comment-tree")[0].search("a").map do |link|
      if link['href'].slice(0,8) == 'user?id='
        user_name.push(link.inner_text)
      end 
    end 
    comments = []
    @doc.search(".comment").each do |comment_text|
      comments.push(comment_text.inner_text)
    end
    comment_objects = []
    comments.each_with_index do |comment, idx| 
      comment_objects.push(Comment.new(user_name[idx], comment))
    end 
    comment_objects
  end 

end



