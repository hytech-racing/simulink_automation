function [struct_name_w_param_status] = associateInportWithStructMemberNames(codeinfo_var, areas)

ports = codeinfo_var.Inports

struct_name_w_param_status = struct();
for i= 1:length(ports)
    
    inport_graphics_name = ports(i).GraphicalName;
    

    struct_name_w_param_status(i).member_name = ports(i).Implementation.ElementIdentifier;
    
    ind = strcmp({areas.InportName}, inport_graphics_name);
    if (strcmp(areas(ind).Area, 'non-param-inputs'))
        struct_name_w_param_status(i).is_input = true;
    else
        struct_name_w_param_status(i).is_input = false;
    end
end

