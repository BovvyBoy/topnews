class CommandLineInterface
  @@base_path = ""

  def run
    binding.pry
    system('clear')
    welcome
    input
  end

#------------------------------------------------------------------------------------------------------------
  def welcome
    font = TTY::Font.new(:doom)
    puts font.write("Welcome to News Top 3")
  end

  def input
    prompt = TTY::Prompt.new
    choices = ["   Choose a Channel", "   Browse by Topic", "   Top Stories"]
    selection = prompt.multi_select("Please Select An Option:", choices)
    selection.each do |a|
      if a == "   Choose a Channel"
        list_channels
        channel_selection
      elsif a == "   Browse by Topic"
        list_topics
        topic_article_selection
      elsif a == "   Top Stories"
        latest_top
        topic_article_selection
      end
    end
  end


  def list_channels
    prompt = TTY::Prompt.new
    choices = ["   AP - The Associated Press", "   BBC - Britist Broadcast Company", "   TBIJ - The Bureau of Investigative Journalism"]
    selection = prompt.multi_select("Please Select A Channel:", choices)
    selection.each do |a|
      if a == "   AP - The Associated Press"
        @@base_path = "https://www.apnews.com/"
        new_channel
        list_topstories
        article_selection
      elsif a == "   BBC - Britist Broadcast Company"
        @@base_path = "https://www.bbc.co.uk/news"
        new_channel
        bbc_list_topstories
        article_selection
      elsif a == "   TBIJ - The Bureau of Investigative Journalism"
        @@base_path = "https://www.thebureauinvestigates.com/stories/"
        new_channel
        tbij_list_topstories
        article_selection
      end
    end
  end

  def list_topics
    prompt = TTY::Prompt.new
    choices = ["   Sports", "   Entertainment", "   International", "   Technology", "   Business"]
    selection = prompt.multi_select("Please Select A Topic:", choices)
    selection.each do |a|
      if a == "   Sports"
        puts "TOP STORIES FROM BBC:"
        bbc_topic_topstories("sport")
        puts "Type bbc(*) * - the number story: "
        puts ""
        puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
        ap_topic_topstories("apf-sports")
        puts "Type ap(*) * - the number story: "
      elsif a == "   Entertainment"
        puts "TOP STORIES FROM BBC:"
        bbc_topic_topstories("news/entertainment_and_arts")
        puts "Type bbc(*) * - the number story: "
        puts ""
        puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
        ap_topic_topstories("apf-entertainment")
        puts "Type ap(*) * - the number story: "
      elsif a == "   International"
        puts "TOP STORIES FROM BBC:"
        bbc_topic_topstories("news/world")
        puts "Type bbc(*) * - the number story: "
        puts ""
        puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
        ap_topic_topstories("apf-intlnews")
        puts "Type ap(*) * - the number story: "
      elsif a == "   Technology"
        puts "TOP STORIES FROM BBC:"
        bbc_topic_topstories("news/technology")
        puts "Type bbc(*) * - the number story: "
        puts ""
        puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
        ap_topic_topstories("apf-technology")
        puts "Type ap(*) * - the number story: "
      elsif a == "   Business"
        puts "TOP STORIES FROM BBC:"
        bbc_topic_topstories("news/business")
        puts "Type bbc(*) * - the number story: "
        puts ""
        puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
        ap_topic_topstories("apf-business")
        puts "Type ap(*) * - the number story: "
      end
    end
  end

  def new_channel
    if @@base_path == "https://www.apnews.com/"
      Channel.new("AP - The Associated Press", "https://www.apnews.com/")
    elsif @@base_path == "https://www.bbc.co.uk/news"
      Channel.new("BBC - Britist Broadcast Company", "https://www.bbc.co.uk/")
    elsif @@base_path == "https://www.thebureauinvestigates.com/stories/"
      Channel.new("TBIJ - The Bureau of Investigative Journalism", "https://www.thebureauinvestigates.com/stories/")
    end

  end

  def latest_top
    puts "TOP STORIES FROM BBC:"
    bbc_list_topstories
    puts "Type bbc(*) * - the number story: "
    puts ""
    puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
    list_topstories
    puts "Type ap(*) * - the number story: "
    puts ""
    puts "TOP STORIES FROM THE BUREAU OF INVENSTIGAIVE JOURNALISM:"
    tbij_list_topstories
    puts "Type tbij(*) * - the number story: "
  end

  def navigate
    puts ""
    puts "< = Choose Another story."
    puts "<< = Back To Main Menu"
  end

  def nav_input
    input = gets.chomp()
    case input
    when "<"
      article_selection
    when "<<"
      Article.all.clear
      run
    else
      puts "Unknown Please Try Again!!"
      nav_input
    end
  end

  # def topic_nav_input
  #   input = gets.chomp()
  #   case input
  #   when "<"
  #     topic_article_selection
  #   when "<<"
  #     Article.all.clear
  #     system('clear')
  #     run
  #   else
  #     puts "Unknown Please Try Again!!"
  #     nav_input
  #   end
  # end

  def article_selection
    input = gets.chomp()
    selection = Article.all[input.to_i - 1]
    #if input.between?(1,5)
    text = selection.content.to_s
    puts text.wrap 150
    # else
    #   puts "Unknown Please Try Again!!"
    #   article_selection
    # end
    navigate
    nav_input
  end

  def topic_article_selection
    input = gets.chomp()
    case input
    when input = "bbc1"
      puts Article.all[0].content
    when input = "bbc2"
      puts Article.all[1].content
    when input = "bbc3"
      puts Article.all[2].content
    when input = "bbc4"
      puts Article.all[3].content
    when input = "bbc5"
      puts Article.all[4].content
    when input = "ap1"
      puts Article.all[5].content
    when input = "ap2"
      puts Article.all[6].content
    when input = "ap3"
      puts Article.all[7].content
    when input = "ap4"
      puts Article.all[8].content
    when input = "ap5"
      puts Article.all[9].content
    when input = "tbij1"
      puts Article.all[10].content
    when input = "tbij2"
      puts Article.all[11].content
    when input = "tbij3"
      puts Article.all[12].content
    when input = "tbij4"
      puts Article.all[13].content
    when input = "tbij5"
      puts Article.all[14].content
    else
      puts "Sorry Invalid Entry Please Check And Try Again:"
      topic_article_selection
    end
    navigate
    topic_nav_input
  end

  #----------------------INPUT METHODS----------------------------------------
  #----------------------AP------------------------------------------------
    def make_ap_topstories
      topstories = Scraper.scrape_ap_home_page("https://www.apnews.com/")
      Article.new_from_ap_scrape(topstories)
    end

    # def list_topstories
    #   Channel.all.each do |channel|
    #     channel.articles.each_with_index do |article, i|
    #       puts "#{i += 1}.  " " #{article.title}"
    #     end
    #   end
    # end

    def list_topstories
      make_ap_topstories.each_with_index do |story, i|
        puts "#{i += 1}.  #{story[:title]}"
      end
    end

    def ap_topic_search(extention)
      topstories = Scraper.scrape_ap_list_page("https://www.apnews.com/" + extention)
      Article.new_from_ap_topic_scrape(topstories)
    end

    def ap_topic_topstories(extention)
      ap_topic_search(extention).each_with_index do |story, i|
        puts "#{i += 1}.  #{story[:title]}"
      end
    end
  #---------------------------------------------------------------------------
  #--------------------------------BBC----------------------------------------
    def make_bbc_topstories
      topstories = Scraper.scrape_bbc_home_page("https://www.bbc.co.uk/news/")
      Article.new_from_bbc_scrape(topstories)
    end

    def bbc_list_topstories
      make_bbc_topstories.each_with_index do |story, i|
        puts "#{i += 1}.  #{story[:title]}"
      end
    end

    def bbc_sport_search(extention)
      topstories = Scraper.scrape_bbc_sport_page("https://www.bbc.co.uk/" + extention)
      Article.new_from_bbc_topic_scrape(topstories[0..4])
    end

    def bbc_topic_search(extention)
      topstories = Scraper.scrape_bbc_list_page("https://www.bbc.co.uk/" + extention)
      Article.new_from_bbc_topic_scrape(topstories)
    end

    def bbc_topic_topstories(extention)
      bbc_topic_search(extention).each_with_index do |story, i|
        puts "#{i += 1}.  #{story[:title]}"
      end
    end
    #---------------------------------------------------------------------------
    #-------------------------------TBIJ----------------------------------------
    def make_tbij_topstories
      topstories = Scraper.scrape_tbij_home_page("https://www.thebureauinvestigates.com/stories/")
      Article.new_from_tbij_scrape(topstories)
    end

    def tbij_list_topstories
      make_tbij_topstories.each_with_index do |story, i|
        puts "#{i += 1}.  #{story[:title]}"
      end
    end
  #---------------------------------------------------------------------------
end
