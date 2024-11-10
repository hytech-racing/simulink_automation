# TODO add neccesary imports
#include <Tire_Mode_Codegen.h>

namespace estimation 
{
    class MatlabMath 
    {
        public:

            % for input in inputs:
            struct model_inputs {
                real_T ${input};
            }
            % endfor
            
            % for input in model_parameters:
            struct model_parameters {
                ${input['type']} $input['name']};
            }
            % endfor

            MatlabMath(bool &construction_failed);
            bool init();
            ${modelName}::ExtY_${modelName}_T evaluate_estimator(model_inputs &inputs, model_parameters &parameters);



        private:
            ${modelName}::ExtU_${modelName}_T _inputs;
            ${modelName} _model;
        
    }
}