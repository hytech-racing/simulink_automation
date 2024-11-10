#include <unordered_map>
#include <"Tire_Model_Codegen.h">

namespace estimation
{
    class Tire_Model_Codegen_MatlabModel : MatlabModel {

        public:

            Tire_Model_Codegen_MatlabModel(bool &construction_failed);

            void handle_parameter_updates();

            Tire_Model_Codegen::ExtY_Tire_Model_Codegen_T evaluate_estimator(inputs &new_inputs) {
                // Update inputs before evaluating estimator

                // Evaluate estimator 
                Tire_Model_Codegen_model.setExternalInputs(&_model_inputs);
                Tire_Model_Codegen_model.step();
                Tire_Model_Codegen::ExtY_Tire_Model_Codegen_T outputs = Tire_Model_Codegen_model.getExternalOutputs();

                return outputs;
            };

            std::unordered_map<std::string, float> &get_params() {
                return parameters;
            }

        private: 
            Tire_Model_Codegen::ExtU_Tire_Model_Codegen _model_inputs;
            Tire_Model_Codegen Tire_Model_Codegen_model;

            std::unordered_map<std::string, float> parameters = 
            {
                {"InitialTorqReqFL", 0.0},
                {"InitialTorqReqFR", 0.0},
                {"InitialTorqReqRL", 0.0},
                {"InitialTorqReqRR", 0.0},
                {"FL", 0.0},
                {"FR", 0.0},
                {"RL", 0.0},
                {"RR", 0.0},
                {"FL_b", 0.0},
                {"FR_b", 0.0},
                {"RL_g", 0.0},
                {"RR_a", 0.0},
                {"LMUXFL", 0.0},
                {"LMUXFR", 0.0},
                {"LMUXRL", 0.0},
                {"LMUXRR", 0.0},
                {"LMUYFL", 0.0},
                {"LMUYFR", 0.0},
                {"LMUYRL", 0.0},
                {"LMUYRR", 0.0},
                {"LCFL", 0.0},
                {"LCFR", 0.0},
                {"LCRL", 0.0},
                {"LCRR", 0.0},
                {"MotorRPMFL", 0.0},
                {"MotorRPMFR", 0.0},
                {"MotorRPMRL", 0.0},
                {"MotorRPMRR", 0.0},
                {"Interp_x1_FL", 0.0},
                {"Interp_x2_FL", 0.0},
                {"Interp_x3_FL", 0.0},
                {"interp_y1_FL", 0.0},
                {"interp_y2_FL", 0.0},
                {"interp_y3_FL", 0.0},
                {"Interp_x1_FR", 0.0},
                {"Interp_x2_FR", 0.0},
                {"Interp_x3_FR", 0.0},
                {"interp_y1_FR", 0.0},
                {"interp_y2_FR", 0.0},
                {"interp_y3_FR", 0.0},
                {"Interp_x1_RL", 0.0},
                {"Interp_x2_RL", 0.0},
                {"Interp_x3_RL", 0.0},
                {"interp_y1_RL", 0.0},
                {"interp_y2_RL", 0.0},
                {"interp_y3_RL", 0.0},
                {"Interp_x1_RR", 0.0},
                {"Interp_x2_RR", 0.0},
                {"Interp_x3_RR", 0.0},
                {"interp_y1_RR", 0.0},
                {"interp_y2_RR", 0.0},
                {"interp_y3_RR", 0.0},
                {"SteeringWheelAngleDeg", 0.0},
                {"Vx_VN", 0.0},
                {"Psi_dot_VNrads", 0.0},
                {"DriveBiasFront", 0.0},
                {"BrakeBiasFront", 0.0},
                {"useFakeData", 0.0},
                {"Fake_Vx", 0.0},
                {"fake_psi_dot", 0.0},
                {"integral_gain", 0.0},
                {"psi_dot_gain_slope", 0.0},
                {"psi_dot_gain_intercept", 0.0},
                {"vy_vn_gain_slope", 0.0},
                {"vy_vn_gain_intercept", 0.0},
                {"fake_vy", 0.0},
                {"Vy_VN", 0.0},
                {"steering_offset", 0.0},
                {"fake_fz_fl", 0.0},
                {"fake_fz_fr", 0.0},
                {"fake_fz_rl", 0.0},
                {"fake_fz_rr", 0.0},
                {"useTV", 0.0},
                {"max_mech_power_kw", 0.0},
                {"use_power_limit", 0.0},
            };

            struct inputs {
            }
    }
}
