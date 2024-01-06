#!/usr/bin/python3
import sys
import os.path 
from jinja2 import Environment, FileSystemLoader, Template
import yaml
import json
import argparse

try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper

parser = argparse.ArgumentParser(description="example : -s myproject/project.yaml -t gcp-vm-create.j2 -o myproject/gcp-vm-create.bat", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("-s", "--scope", help="yaml variables file for scope")
parser.add_argument("-t", "--template", help="template file to render")
parser.add_argument("-o", "--output", help="output file to write")
args = parser.parse_args()

if not len(sys.argv) == 7:
    parser.print_help()
    print(len(sys.argv))
    sys.exit()

config = vars(args)

TemplatesDirectory="templates/"
ScopesDirectory="scopes/"
OutputDirectory="output/"

ENV = Environment(loader=FileSystemLoader(TemplatesDirectory))

if not os.path.isfile(ScopesDirectory+config['scope']) or not os.path.isfile(TemplatesDirectory+config['template']):
    print("some input files are missing")
    sys.exit()

with open(ScopesDirectory+config['scope']) as inputfile:
    variablescopes =  yaml.load(inputfile, Loader=Loader)

template = ENV.get_template(config['template'])

with open(OutputDirectory+config['output'], "w") as file:
    file.write(template.render(variablescopes=variablescopes))
