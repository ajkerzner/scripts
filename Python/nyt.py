#!/usr/bin/env python2
# -*- coding: utf-8 -*-
# Alex Kerzner
from collections import defaultdict
import csv
import numpy as np

#### Configuration ####

FILE_PATH = "../"
#FILE_PATH = "./dds_datasets/dds_ch2_nyt/"

NUMBER_OF_FILES = 10
#NUMBER_OF_FILES = 31

#### Variables ####

data = {}
keys = ["-17","18-24","25-34","35-44","45-54","55-64","65+"]

#### Initialize data ####

for key in keys:
	data[key] = []

#### Get data and split by age group ####

# For every file
for i in range(NUMBER_OF_FILES):
	# Define the file_name as the path to file
	file_name = FILE_PATH + "nyt" + str(i + 1) + ".csv"
	with open(file_name) as file:
		# Read the file as a csv file, store as list of dictionaries
		reader = csv.DictReader(file)
		# Add row (stored as dictionary) to list at data[<age_group>]
		for row in reader:
			# Grouping into age groups
			age = int(row["Age"])
			if   age <  0:
				# Ages should not be negative
				print "Error: negative age"
			elif age < 18:
				data["-17"  ].append(row)
			elif age < 25:
				data["18-24"].append(row)
			elif age < 35:
				data["25-34"].append(row)
			elif age < 45:
				data["35-44"].append(row)
			elif age < 55:
				data["45-54"].append(row)
			elif age < 65:
				data["55-64"].append(row)
			elif age > 64:
				data["65+"  ].append(row)
			else:
				print "Error: not a number"


#### Print number of persons in each age group ####

# Print the first file's data
for key in keys:
	age_group = key
	number_of_people = len(data[key])
	print "Group {:5s}: {:10,d} people".format(age_group, number_of_people)

# {:5s} means that, if the width of age_group is less than 5, spaces are added
#   so that the width is equal to 5. If greater than 5, age_group is truncated.

# {:10,d} does the same with a number, and additionally uses a comma as a
#   thousands separator.

# See also

# https://docs.python.org/2/reference/compound_stmts.html#the-if-statement

