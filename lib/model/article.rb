class Article
  attr_accessor :title, :content, :channel, :topic, :link
  @@all = []

  def initialize(title, content, link = "Undiscolosed", channel = "Undisclosed", topic = "Unsorted")
    @title = title
    @link = link
    @channel = channel
    @topic = topic
    @content = content
    @@all << self
  end

  def self.all
    @@all
  end


#----------------------------------------AP----------------------------------------------
  def self.new_from_ap_scrape(articles_array)
    articles_array.each do |story|
      content = Scraper.scrape_ap_article_page("https://www.apnews.com/" + story[:link])
      Article.new(story[:title], content, story[:link], "AP - The Associated Press")
    end

  end

  def self.new_from_ap_topic_scrape(articles_array)
    articles_array.each do |story|
      content = Scraper.scrape_ap_article_page("https://www.apnews.com/" + story[:link])
      Article.new(story[:title], content, story[:link], "AP - The Associated Press", story[:topic])
    end
  end
#----------------------------------------------------------------------------------------
#----------------------------------------BBC---------------------------------------------
  def self.new_from_bbc_scrape(articles_array)
    articles_array.each do |story|
      content = Scraper.scrape_bbc_article_page("https://www.bbc.co.uk/" + story[:link])
      Article.new(story[:title], content, story[:link], "BBC - Britist Broadcast Company")
    end
  end

  def self.new_from_bbc_topic_scrape(articles_array)
    articles_array.each do |story|
      content = Scraper.scrape_bbc_article_page("https://www.bbc.co.uk/" + story[:link])
      Article.new(story[:title], content, story[:link], "BBC - Britist Broadcast Company", story[:topic])
    end
  end
#----------------------------------------------------------------------------------------
#---------------------------------------TBIJ---------------------------------------------
  def self.new_from_tbij_scrape(articles_array)
    articles_array.each do |story|
      content = Scraper.scrape_tbij_article_page(story[:link])
      Article.new(story[:title], content, story[:link], "TBIJ - The Bureau of Investigative Journalism")
    end
  end

end
