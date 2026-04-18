#include "${model}.h"
#include "${model}_MatlabModel.hpp"


void estimation::${model}_MatlabEstimModel::handle_parameter_updates(const std::unordered_map<std::string, core::DBParam> &new_param_map) 
{
    % for parameter in parameters:
    if (auto pval = std::get_if<${parameters[parameter]}>(&new_param_map.at("estimator_matlabestimmodel/${parameter}"))) {
        std::unique_lock lk(_parameter_mutex);
        _parameters.${parameter} = *pval;
    }
    % endfor
}

<%!
def to_lower_case(s):
    return s.lower()
%>
std::shared_ptr<${model}_estimation_msgs::${model}_Outports> estimation::${model}_MatlabEstimModel::get_proto_msg(${model}::ExtY_${model}_T res)
{ 
    auto msg = std::make_shared<${model}_estimation_msgs::${model}_Outports>();
    % for outport in outports: 
    msg->set_${to_lower_case(outport)}(res.${outport});
    % endfor
    return msg;
}

estimation::${model}_MatlabEstimModel::${model}_MatlabEstimModel() : MatlabEstimModel() {
    _model_inputs = { };
}

<%!
def format_params_check(params):
    return " && ".join(params)
%>
<%!
def format_parameter_derefencering(parameters):
    parameter_list = []
    for param in parameters.keys(): 
        parameter_list.append(param)
    frm = ""
    for i in range(0, len(parameter_list)):
        if i == len(parameter_list) - 1:
            frm += "*" + parameter_list[i]
        else:
            frm += "*" + parameter_list[i] + ","
    return frm
%>


bool estimation::${model}_MatlabEstimModel::init() {
    % if (len(parameters) > 0):
    
    % for parameter in parameters:
    auto ${parameter} = core::FoxgloveServer::instance().get_param<${parameters[parameter]}>("estimator_matlabestimmodel/${parameter}");
    % endfor
    if (!(${format_params_check(parameters)})) {
        return false;
    }
    {
        std::unique_lock lk(_parameter_mutex);
        _parameters = {
            ${format_parameter_derefencering(parameters)}
        };
        core::FoxgloveServer::instance().register_param_callback(std::bind(&${model}_MatlabEstimModel::handle_parameter_updates, this, std::placeholders::_1));
        return true;
    }
    % else:
    return true;
    % endif
}

void estimation::${model}_MatlabEstimModel::handle_parameter_updates(const std::unordered_map<std::string, core::DBParam>& new_param_map) {
    % if (len(parameters) > 0):
    std::unique_lock lk(_parameter_mutex);

    auto update = [&](const std::string& key, ${parameters[list(parameters.keys())[0]]}& target) {
        if (auto v = get_from_param_map<${parameters[list(parameters.keys())[0]]}>(new_param_map, key)) {
            target = *v;
        }
    };

    % for parameter in parameters:
    update("estimator_matlabestimmodel/${parameter}", _parameters.${parameter});
    % endfor
    % endif
}

${model}::ExtY_${model}_T estimation::${model}_MatlabEstimModel::evaluate_estimator(${model}_inputs &new_inputs) {
    parameters curr_params;
    {
        std::unique_lock lk(_parameter_mutex);
        curr_params = _parameters;
    }

    // Update model inputs before evaluating estimator
    % for input in inputs:
    _model_inputs.${input} = new_inputs.${input};
    % endfor  

    % for parameter in parameters:
    _model_inputs.${parameter} = curr_params.${parameter};
    % endfor

    // Evaluate estimator 
    ${model}_model.setExternalInputs(&_model_inputs);
    ${model}_model.step();
    ${model}::ExtY_${model}_T outputs = ${model}_model.getExternalOutputs();
    auto msg_to_log = get_proto_msg(outputs);

    core::log(msg_to_log); 
    return outputs;
}

estimation::${model}_output_t estimation::${model}_MatlabEstimModel::step_estimator(const core::VehicleState &in)
{
    ${model}_inputs in_data = {};

    <%include file="model_input_include.mako" args="test=True"/>
    
    auto result = evaluate_estimator(in_data);
    
    estimation::${model}_output_t out = {};

    % for outport in outports: 
    out.${outport} = result.${outport};
    % endfor 
    return out;
}


