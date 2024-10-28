# TODO add neccesary imports
#include <Tire_Mode_Codegen.h>

namespace estimation 
{
    class MatlabMath 
    {
        public:

            % for input in model_inputs:
            struct model_inputs {
                ${input['type']} ${input['name']};
            }
            % endfor
            
            % for input in model_parameters:
            struct model_parameters {
                ${input['type']} $input['name']};
            }
            % endfor

            MatlabMath(bool &construction_failed);
            bool init();
            Tire_Model_Codegen::ExtY_Tire_Model_Codegen_T evaluate_estimator(model_inputs &inputs, model_parameters &parameters);

        private:
            Tire_Model_Codegen::ExtU_Tire_Model_Codegen_T _inputs;
            Tire_Model_Codegen _model;
        
    }
}