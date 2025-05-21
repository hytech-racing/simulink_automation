function [struct_inport_name_w_param_status, struct_outport_name] = associateInportWithStructMemberNames(codeinfo_var, areas)

inports = codeinfo_var.Inports;

% Handle inports
struct_inport_name_w_param_status = struct();
for i= 1:length(inports)
    
    inport_graphics_name = inports(i).GraphicalName;

    struct_inport_name_w_param_status(i).member_name = inports(i).Implementation.ElementIdentifier;
    
    ind = find(strcmp({areas.InportName}, inport_graphics_name));
    if (strcmp(areas(ind).Area, 'non-param-inputs'))
        struct_inport_name_w_param_status(i).is_input = true;
    else
        struct_inport_name_w_param_status(i).is_input = false;
    end

    if (strcmp(areas(ind).Area, 'is-bool'))
        struct_inport_name_w_param_status(i).is_bool = true;
    else
        struct_inport_name_w_param_status(i).is_bool = false;
    end
    
end

% Handle outports
struct_outport_name = struct();
outports = codeinfo_var.Outports; 

for i=1:length(outports)

    struct_outport_name(i).member_name = outports(i).Implementation.ElementIdentifier;

end

