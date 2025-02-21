import zipfile
import os
import sys
import json
from mako.template import Template
from pathlib import Path
import shutil
import json_to_proto

def copy_directory(src, dest):
    """
    Copies the contents of the source directory to the destination directory.
    Creates the destination directory if it doesn't exist.
    
    Args:
        src (str): Path to the source directory.
        dest (str): Path to the destination directory.
    """
    # Check if the source directory exists
    if not os.path.isdir(src):
        raise FileNotFoundError(f"Source directory '{src}' does not exist.")

    # Create the destination directory if it doesn't exist
    os.makedirs(dest, exist_ok=True)

    # Copy the entire directory tree
    try:
        shutil.copytree(src, dest, dirs_exist_ok=True)
        print(f"Directory copied from '{src}' to '{dest}'")
    except shutil.Error as e:
        print(f"Error during copying: {e}")

def read_zipped_files(json_file):
    try:
        with open(json_file, 'r') as f:
            zip_files = json.load(f)
        
        if isinstance(zip_files, list):
            return zip_files
        else:
            raise ValueError("JSON content is not a list.")
    
    except FileNotFoundError:
        print(f"Error: File '{json_file}' not found.")
        return []
    except json.JSONDecodeError:
        print(f"Error: Failed to parse '{json_file}' as JSON.")
        return []
    except ValueError as e:
        print(f"Error: {e}")
        return []

def unzip_and_rename(zip_path, output_dir):
    if not os.path.isfile(zip_path):
        print(f"Error: '{zip_path}' does not exist.")
        return None

    extraction_path = os.path.join(output_dir, Path(zip_path).stem)
    os.makedirs(extraction_path, exist_ok=True)  # Ensure the extraction directory exists

    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(extraction_path)

    print(f"Contents extracted to '{extraction_path}'.")
    return extraction_path

def remove_specific_files(directory, filenames):
    for root, dirs, files in os.walk(directory):
        for filename in filenames:
            if filename in files:
                os.remove(os.path.join(root, filename))
                print(f"Removed '{filename}' from '{root}'")

def list_directories(base_path):
    directories = []
    for root, _, _ in os.walk(base_path, topdown=True):
        relative_dir = os.path.relpath(root, base_path)
        if relative_dir != ".":
            directories.append(relative_dir)
    return directories

def organize_files(base_path):
    src_path = os.path.join(base_path, 'src')
    include_path = os.path.join(base_path, 'include')

    os.makedirs(src_path, exist_ok=True)
    os.makedirs(include_path, exist_ok=True)

    for root, _, files in os.walk(base_path):
        for file in files:
            if file.endswith('.cpp'):
                new_location = os.path.join(src_path, file)
                os.rename(os.path.join(root, file), new_location)
                print(f"Moved '{file}' to 'src/'")
            elif file.endswith('.h'):
                new_location = os.path.join(include_path, file)
                os.rename(os.path.join(root, file), new_location)
                print(f"Moved '{file}' to 'include/'")

    for root, dirs, files in os.walk(base_path, topdown=False):
        for file in files:
            if not (file.endswith('.cpp') or file.endswith('.h')):
                os.remove(os.path.join(root, file))
                print(f"Removed '{file}' from '{root}'")
        for dir in dirs:
            dir_path = os.path.join(root, dir)
            try:
                os.rmdir(dir_path)
                print(f"Removed empty directory '{dir_path}'")
            except OSError:
                pass
def format_sources(sources):
    return " ".join(sources)

def remove_parent_directory(path):
    return os.path.join(*path.split(os.sep)[1:])

def generate_cmakelists(libraries, output_dir):
    template = Template(filename='CMakeLists.txt.mako')
    rendered = template.render(libraries=libraries)

    cmake_file_path = os.path.join(output_dir, 'CMakeLists.txt')
    with open(cmake_file_path, 'w') as f:
        f.write(rendered)
    
    print(f"CMakeLists.txt generated at '{cmake_file_path}'.")

def parse_inport_json(json_file):
    with open(json_file, 'r') as f:
        inport_data = json.load(f)["inports"]

        inputs = []
        parameters = {}
        
        for inport in inport_data:
            if (inport_data[inport]) == 1:
                inputs.append(inport)
            elif (inport_data[inport] == 2):
                parameters[inport] = "bool"
            else:
                parameters[inport] = "float"

        return [inputs, parameters]


def generate_model_integration(model, parameters, inputs, output_include, output_src):
    header_template = Template(filename="matlab_model/MatlabModelIntegration.hpp.mako")
    header_rendered = header_template.render(model=model, parameters=parameters, inputs=inputs)

    src_template = Template(filename="matlab_model/MatlabModelIntegration.cpp.mako")
    src_rendered = src_template.render(model=model, parameters=parameters, inputs=inputs)

    integration_header_fpath = os.path.join(output_include, model + '_MatlabModel.hpp')
    with open(integration_header_fpath, 'w') as f:
        f.write(header_rendered)

    print(f"{model}_MatlabModel.hpp generated at '{integration_header_fpath}'.")

    inegration_src_fpath = os.path.join(output_src, model + "_MatlabModel.cpp")
    with open(inegration_src_fpath, 'w') as f:
        f.write(src_rendered)

    print(f"{model}_MatlabModel.hpp generated at '{inegration_src_fpath}'.")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python process_simulink_codegen.py <output_directory>")
        sys.exit(1)

    output_directory = sys.argv[1]
    
    # Read the zipped files
    files = read_zipped_files('zipped_files.json') 
    libraries = []  # Store library info for CMake

    for file in files:
        extraction_path = unzip_and_rename(file, output_directory)
        if extraction_path:
            remove_specific_files(extraction_path, ["ert_main.cpp", "CMakeLists.txt"])
            directories = list_directories(extraction_path)
            organize_files(extraction_path)  # Organize files into src and include folders
            
            # Collect library information
            library_name = Path(file).stem  # Use the zip file name as library name
            sources = []
            for dir in directories:
                # Assuming that .cpp files are in the src directory
                src_dir = os.path.join(extraction_path, 'src')
                sources.extend(remove_parent_directory(os.path.join(src_dir, f)) for f in os.listdir(src_dir) if f.endswith('.cpp'))
            libraries.append({"name": library_name, "sources": sources})
        else:
            print("Failed to extract and process the zip file.")

    # Generate the CMakeLists.txt with the collected libraries
    generate_cmakelists(libraries, output_directory)
    copy_directory('cmake/', os.path.join(output_directory, 'cmake'))

    # Generate and move state estimation files
    state_estimation_include = output_directory + "/matlab_model/include"
    state_estimation_src = output_directory + "/matlab_model/src"
    os.makedirs(state_estimation_include, exist_ok=True)
    os.makedirs(state_estimation_src, exist_ok=True)
    shutil.copy("matlab_model/MatlabModel.hpp", state_estimation_include)
    for file in files:
        # Use inport data to generate header and src matlab math
        inportInfoJsonName = file.strip(".zip") + "_inport_info.json"
        inputs, parameters = parse_inport_json(inportInfoJsonName)
        generate_model_integration(model=file.strip(".zip"), parameters=parameters, inputs=inputs, output_include=state_estimation_include, output_src=state_estimation_src)
        os.makedirs("proto_outputs", exist_ok=True)
        json_to_proto.run(inportInfoJsonName, "proto_outputs/" + file.strip(".zip") + "_estimation_msgs.proto")
