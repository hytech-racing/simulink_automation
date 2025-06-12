    % List of model names to build
rootFolder = pwd;  % Get the current folder
addpath(genpath(rootFolder));  % Add all sub-folders

% HT09_Vehicle_Parameters;
load_params;
    
%%
fname = 'models.json';
fid = fopen(fname); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
models_json = jsondecode(str);


% load the standard codegen 
load('hytech_codegen_config_r2.mat');

%%
controllers = models_json.controllers;
estimators = models_json.estimators;

% Cell array to store the generated zip file names
zipFiles = {};
zipFiles.controllers = {};
zipFiles.estimators = {};
% Loop over each model


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

% Write the list of zipped files to a JSON file
jsonFileName = 'zipped_files.json';
fid = fopen(jsonFileName, 'w');
if fid == -1
    error('Cannot create JSON file.');
end

% Encode the cell array directly as a JSON list
fprintf(fid, '%s\n', jsonencode(zipFiles));
fclose(fid);

fprintf('All models built and zipped successfully. JSON saved to %s.\n', jsonFileName);