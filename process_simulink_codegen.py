import zipfile
import os
import sys
import json
from mako.template import Template
from mako.lookup import TemplateLookup
from pathlib import Path
import shutil
import json_to_proto

# PREFACE:
# This is not maintainable. this is a hack. i do not care. append if you dare, refactor if you must.
# it would be 

from enum import Enum

class ModelType(Enum):
    CONTROLLER = "controller"
    ESTIMATOR = "estimator"

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
        # Load the JSON file
        with open(json_file, 'r') as f:
            data = json.load(f)

        # Access the lists
        controllers = data.get('controllers', [])
        estimators = data.get('estimators', [])
        return controllers, estimators
    
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
    return os.path.join(*path.split(os.sep)[2:])

def generate_cmakelists(libraries, output_dir):
    template = Template(filename='CMakeLists.txt.mako')
    rendered = template.render(libraries=libraries)

    cmake_file_path = os.path.join(output_dir, 'CMakeLists.txt')
    with open(cmake_file_path, 'w') as f:
        f.write(rendered)
    
    print(f"CMakeLists.txt generated at '{cmake_file_path}'.")

def generate_matlab_model_proto_reg_helper(proto_file_names, output_dir):
    proto_reg_template = Template(filename='matlab_model/MatlabModelProtoRegHelper.hpp.mako')
    rendered_reg_templt = proto_reg_template.render(proto_file_names = proto_file_names)
    proto_reg_helper = os.path.join(output_dir, 'MatlabModelProtoRegHelper.hpp')
    with open(proto_reg_helper, 'w') as f:
        f.write(rendered_reg_templt)


def parse_inport_json(json_file):
    with open(json_file, 'r') as f:
        json_data = json.load(f)
        inport_data = json_data["inports"]
        outport_data = json_data["outports"]

        inputs = []
        parameters = {}
        outports = []

        for inport in inport_data:
            if (inport_data[inport]) == 1:
                inputs.append(inport)
            elif (inport_data[inport] == 2):
                parameters[inport] = "bool"
            else:
                parameters[inport] = "float"

        for outport in outport_data:
            outports.append(outport)
        

        return [inputs, parameters, outports]


def generate_model_integration(template_lookup, model_type, model, parameters, inputs, outports, output_include, output_src):
    if model_type == ModelType.CONTROLLER:
        header_template_path = "matlab_model/MatlabControllerModelIntegration.hpp.mako"
        src_template_path = "matlab_model/MatlabControllerModelIntegration.cpp.mako"

    elif model_type == ModelType.ESTIMATOR:
        header_template_path = "matlab_model/MatlabEstimatorModelIntegration.hpp.mako"
        src_template_path = "matlab_model/MatlabEstimatorModelIntegration.cpp.mako"

    else:
        raise ValueError(f"Unsupported model type: {model_type}")
        

    header_template = Template(filename=header_template_path)
    header_rendered = header_template.render(
        model=model, parameters=parameters, inputs=inputs, outports=outports
    )
    

    
    src_template = Template(filename=src_template_path, lookup=template_lookup)
    src_rendered = src_template.render(
        model=model, parameters=parameters, inputs=inputs, outports=outports
    )

    integration_header_fpath = os.path.join(output_include, model + '_MatlabModel.hpp')
    with open(integration_header_fpath, 'w') as f:
        f.write(header_rendered)
    print(f"{model}_MatlabModel.hpp generated at '{integration_header_fpath}'.")

    integration_src_fpath = os.path.join(output_src, model + "_MatlabModel.cpp")
    with open(integration_src_fpath, 'w') as f:
        f.write(src_rendered)
    print(f"{model}_MatlabModel.cpp generated at '{integration_src_fpath}'.")

def generate_matlab_model_add_helper(controller_model_names, all_model_names, output_dir):
    model_add_temp = Template(filename='matlab_model/MatlabModelAddHelper.hpp.mako')
    rendered_reg_templt = model_add_temp.render(num_controller_models=len(controller_model_names), controller_model_names=controller_model_names, all_model_names=all_model_names)
    proto_reg_helper = os.path.join(output_dir, 'MatlabModelAddHelper.hpp')
    with open(proto_reg_helper, 'w') as f:
        f.write(rendered_reg_templt)

def makes_codegen_libs(files, output_directory):
    libraries = []  # Store library info for CMake
    cpp_lib_output_dir = os.path.join(output_directory, 'source_code')

    for file in files:
        extraction_path = unzip_and_rename(file, cpp_lib_output_dir)
        if extraction_path:
            remove_specific_files(extraction_path, ["ert_main.cpp", "CMakeLists.txt", "rt_cppclass_main.cpp"])
            directories = list_directories(extraction_path)
            organize_files(extraction_path)  # Organize files into src and include folders
            
            # Collect library information
            library_name = Path(file).stem  # Use the zip file name as library name
            sources = []
            # for dir in directories:
                # Assuming that .cpp files are in the src directory
            src_dir = os.path.join(extraction_path, 'src')
            sources_to_ext = (remove_parent_directory(os.path.join(src_dir, f)) for f in os.listdir(src_dir) if f.endswith('.cpp'))
            sources.extend(sources_to_ext)
            libraries.append({"name": library_name, "sources": sources})
        else:
            print("Failed to extract and process the zip file.")

    return libraries, cpp_lib_output_dir

def generate_estimator_integration(estimator_names, model_output_dict, output_dir):

    estim_int = Template(filename='matlab_model/EstimatorManager.hpp.mako')
    rendered_estim_int = estim_int.render(estimator_names=estimator_names)
    estim_int_file_out = os.path.join(output_dir, 'EstimatorManager.hpp')
    with open(estim_int_file_out, 'w') as f:
        f.write(rendered_estim_int)
        
    estim_output_types = Template(filename='matlab_model/EstimatorOutputs.hpp.mako')
    rend_est_out = estim_output_types.render(model_outputs=model_output_dict)
    
    estim_file_out = os.path.join(output_dir, 'EstimatorOutputs.hpp')
    with open(estim_file_out, 'w') as f:
        f.write(rend_est_out)

    

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python process_simulink_codegen.py <output_directory>")
        sys.exit(1)

    output_directory = sys.argv[1]
    
    # Read the zipped files
    controller_files, estimator_files = read_zipped_files('zipped_files.json') 
    
    

    all_files = controller_files + estimator_files

    libraries, cpp_lib_output_dir = makes_codegen_libs(all_files, output_directory)
    
    # Generate the CMakeLists.txt with the collected libraries
    generate_cmakelists(libraries, cpp_lib_output_dir)
    copy_directory('cmake/', os.path.join(cpp_lib_output_dir, 'cmake'))

    # Generate and move state estimation files
    gend_include_dir = cpp_lib_output_dir + "/matlab_model/include"
    gend_src_dir = cpp_lib_output_dir + "/matlab_model/src"
    os.makedirs(gend_include_dir, exist_ok=True)
    os.makedirs(gend_src_dir, exist_ok=True)

    controller_model_names =[]
    for file in controller_files:
        controller_model_names.append(file.strip(".zip"))
    
    estimator_model_names =[]
    for file in estimator_files:
        estimator_model_names.append(file.strip(".zip"))

    all_model_names = controller_model_names + estimator_model_names
    shutil.copy("matlab_model/MatlabModel.hpp", gend_include_dir)
    shutil.copy("matlab_model/MatlabEstimModel.hpp", gend_include_dir)
    proto_file_names = []

    template_lookup = TemplateLookup(directories=['.'], input_encoding='utf-8')
    for model in controller_model_names:
        # Use inport data to generate header and src matlab math
        inportInfoJsonName = model + "_inport_info.json"
        inputs, parameters, outports = parse_inport_json(inportInfoJsonName)
        print(model)
        generate_model_integration(template_lookup, model_type=ModelType.CONTROLLER, model=model, parameters=parameters, inputs=inputs, outports=outports, output_include=gend_include_dir, output_src=gend_src_dir)
        os.makedirs(output_directory+"/proto_outputs", exist_ok=True)
        pb_proto_name = model + "_estimation_msgs.proto"
        json_to_proto.run(inportInfoJsonName, output_directory+"/proto_outputs/" + pb_proto_name, model)
        proto_file_names.append(pb_proto_name)
    
    estim_out_dict = {}
    for model in estimator_model_names:
        # Use inport data to generate header and src matlab math
        inportInfoJsonName = model + "_inport_info.json"
        inputs, parameters, outports = parse_inport_json(inportInfoJsonName)
        estim_out_dict[model] = outports
        generate_model_integration(template_lookup, model_type=ModelType.ESTIMATOR, model=model, parameters=parameters, inputs=inputs, outports=outports, output_include=gend_include_dir, output_src=gend_src_dir)
        os.makedirs(output_directory+"/proto_outputs", exist_ok=True)
        pb_proto_name = model + "_estimation_msgs.proto"
        json_to_proto.run(inportInfoJsonName, output_directory+"/proto_outputs/" + pb_proto_name, model)
        proto_file_names.append(pb_proto_name)

    generate_matlab_model_proto_reg_helper(proto_file_names, gend_include_dir)
    generate_matlab_model_add_helper(controller_model_names, all_model_names, gend_include_dir) # integration helper template for drivebrainapp
    generate_estimator_integration(estimator_model_names, estim_out_dict, gend_include_dir)
