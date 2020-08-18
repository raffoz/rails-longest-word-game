require "open-uri"

class GamesController < ApplicationController

  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  def included?(word, letters)
    word.chars.all? { |char| word.count(char) <= letters.count(char) }
  end

  def english_word?(word)
    answer = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    result = JSON.parse(answer)
    result['found']
  end
end
