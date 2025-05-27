function [zipFileName] = buildModel(modelName, Config)
%BUILDMODEL Summary of this function goes here
%   Detailed explanation goes here

    fprintf('Building model: %s\n', modelName); % Display progress
    
    % Load the Simulink model
    load_system(modelName);
    
    % Remove any existing config set with the same name as the standard
    % codegen config
    
    % Attach and activate it on the target model
    activeConfig = getActiveConfigSet(modelName);
    activeConfig.Name
    if(~strcmp(activeConfig.Name, 'hytech_codegen_config_r2'))

        attachConfigSet(modelName, Config);  % true = make it active
        setActiveConfigSet(modelName, 'hytech_codegen_config_r2');
        
        
        fprintf('attached config');

    end

    
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

        if inports_struct(i).is_estim_out
            id = 3;
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
    zipFileName = strcat(modelName, '.zip');
end

