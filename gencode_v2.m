% List of model names to build
rootFolder = pwd;  % Get the current folder
addpath(genpath(rootFolder));  % Add all sub-folders

% HT09_Vehicle_Parameters;
load_params;

fname = 'models.json'; 
fid = fopen(fname); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
models_json = jsondecode(str);


% load the standard codegen config
load('hytech_codegen_config.mat', 'hytech_codegen_config');

controllers = models_json.controllers;

% Cell array to store the generated zip file names
zipFiles = {};
% Loop over each model
for i = 1:length(controllers)
    modelName = controllers{i}; % Get the model name from the list
    
    fprintf('Building model: %s\n', modelName); % Display progress
    
    % Load the Simulink model
    load_system(modelName);
    
    % Remove any existing config set with the same name as the standard
    % codegen config
    
    % Attach and activate it on the target model
    %activeConfig = getActiveConfigSet(modelName);
    %detachConfigSet(modelName, activeConfig.Name);
    attachConfigSet(modelName, Configuration);  % true = make it active
    setActiveConfigSet(modelName, 'hytech_codegen_config');


    fprintf('attached config');

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
    [inports_struct, outports_struct] = associateInportWithStructMemberNames(codeInfo.codeInfo, areas);

    inportInfoJsonName = strcat(modelName, '_inport_info.json');
    ifid = fopen(inportInfoJsonName, 'w');

    if ifid == -1
        error('Cannot create Inport Info JSON');
    end

    % Write inports to json
    fprintf(ifid, '{\n');
    fprintf(ifid, '   "inports" : {\n');
    for i=1:length(inports_struct)

        id = 0;
        if inports_struct(i).is_input
            id = 1;
        end

        if inports_struct(i).is_bool
            id = 2;
        end

        if i == length(inports_struct)
            fprintf(ifid, '      "%s": %d\n', inports_struct(i).member_name, id);
        else 
            fprintf(ifid, '      "%s": %d,\n', inports_struct(i).member_name, id);
        end
    end 
    fprintf(ifid, "   },\n");

    % Write outports to json
    fprintf(ifid, '   "outports" : {\n');
    for i = 1:length(outports_struct)
        if i == length(outports_struct)
            fprintf(ifid, '      "%s": %d\n', outports_struct(i).member_name, 0);
        else 
            fprintf(ifid, '      "%s": %d,\n', outports_struct(i).member_name, 0);
        end
    end
    fprintf(ifid, '   }\n');

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