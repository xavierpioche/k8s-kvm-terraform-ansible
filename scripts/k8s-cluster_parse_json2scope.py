#!/usr/bin/python3
import sys
import json
import re


file_path=sys.argv[1]

with open(file_path,'r') as f:
	data = json.load(f)


k=len(data[0])

print('variablescopes:')
print('- {')

for x in range(k):
	X=str(x)
	addr=re.sub("[^A-Za-z0-9\.]","",str(data[0][X]["vm_address"]))
	name=re.sub("[^A-Za-z0-9\.]","",str(data[0][X]["vm_name"]))
	print("\t" + str(name) + ': ' + str(name) + ',')
	print("\t" + str(name) + '_ip : ' + str(addr) + ',')

if len(sys.argv) > 2:
	ansible=str(sys.argv[2])
else:
	ansible="xavier"

print("\tansible_user: " + ansible)
print('}')
