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
    # letter_hash = Hash.new(0)
    letters = params[:letters].split(" ").join
    # word_hash = letter_count(@word)
    if (data_hash["found"] == false)
      @answer = "not an english word"
    elsif @word.chars.all? { |letter| @word.count(letter) <= letters.count(letter) } == false
      @answer = "letters not in grid"
    else
      @answer = "Well Done"
      session[:answer] += @word.size
    end
  end
end

# passing instance variables between requests is impossible... controller actions backing different request



