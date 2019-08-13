require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_tool(home_url)
    Nokogiri::HTML(open(home_url))
  end


#---------AP page scrapes----------------------------------------------

  def self.scrape_ap_home_page(home_url)
    articles = []
    scrape_tool(home_url).css(".headline").drop(2)[0..4].each do |storys|
      story = storys.content
      link = storys[:href]
      articles << {:title => story, :link => link}
      end
    articles
  end

  def self.scrape_ap_article_page(article_url)
    story = []
    story << scrape_tool(article_url).css(".Article").text
    story
  end

  def self.scrape_ap_list_page(topic_url)
    articles = []
    scrape_tool(topic_url).css(".headline").drop(2)[0..4].each do |storys|
      story = storys.content
      link = storys[:href]
      topic = scrape_tool(topic_url).css(".hub-name").first.content
      articles << {:title => story, :link => link, :topic => topic}
      end
    articles
  end
#parsed_content.css('.hub-name').first.content


#-----------------------------------------------------------------------
#--------BBC Scrapes --------------------------------------------------

  def self.scrape_bbc_home_page(home_url)
    articles = []
    scrape_tool(home_url).css(".gs-c-promo-heading").drop(1)[0..4].each do |storys|
      story = storys.text
      link = storys[:href]
      articles << {:title => story, :link => link}
    end
    articles
  end

  def self.scrape_bbc_sports_page(topic_url)
    articles = []
    scrape_tool(topic_url).css(".gs-c-promo-heading").drop(1)[0..4].each do |storys|
      story = storys.text
      link = storys[:href]
      topic = scrape_tool(topic_url).css(".sp-c-global-header__logo").first.text
      articles << {:title => story, :link => link, :topic => topic}
    end
    articles
  end

  def self.scrape_bbc_list_page(topic_url)
    articles = []
    scrape_tool(topic_url).css(".gs-c-promo-heading").drop(1)[0..4].each do |storys|
      story = storys.text
      link = storys[:href]
      topic = scrape_tool(topic_url).css(".gel-great-primer").text
      articles << {:title => story, :link => link, :topic => topic}
    end
    articles
  end

  def self.scrape_bbc_article_page(article_url)
    story = []
    story << scrape_tool(article_url).css(".story-body__inner").css("p").text
    story
  end

  def self.scrape_bbc_topic_article_page(article_url)
    story = []
    story << scrape_tool(article_url).css(".story-body").css("p").text
    story
  end


#--------------------------------------------------------------------------
#-----TBIJ Scrapes---------------------------------------------------------


  def self.scrape_tbij_home_page(home_url)
    articles = []
    scrape_tool(home_url).css(".tb-c-story-preview")[0..4].each_with_index do |storys, i|
      story = storys.css("h2").text
      link = storys[:href]
      articles << {:title => story, :link => link}
    end
    articles
  end


  def self.scrape_tbij_article_page(article_url)
    story = []
    story << scrape_tool(article_url).css(".tb-c-story-text-block").css("p").text
    story
  end

end
