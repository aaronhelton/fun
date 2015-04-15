#!/bin/env ruby

# Setup four hats
hats = Array.new
red_hats = 2
blue_hats = 2
(0..3).each do |i|
  #get a random number, 0 or 1
  r = Random.rand(2)
  if r == 0
    if red_hats > 0
      hats[i] = 'red'
      red_hats -= 1
    else
      hats[i] = 'blue'
      blue_hats -= 1
    end
  elsif r == 1
    if blue_hats > 0
      hats[i] = 'blue'
      blue_hats -= 1
    else
      hats[i] = 'red'
      red_hats -= 1
    end
  end
end

# Setup four prisoners
prisoners = Array.new
(0..3).each do |i|
  prisoners[i] = { :name => i, :my_actual_state => hats[i], :can_see => [] }
  case i
    when 0
      then prisoners[i][:can_see] << 1 << 2 
    when 1
      then prisoners[i][:can_see] << 2
  end
end

#Logic for prisoner 0
blue_hats_i_see = 0
red_hats_i_see = 0

prisoners[0][:can_see].each do |other|
  #What can I see?
  puts "I, prisoner #{prisoners[0][:name]}, can see that prisoner #{prisoners[other][:name]} has a #{prisoners[other][:my_actual_state]} hat."
  
  #What does that tell me about my own state?
  if prisoners[other][:my_actual_state] == 'red'
    red_hats_i_see += 1
  else
    blue_hats_i_see += 1
  end
end

#Do I call or pass?
if red_hats_i_see == 2
  # I have a blue hat
  puts "Call: I, prisoner #{prisoners[0][:name]}, am wearing a blue hat."
  abort
elsif blue_hats_i_see == 2
  # I have a red hat
  puts "Call: I, prisoner #{prisoners[0][:name]}, am wearing a red hat."
  abort
else
    # I have to pass
    puts "(remain silent)"
end

#Logic for prisoner 1
prisoners[1][:can_see].each do |other|
  puts "I, prisoner #{prisoners[1][:name]}, can see that prisoner #{prisoners[other][:name]} has a #{prisoners[other][:my_actual_state]} hat."
  if prisoners[other][:my_actual_state] == 'red'
    puts "Call: I, prisoner #{prisoners[1][:name]}, am wearing a blue hat."
  else
    puts "Call: I, prisoner #{prisoners[1][:name]}, am wearing a red hat."
  end
end
