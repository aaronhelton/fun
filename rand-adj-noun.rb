#!/bin/env ruby

require 'getoptlong'

class ArgumentParser
  attr_reader :adj_list, :noun_list

  def initialize
    @opts = GetoptLong.new(
      ["--adjlist", "-a", GetoptLong::OPTIONAL_ARGUMENT],
      ["--nounlist", "-n", GetoptLong::OPTIONAL_ARGUMENT]
    )
    @adj_list = "adjectives.txt"
    @noun_list = "nouns.txt"
  end

  def parse_arguments
    @opts.each do |opt,arg|
      case opt
      when '--adjlist'
        @adj_list = arg
      when '--nounlist'
        @noun_list = arg
      end
    end
  end
end

class DataHandler
  def initialize
  end

  def get_word(data_file)
    file = File.open(data_file).to_a
    word = file[rand(file.length)].chomp
    return word
  end
end

arguments = ArgumentParser.new
arguments.parse_arguments

dh = DataHandler.new
adj = dh.get_word(arguments.adj_list).capitalize
noun = dh.get_word(arguments.noun_list).capitalize

puts "#{adj} #{noun}"
