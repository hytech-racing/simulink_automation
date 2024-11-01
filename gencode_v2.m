% List of model names to build
rootFolder = pwd;  % Get the current folder
addpath(genpath(rootFolder));  % Add all sub-folders

HT09_Vehicle_Parameters;

modelList = {'Tire_Model_Codegen', 'Tire_Model_Codegen_v2'}; 
close all;

% Cell array to store the generated zip file names
zipFiles = {};
% Loop over each model
for i = 1:length(modelList)
    modelName = modelList{i}; % Get the model name from the list
    
    fprintf('Building model: %s\n', modelName); % Display progress
    
    % Load the Simulink model
    load_system(modelName);
    
    % Build the model
    slbuild(modelName)
    
    % Close the system to free memory
    close_system(modelName, 0);

    % Generate the zip file name and store it in the cell array
    zipFileName = strcat(modelName, '.zip');
    zipFiles{end + 1} = zipFileName;
    
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