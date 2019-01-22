require_relative '../lib/mairie'

describe "test get_townhall_urls" do 
	it "number of townhalls" do
		expect(get_townhall_urls.size).to eq(185)
	end	

	it "exact email address for attainville" do
		expect(get_townhall_urls.select{|couple| couple[:Attainville]}[0].values).to eq(["mairie@attainville.fr"])
	end
end