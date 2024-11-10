% List of model names to build
rootFolder = pwd;  % Get the current folder
addpath(genpath(rootFolder));  % Add all sub-folders

HT09_Vehicle_Parameters;

modelList = {'Tire_Model_Codegen'}; 
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
    codeInfoPath = fullfile(pwd, [modelName, '_ert_rtw', filesep, 'codeInfo.mat']); % Adjust the path as needed

    if exist(codeInfoPath, 'file')
        codeInfo = load(codeInfoPath);
        disp('codeInfo.mat loaded successfully.');
    
        % Display the contents of codeInfo for verification
        disp(codeInfo);
    end

    % Write inport information to zip file
    areas = getInportAreas(modelName);
    res = associateInportWithStructMemberNames(codeInfo.codeInfo, areas);

    inportInfoJsonName = strcat(modelName, '_inport_info.json');
    ifid = fopen(inportInfoJsonName, 'w');

    if ifid == -1
        error('Cannot create Inport Info JSON');
    end

    fprintf(ifid, '{\n');

    for i=1:length(res)

        id = 0;
        if res(i).is_input
            id = 1;
        end

        if res(i).is_bool
            id = 2;
        end

        if i == length(res)
            fprintf(ifid, '   "%s": %d\n', res(i).member_name, id);
        else 
            fprintf(ifid, '   "%s": %d,\n', res(i).member_name, id);
        end
    end 
    fprintf(ifid, '}\n');

    fclose(ifid);


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