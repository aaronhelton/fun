#!/bin/env ruby

require 'getoptlong'
require 'unicode_utils/u'

# This is a condensed copy of the work done by Alan Skorkin here: http://www.skorks.com/2009/07/how-to-write-a-name-generator-in-ruby/

class ArgumentParser
  attr_reader :data_file, :words_to_generate, :reverse
  
  def initialize
    @opts = GetoptLong.new(
	  ["--datafile", "-d", GetoptLong::OPTIONAL_ARGUMENT],
	  ["--number-of-words", "-n", GetoptLong::OPTIONAL_ARGUMENT],
          ["--reverse", "-r", GetoptLong::OPTIONAL_ARGUMENT]
	)
	@data_file = "data.txt"
	@words_to_generate = 10
        @reverse = false
  end
  
  def parse_arguments
    @opts.each do |opt, arg|
	  case opt
	  when '--datafile'
	    @data_file = arg
	  when '--number-of-words'
	    @words_to_generate = arg
          when '--reverse'
            @reverse = true
	  end
	end
  end
end

class DataHandler
  attr_reader :follower_letters, :start_pairs
  def initialize
    @start_pairs = []
    @follower_letters = Hash.new('')
  end

  def read_data_file(data_file)
    File.open(data_file, 'r') do |file|
      chars = file.read.chomp.downcase.gsub(/\s/, ' ').chars.to_a
      chars.push(chars[0], chars[1])
      populate_followers_and_start_pairs(chars)
    end
  end

  def populate_followers_and_start_pairs(chars)
    (chars.length-2).times do |i|
      if chars[i] =~ /\s/
        @start_pairs.push(chars[i+1, 2].join)
      end
      @follower_letters[chars[i, 2].join]=@follower_letters[chars[i,2].join]+chars[i+2,1].join
    end
  end

  private :populate_followers_and_start_pairs
end

class NameGenerator
  def initialize(follower_letters, min_length = 3, max_length = 9)
    @min_word_length = min_length
    @max_word_length = max_length
    @follower_letters = follower_letters
  end

  def generate_name(word)
    last_pair = word[-2, 2]
    letter = @follower_letters[last_pair].slice(rand(@follower_letters[last_pair].length), 1)
    if word =~ /\s$/
      return word[0, @max_word_length] unless word.length <= @min_word_length
      return generate_name(word[-1, 1]+letter)
    else
      word = word.gsub(/^\s/, '')
      return generate_name(word+letter)
    end
  end

  def generate_names(start_pairs, count = 10)
    names = []
    count.times do |i|
      names.push(generate_name(start_pairs[rand start_pairs.length]))
    end
    return names
  end
end

argument_parser = ArgumentParser.new
argument_parser.parse_arguments
data_handler = DataHandler.new
data_handler.read_data_file(argument_parser.data_file)
name_generator = NameGenerator.new(data_handler.follower_letters)
names = name_generator.generate_names(data_handler.start_pairs, argument_parser.words_to_generate)
names.each do |name| 
  if argument_parser.reverse
    puts name.reverse
  else
    puts name
  end
end
