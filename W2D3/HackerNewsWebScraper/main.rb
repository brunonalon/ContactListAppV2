require_relative 'hacker_news_web_scraper'


hacker = HackerNewsWebScraper.new(ARGV[0]) 
post = hacker.get_post
post.add_comment("Bruno Amaral", "Hey!!!! This is my comment")
hacker.print_post(post)