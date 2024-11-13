#ifndef __${model.upper()}_MATLABMODEL_H__
#define __${model.upper()}_MATLABMODEL_H__

#include <unordered_map>
#include <mutex> 
#include "${model}.h"
#include <Configurable.hpp>
#include <MatlabModel.hpp>

namespace estimation
{
    class ${model}_MatlabModel : MatlabModel, core::common::Configurable {

        public:

            struct inputs {
                % for input in inputs:
                float ${input};
                % endfor
            };

            struct parameters {
                % for parameter in parameters:
                ${parameters[parameter]} ${parameter};
                % endfor
            };

            ${model}_MatlabModel(core::Logger &logger, core::JsonFileHandler &json_file_handler, bool &construction_failed);

            void handle_parameter_updates(const std::unordered_map<std::string, core::common::Configurable::ParamTypes> &new_param_map);

            ${model}::ExtY_Tire_Model_Codegen_T evaluate_estimator(inputs &new_inputs);

            bool init();

            std::unordered_map<std::string, float> &get_params();

        private: 
            ${model}::ExtU_${model}_T _model_inputs;
            ${model} ${model}_model;
            inputs _inputs;
            parameters _parameters;

            std::mutex _parameter_mutex;
    };
}

#endif