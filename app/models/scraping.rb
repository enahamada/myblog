require 'mechanize'

# require 'open-uri'

# url = 'https://www.hizenyumekaidou.info/'

# charset = nil

# html = open(url) do |f|
#     charset = f.charset
#     f.read
# end

# doc = Nokogiri::HTML.parse(html, nil, charset)
# doc.xpath('//h1[@class="searchResult_itemTitle"]').each do |node|
#   p node.css('a').inner_text
# end

class Scraping
  agent = Mechanize.new

  # 複数ページのリンクを収納するために事前に配列を用意
  links = [] 

  # 最初は次のURL（パス）がないため空文字列を用意
  next_urls = ""

  while true
    # 変数pageをcurrent_pageに変更（複数ページが存在するため）
    current_page = agent.get("https://www.hizenyumekaidou.info/" + next_link) 
    elements = current_page.search('.title')
    elements.each do |ele|
      links << ele.get_attribute('href')
    end
    
    next_link = current_page.at('')
    # 次のページのリングタグがなければwhile文から抜ける
    break unless next_link
    next_url = next_link.get_attribute('href')
  end
  
  links.each do |link|
    get_book('https://www.hizenyumekaidou.info/'+ link)
  end
end