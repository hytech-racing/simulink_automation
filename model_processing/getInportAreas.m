function inportAreas = getInportAreas(modelName)
    % Load the Simulink model if not already loaded
    if ~bdIsLoaded(modelName)
        load_system(modelName);
    end

    % Find all Inport blocks in the model
    inportBlocks = find_system(modelName, 'SearchDepth',1, 'BlockType', 'Inport');
    
    % Find all annotations (areas) in the model
    annotations = find_system(modelName, 'FindAll', 'on', 'Type', 'Annotation');
    
    % Initialize a structure to hold Inport areas
    inportAreas = struct();

    % Loop through each Inport block
    for i = 1:length(inportBlocks)
        inportPath = inportBlocks{i};
        inportPos = get_param(inportPath, 'Position');
        inportName = get_param(inportPath, 'Name');
        inportArea = '';

        % Check if the Inport is within any annotation boundary
        for j = 1:length(annotations)
            % Get the annotation's position and text
            annotationPos = get_param(annotations(j), 'Position');
            annotationText = get_param(annotations(j), 'Name');

            % Check if the Inport position is within the annotation boundary
            if inportPos(1) >= annotationPos(1) && inportPos(2) >= annotationPos(2) && ...
               inportPos(3) <= annotationPos(3) && inportPos(4) <= annotationPos(4)
                inportArea = annotationText;
                break;
            end
        end

        % Store the Inport name and area in the output structure
        inportAreas(i).InportName = inportName;
        inportAreas(i).InportPath = inportPath;
        inportAreas(i).Area = inportArea;
    end

    % Display the Inport areas (optional)
    disp('Inport Display Areas within the Model:');
    for i = 1:length(inportAreas)
        fprintf('Inport "%s" is in display area "%s"\n', ...
            inportAreas(i).InportName, inportAreas(i).Area);
    end
end