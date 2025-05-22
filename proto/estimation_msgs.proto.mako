syntax = "proto3";
package ${model}_estimation_msgs;

message ${model}_Outports
{
    % for outport in outports: 
    ${render_outport(outports, outport, count)}
    % endfor
}
<%!
def render_outport(outports, outport, count): 
    id = outports[outport]
    data_type = "float" 
    if (id == 2): 
        data_type = "bool"
    count[0] += 1
    return data_type + " " + outport + " = " + str(count[0]) + ";"
%>