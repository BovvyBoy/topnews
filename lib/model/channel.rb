class Channel
  attr_accessor :name, :articles, :topics, :url
  @@all = []

  def initialize(name, url)
    @url = url
    @name = name
    @articles = []
    @@all << self
  end

  def self.all
    @@all
  end

  def articles=
    Article.all.select {|article|article.channel == self}
  end

  def topics
    channel_articles.map {|article|article.topic == self}
  end

end
