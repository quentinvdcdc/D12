require_relative './lib/scrapper'
require_relative './lib/emailsender'
$:.unshift File.expand_path("./../lib", __FILE__)
require 'lib/scrapper'
require 'bundler'
require 'google_drive'



def save_as_JSON
render :json => my_object
