clc;

% List of model names to build
rootFolder = pwd;  % Get the current folder
addpath(genpath(rootFolder));  % Add all sub-folders

% HT09_Vehicle_Parameters;
% HT09_MBD_Vehicle_Parameters;
load_params;
load_ekf_params;
    
%%
fname = 'models.json';
fid = fopen(fname); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
models_json = jsondecode(str);


% load the standard codegen 
load('hytech_codegen_config_no_halide.mat');

%%
controllers = models_json.controllers;
estimators = models_json.estimators;



% Cell array to store the generated zip file names
zipFiles = {};
zipFiles.controllers = {};
zipFiles.estimators = {};
% Loop over each model

controller_base_list = {'htx_qp_torq_allocator_base'};

for i = 1:length(controller_base_list)
    load_system(controller_base_list{i});
    set_param(controller_base_list{i}, 'SolverName', 'FixedStepAuto')
end

estimator_base_list = {'htx_amk_eff_estimator_base', 'htx_intent_estimator_base', 'htx_ekf_base', 'htx_wheel_steer_estimator_base'};

for i = 1:length(estimator_base_list)
    load_system(estimator_base_list{i});
    set_param(estimator_base_list{i}, 'SolverName', 'FixedStepAuto')
end

for i = 1:length(controllers)
    modelName = controllers{i}; % Get the model name from the list
    zipFileName = buildModel(modelName, Configuration);
    zipFiles.controllers{end+1} = zipFileName;
    fprintf('Generated zip file: %s\n', zipFileName);  % Output the zip file name
end
 

for i = 1:length(estimators)
    modelName = estimators{i}; % Get the model name from the list
    zipFileName = buildModel(modelName, Configuration);
    zipFiles.estimators{end+1} = zipFileName;
    fprintf('Generated zip file: %s\n', zipFileName);  % Output the zip file name
end

simulink_cfg = Simulink.fileGenControl('getConfig');
code_gen_folder = simulink_cfg.CodeGenFolder;

% Write the list of zipped files to a JSON file
jsonFileName = 'zipped_files.json';
jsonFileName = fullfile(code_gen_folder, jsonFileName);
fid = fopen(jsonFileName, 'w');
if fid == -1
    error('Cannot create JSON file.');
end

% Encode the cell array directly as a JSON list
fprintf(fid, '%s\n', jsonencode(zipFiles));
fclose(fid);

fprintf('All models built and zipped successfully. JSON saved to %s.\n', jsonFileName);