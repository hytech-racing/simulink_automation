#include "${model}.h"
#include "${model}_MatlabModel.hpp"

namespace estimation {

    ${model}_MatlabModel::handle_parameter_updates(const std::unordered_map<std::string, core::common::Configurable::ParamTypes> &new_param_map) 
    {
        % for parameter in parameters:
        if (auto pval = std::get_if<${parameters[parameter]}>(&new_param_map.at("${parameter}"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.${parameter} = *pval;
            std::cout << "Setting new ${parameter}" << std::endl;
        }
        % endfor
    }

    ${model}_MatlabModel::${model}_MatlabModel() : Configurable(logger, json_file_handler, "${model}_MatlabModel") {
        construction_failed = !init();
        _inputs = { }
    }
    <%!
    def format_params_check(params):
        return " && ".join(params)
    %>
    bool ${model}_MatlabModel::init(bool &construction_failed) {
        % for parameter in parameters:
        auto ${parameter} = get_parameter_value<${parameters[parameter]}>("${parameter}");
        % endfor

        if (!(${format_params_check(parameters)})) 
        {
            return false;
        }

        {
            std::unique_lock lk(_parameter_mutex)
            _parameters = {
                % for parameter in parameters:
                *${parameter}
                % endfor
            }
            param_update_handler_sig.connect(boost::bind(&MatlabMath::_handle_param_updates, this, std::placeholders::_1));

            return true;
        }

    }

    ${model}::ExtY_Tire_Model_Codegen_T ${model}_MatlabModel::evaluate_estimator(inputs &new_inputs) {
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

}
