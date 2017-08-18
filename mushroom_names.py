#! /usr/bin/env python

# open our input files
mushrooms_a = open('mushroom_a.txt','r').read().splitlines()
mushrooms_b = open('mushroom_b.txt','r').read().splitlines()
mushrooms_c = open('mushroom_c.txt','r').read().splitlines()

patterns = ['ac','abc','bc','bbc','bac']

import random

# Make 10 possibilities
for i in range(0,10):
  out_string = []
  rand_pattern = random.choice(patterns)
  for p in rand_pattern:
    if p == 'a':
      possess = random.choice([0,1])
      rand_a = random.choice(mushrooms_a)
      if possess == 1:
        rand_a = rand_a + "'s"
      out_string.append(rand_a)
    else:
      rand_x = random.choice(eval("mushrooms_" + p))
      out_string.append(rand_x)

  print(' '.join(out_string))
