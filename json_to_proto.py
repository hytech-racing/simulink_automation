import json
from mako.template import Template
import os
import sys

# 1. Returns JSON Data
def get_json(file_name): 

    f = open(file_name)

    data = json.load(f)
    return data

# 2. Convert JSON
def generate_proto(json_data, output_f_path): 

    try: 
        outports = json_data["outports"]
    except: 
        print("Error: Probably bad data.")
        sys.exit(1)

    count = [0]

    template = Template(filename="proto/estimation_msgs.proto.mako")
    rendered = template.render(outports=outports, count=count)

    with open(output_f_path, 'w') as f: 
        f.write(rendered)
    print("Proto message file successfully generated at " + output_f_path)

def run(json_file, output_f_path): 
    data = get_json(json_file)
    generate_proto(data, output_f_path)
    
