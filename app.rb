require 'open-uri'
require 'csv'
require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/scrapper'

Scrapper.perform