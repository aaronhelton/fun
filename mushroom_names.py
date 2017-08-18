#! /usr/bin/env python

# \xc2\xa0

# open our input files
mushrooms = open('mushrooms.txt','r').read().splitlines()
monsters = open('monsters.txt','r').read().splitlines()

import random

# Make 10 possibilities
for i in range(0,10):
  rand_s = random.choice(random.choice(mushrooms).split(' '))
  rand_m = random.choice(monsters)

  possess = random.choice([0,1])
  if possess == 1:
    rand_m = rand_m + "'s"

  print(rand_m,rand_s)
