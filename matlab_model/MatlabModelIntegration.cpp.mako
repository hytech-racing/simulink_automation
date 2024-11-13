#include "${model}.h"
#include "${model}_MatlabModel.hpp"

void estimation::${model}_MatlabModel::handle_parameter_updates(const std::unordered_map<std::string, core::common::Configurable::ParamTypes> &new_param_map) 
{
    % for parameter in parameters:
    if (auto pval = std::get_if<${parameters[parameter]}>(&new_param_map.at("${parameter}"))) {
        std::unique_lock lk(_parameter_mutex);
        _parameters.${parameter} = *pval;
        std::cout << "Setting new ${parameter}" << std::endl;
    }
    % endfor
}

estimation::${model}_MatlabModel::${model}_MatlabModel(core::Logger &logger, core::JsonFileHandler &json_file_handler, bool &construction_failed) : Configurable(logger, json_file_handler, "${model}_MatlabModel") {
    construction_failed = !init();
    _inputs = { };
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
    % for parameter in parameters:
    auto ${parameter} = get_parameter_value<${parameters[parameter]}>("${parameter}");
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

        return true;
    }

}

${model}::ExtY_Tire_Model_Codegen_T estimation::${model}_MatlabModel::evaluate_estimator(inputs &new_inputs) {
    // Update inputs before evaluating estimator
    % for input in inputs:
    _inputs.${input} = new_inputs.${input};
    % endfor  

    // Evaluate estimator 
    ${model}_model.setExternalInputs(&_model_inputs);
    ${model}_model.step();
    ${model}::ExtY_${model}_T outputs = ${model}_model.getExternalOutputs();

    return outputs;
}

#endif


