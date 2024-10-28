# TODO add neccesary imports

#include <unordered_map>
% for library in libraries:
#include <${library['name']}.h>
% endfor 

namespace estimation 
{
    class MatlabMath 
    {
        public:

            MatlabMath(bool &construction_failed);

            bool init();

            void update_inputs(model_inputs &inputs, model_parameters &parameters) {
                % for input in iinputs: 
                _inputs.${input['name']} = model_inputs["${input['name']}"];
                % endfor

                % for input in pinputs:
                _inputs.${input['name']} = model_parameters["${input['name']}"];
                % endfor
            }
            
            % for library in libraries:
            ${library['name']}::ExtY_${library['name']}_T evaluate_${library['name']}_estimator(model_inputs &inputs) {
                update_inputs(inputs, parameters);

                ${library['name']}_model.setExternalInputs(&_inputs);
                ${library['name']}_model.step();
                ${library['name']}::ExtY_${library['name']}_T outputs = ${library['name']}_model.getExternalOutputs();

                return outputs;
            };
            % endfor

        private:
            % for library in libraries: 
            ${library['name']}::ExtU_${library['name']} _inputs;
            ${library['name']} ${library['name']}_model;
            % endfor

            % for input in minputs: 
            std::unordered_map<std::string, float> model_inputs = {
                {"${input['name']}", 0.0},
            };
            % endfor

            % for input in pinputs:
            std::unordered_map<std::string, float> model_parameters = {
                {"${input['name']", 0.0}},
            };
        
    }
}