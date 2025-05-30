#include "${model}.h"
#include "${model}_MatlabModel.hpp"

void estimation::${model}_MatlabModel::handle_parameter_updates(const std::unordered_map<std::string, core::common::Configurable::ParamTypes> &new_param_map) 
{
    % for parameter in parameters:
    if (auto pval = std::get_if<${parameters[parameter]}>(&new_param_map.at("${parameter}"))) {
        std::unique_lock lk(_parameter_mutex);
        _parameters.${parameter} = *pval;
    }
    % endfor
}

<%!
def to_lower_case(s):
    return s.lower()
%>
std::shared_ptr<${model}_estimation_msgs::${model}_Outports> estimation::${model}_MatlabModel::get_proto_msg(${model}::ExtY_${model}_T res)
{ 
    auto msg = std::make_shared<${model}_estimation_msgs::${model}_Outports>();
    % for outport in outports: 
    msg->set_${to_lower_case(outport)}(res.${outport});
    % endfor
    return msg;
}


estimation::${model}_MatlabModel::${model}_MatlabModel(core::JsonFileHandler &json_file_handler, std::shared_ptr<estimation::EstimatorManager> estim_manager) : MatlabModel(json_file_handler, "${model}_MatlabModel"), _estim_manager(estim_manager) {
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
bool estimation::${model}_MatlabModel::init() {
    
    if(!_estim_manager)
    {
        return false;
    }

    % if (len(parameters) > 0):
    
    % for parameter in parameters:
    auto ${parameter} = get_live_parameter<${parameters[parameter]}>("${parameter}");
    % endfor

    if (!(${format_params_check(parameters)})) 
    {
        return false;
    }

    {
        std::unique_lock lk(_parameter_mutex);
        _parameters = {
            ${format_parameter_derefencering(parameters)}
        };
        param_update_handler_sig.connect(boost::bind(&${model}_MatlabModel::handle_parameter_updates, this, std::placeholders::_1));
        set_configured();
        return true;
    }
    % else:
    set_configured();
    return true;
    % endif

}

${model}::ExtY_${model}_T estimation::${model}_MatlabModel::evaluate_estimator(${model}_inputs &new_inputs) {
    parameters curr_params;
    {
        std::unique_lock lk(_parameter_mutex);
        curr_params = _parameters;
    }

    // Update model inputs before evaluating estimator
    % for input in inputs:
    _model_inputs.${input} = new_inputs.${input};
    % endfor  

    % for estim_in in estim_outputs:
    _model_inputs.${estim_in} = new_inputs.${estim_in};
    % endfor

    % for parameter in parameters:
    _model_inputs.${parameter} = curr_params.${parameter};
    % endfor

    // Evaluate estimator 
    ${model}_model.setExternalInputs(&_model_inputs);
    ${model}_model.step();
    ${model}::ExtY_${model}_T outputs = ${model}_model.getExternalOutputs();
    auto msg_to_log = get_proto_msg(outputs);

    this->log(msg_to_log); // from base Loggable
    return outputs;
}

core::ControllerOutput estimation::${model}_MatlabModel::step_controller(const core::VehicleState &in)
{
    ${model}_inputs in_data = {};

    EstimatorOutputs_s estimator_outputs = {};
    if(_estim_manager)
    {
        estimator_outputs = _estim_manager->get_latest_estimation();
    }
    
    <%include file="model_input_include.mako"/>
    
    core::SpeedControlOut type_set = {};
    core::ControllerOutput cmd_out = {};
    cmd_out.out = type_set;
    auto& speed_out = std::get<core::SpeedControlOut>(cmd_out.out);
    speed_out = {};

    auto result = evaluate_estimator(in_data);

    speed_out.desired_rpms.FL = result.speed_setpoint_FL;
    speed_out.desired_rpms.FR = result.speed_setpoint_FR;
    speed_out.desired_rpms.RL = result.speed_setpoint_RL;
    speed_out.desired_rpms.RR = result.speed_setpoint_RR;
    speed_out.torque_lim_nm.FL = result.torq_FL;
    speed_out.torque_lim_nm.FR = result.torq_FR;
    speed_out.torque_lim_nm.RL = result.torq_RL;
    speed_out.torque_lim_nm.RR = result.torq_RR;

    cmd_out.out = speed_out;

    return cmd_out;
}


