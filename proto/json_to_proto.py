import argparse
import json
from mako.template import Template
import os
import sys

# 1. Returns JSON Data
def get_json(): 
    parser = argparse.ArgumentParser()
    parser.add_argument('json_data', type=str)
    args = parser.parse_args()
    data = json.loads(args.json_data)

    return data

# 2. Convert JSON
def generate_proto(json_data, output_dir): 
    try: 
        outports = json_data["outports"]
    except: 
        print("Error: Probably bad data.")
        sys.exit(1)

    template = Template(filename="proto/estimation_msgs.proto.mako")
    rendered = template.render(outports=outports, count=0)

    output_fpath = os.path.join(output_dir, "estimation_msgs.proto")
    with open(output_fpath, 'w') as f: 
        f.write(rendered)
    print("Proto message file successfully generated at " + output_fpath)

if __name__ == "__main__": 
    data = get_json()
    generate_proto(data, "")
