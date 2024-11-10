#include <unordered_map>
#include "${model}.h"

namespace estimation
{
    class ${model}_MatlabModel : MatlabModel {

        public:

            ${model}_MatlabModel(bool &construction_failed);

            void handle_parameter_updates();

            ${model}::ExtY_${model}_T evaluate_estimator(inputs &new_inputs) {
                // Update inputs before evaluating estimator
                % for input in inputs:
                inputs.${input} = new_inputs.${input};
                % endfor  

                // Evaluate estimator 
                ${model}_model.setExternalInputs(&_model_inputs);
                ${model}_model.step();
                ${model}::ExtY_${model}_T outputs = ${model}_model.getExternalOutputs();

                return outputs;
            };

            std::unordered_map<std::string, float> &get_params() {
                return parameters;
            }

        private: 
            ${model}::ExtU_${model} _model_inputs;
            ${model} ${model}_model;

            std::unordered_map<std::string, float> parameters = 
            {
                % for parameter in parameters:
                {"${parameter}", 0.0},
                % endfor
            };

            struct inputs {
                % for input in inputs:
                float ${input};
                % endfor
            }
    }
}
