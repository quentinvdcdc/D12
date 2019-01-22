require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def get_townhall_email(townhall_url)
	doc = Nokogiri::HTML(open(townhall_url))
	return doc.css('tbody').css('tr')[3].css('td')[1].to_s.match(/>(.*)</).to_s.delete("><")
end

def get_townhall_urls
	h = {}
	array_townhall = []
	page = "http://annuaire-des-mairies.com"
	doc = Nokogiri::HTML(open(page + "/val-d-oise.html"))
	doc.xpath('//a[@class="lientxt"]').each do |node|
		 h[node.text.capitalize.to_sym] = get_townhall_email(page + node.xpath('@href').text.gsub!(/^\./, "").to_s)
		 array_townhall << h
		 #binding.pry
		 h = {}
	end
	return array_townhall
end
