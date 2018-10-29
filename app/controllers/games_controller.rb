require 'json'
require 'open-uri'

class GamesController < ApplicationController
  # before_action :load_receiver
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    a = open(url).read
    data_hash = JSON.parse(a)
    letter_hash = letter_count(params[:letters].split(" ").join)
    word_hash = letter_count(@word)
    if (data_hash["found"] == true) && (word_hash.all? { |let, freq| letter_hash[let] >= freq })
      @score = "all ok"
    elsif (data_hash["found"] == true) && !(word_hash.all? { |let, freq| letter_hash[let] >= freq })
      @score = "valid but not using all good letters"
    elsif !(data_hash["found"] == true) && (word_hash.all? { |let, freq| letter_hash[let] >= freq })
      @score = "not valid"
    end
  end

  def letter_count(str)
    str.downcase.each_char.with_object({}) { |c,h|
      (h[c] = h.fetch(c,0) + 1) if c =~ /[a-z]/ }
  end
end

# passing instance variables between requests is impossible... controller actions backing different request


