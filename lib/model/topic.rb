class Topic
  attr_accessor :name, :channel, :articles
  @@all = []

  def initialize(name, channel = "Unsorted")
    @name = name
    @channel = channel
    @articles = []
    @@all << self
  end

  def self.all
    @@all
  end

  def articles
    Articles.all.select {|article|article.topic == self}
  end

  def channel
    articles.map{|article|article.channel == self}
  end

end
