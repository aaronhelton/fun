#!/usr/bin/ruby

require 'rubygems'
require 'marky_markov'

text_source = 'pg1041.romp.txt'
out_a = []

markov = MarkyMarkov::Dictionary.new('dictionary')
markov.parse_file(text_source)
out_line = markov.generate_113_words
markov.save_dictionary!
words = out_line.split(/\s/)
wpl = words.length / 14
i = 0
13.times do
  p words[i..(i + wpl-1)].join(" ")
  i = i + wpl
end
p words[i..words.length].join(" ")
