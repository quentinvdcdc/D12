require 'nokogiri'
require 'open-uri'
require 'pry'

def scrap_money
	money_table = []
	h = {}
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	page.css("tbody").css("tr").each do |tr|
		h[tr.css("td[class='no-wrap currency-name']").to_s.match(/data-sort=(.*)/).to_s.split("\"")[1].to_s.to_sym] = [tr.css("td[class='text-left col-symbol']").to_s.split("\"")[2].delete('></td'), tr.css("a[class='price']").to_s.match(/\$\d+\.\d+/).to_s.delete('$').to_f]
		money_table << h
		h = {}
		#binding.pry
	end
	return money_table
end


