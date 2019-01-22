class Scrapper
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

	def save_as_json
		tempHash = {} #initilisation d'un hash temporaire
		get_townhall_urls.each do |hash| 
			tempHash[hash.keys[0]] = hash.values[0] #extraction de la clé et de la valeur de tout hash compris dans l'array du scrap
		end

		File.open("db/emails.json","w") do |f| #ouverture du fichier en mode écriture
	  	f.write(tempHash.to_json) #écriture dans le fichier json
		end
	end

	def save_as_spreadsheet
		session = GoogleDrive::Session.from_config("config.json") #identification
		ws = session.spreadsheet_by_key("1bc2iKvxIWT9bpZSAvJVCb_la1E5VSXafh9J7rklPero").worksheets[0] #initialisation de la worksheet
		get_townhall_urls.each_with_index do |hash, i| #boucle pour écrire clé et valeur sur cq ligne
			ws[i+1, 1] = hash.keys[0] 
			ws[i+1, 2] = hash.values[0]
		end
		ws.save
		ws.reload
	end

	def save_as_csv
		CSV.open("db/emails.csv","w") do |csv| #ouverture du csv
			get_townhall_urls.each do |hash|
				csv << [hash.keys[0], hash.values[0]] #indentation ligne par ligne de la clé et de la valeur de tout hash compris dans l'array du scrap
			end
		end
	end

	def self.perform
		puts "Bienvenue dans ce scrapper de l'extrême\nVous allez pouvoir scrapper les emails des mairies du Val d'Oire et obtenir le fichier dans le format de VOTRE choix.\nPretty good, huh ?\nAllez, trêve de forfanteries, si Json, tape n°1. Si une bonne vielle spreadsheet, tape n°2. Si csv d'antan, tape n°3"
		print "> "
		choice_of_heart = gets.to_i #entrée pour choisir le mode de réception des data
		case choice_of_heart
		when 1
			Scrapper.new.save_as_json
			puts "Excellence choice Adam"
		when 2
			Scrapper.new.save_as_spreadsheet
			puts "Ho ho ho, it's Santa's time today"
		when 3
			Scrapper.new.save_as_csv
			puts "Seriously ? CSV ? At least, do you know the Turbo Pascal language ? Oldies but goodies"
		end
	end
end