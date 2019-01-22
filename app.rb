require_relative './lib/scrapper'
$:.unshift File.expand_path("./../lib", __FILE__)
require 'scrapper'
require 'bundler'
require 'google_drive'
require 'json'
require 'pry'

def save_as_JSON
	tempHash = {}
	get_townhall_urls.each do |hash|
		tempHash[hash.keys[0]] = hash.values[0]
	end

	File.open("db/emails.json","w") do |f|
  	f.write(tempHash.to_json)
	end
end

save_as_JSON