#include <unordered_map>
#include <mutex> 
#include "${model}.h"
#include <Configurable.hpp>

namespace estimation
{
    class ${model}_MatlabModel : MatlabModel, Configurable {

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

        private: 
            ${model}::ExtU_${model} _model_inputs;
            ${model} ${model}_model;
            inputs _inputs;
            parameters _parameters;

            std::mutex _parameter_mutex;
    }
}