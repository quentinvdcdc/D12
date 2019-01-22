require_relative './lib/scrapper'
$:.unshift File.expand_path("./../lib", __FILE__)
require 'scrapper'
require 'bundler'
require 'google_drive'
require 'json'
require 'pry'
require 'csv'

def save_as_JSON
	tempHash = {}
	get_townhall_urls.each do |hash|
		tempHash[hash.keys[0]] = hash.values[0]
	end

	File.open("db/emails.json","w") do |f|
  	f.write(tempHash.to_json)
	end
end

def save_as_spreadsheet
	session = GoogleDrive::Session.from_config("config.json")
	ws = session.spreadsheet_by_key("1bc2iKvxIWT9bpZSAvJVCb_la1E5VSXafh9J7rklPero").worksheets[0]
	get_townhall_urls.each_with_index do |hash, i|
		ws[i+1, 1] = hash.keys[0]
		ws[i+1, 2] = hash.values[0]
		ws.save
	end
	ws.reload
end

def save_as_csv
	CSV.open("db/emails.csv","w") do |csv|
		get_townhall_urls.each do |hash|
			csv << [hash.keys[0], hash.values[0]]
		end
	end
end

save_as_csv