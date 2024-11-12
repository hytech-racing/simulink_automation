#include <unordered_map>
#include <mutex> 
#include "Tire_Model_Codegen.h"
#include <Configurable.hpp>
#include <MatlabModel.hpp>

namespace estimation
{
    class Tire_Model_Codegen_MatlabModel : MatlabModel, core::common::Configurable {

        public:

            struct inputs {
                float InitialTorqReqFL;
                float InitialTorqReqFR;
                float InitialTorqReqRL;
                float InitialTorqReqRR;
                float FL;
                float FR;
                float RL;
                float RR;
                float FL_b;
                float FR_b;
                float RL_g;
                float RR_a;
                float LCFL;
                float LCFR;
                float LCRL;
                float LCRR;
                float MotorRPMFL;
                float MotorRPMFR;
                float MotorRPMRL;
                float MotorRPMRR;
                float Vx_VN;
                float Psi_dot_VNrads;
                float Vy_VN;
            };

            struct parameters {
                float LMUXFL;
                float LMUXFR;
                float LMUXRL;
                float LMUXRR;
                float LMUYFL;
                float LMUYFR;
                float LMUYRL;
                float LMUYRR;
                float Interp_x1_FL;
                float Interp_x2_FL;
                float Interp_x3_FL;
                float interp_y1_FL;
                float interp_y2_FL;
                float interp_y3_FL;
                float Interp_x1_FR;
                float Interp_x2_FR;
                float Interp_x3_FR;
                float interp_y1_FR;
                float interp_y2_FR;
                float interp_y3_FR;
                float Interp_x1_RL;
                float Interp_x2_RL;
                float Interp_x3_RL;
                float interp_y1_RL;
                float interp_y2_RL;
                float interp_y3_RL;
                float Interp_x1_RR;
                float Interp_x2_RR;
                float Interp_x3_RR;
                float interp_y1_RR;
                float interp_y2_RR;
                float interp_y3_RR;
                float SteeringWheelAngleDeg;
                float DriveBiasFront;
                float BrakeBiasFront;
                bool useFakeData;
                float Fake_Vx;
                float fake_psi_dot;
                float integral_gain;
                float psi_dot_gain_slope;
                float psi_dot_gain_intercept;
                float vy_vn_gain_slope;
                float vy_vn_gain_intercept;
                float fake_vy;
                float steering_offset;
                float fake_fz_fl;
                float fake_fz_fr;
                float fake_fz_rl;
                float fake_fz_rr;
                float useTV;
                float max_mech_power_kw;
                float use_power_limit;
            };

            Tire_Model_Codegen_MatlabModel(core::Logger &logger, core::JsonFileHandler &json_file_handler, bool &construction_failed);

            void handle_parameter_updates(const std::unordered_map<std::string, core::common::Configurable::ParamTypes> &new_param_map);

            Tire_Model_Codegen::ExtY_Tire_Model_Codegen_T evaluate_estimator(inputs &new_inputs);

            bool init();

            std::unordered_map<std::string, float> &get_params();

        private: 
            Tire_Model_Codegen::ExtU_Tire_Model_Codegen_T _model_inputs;
            Tire_Model_Codegen Tire_Model_Codegen_model;
            inputs _inputs;
            parameters _parameters;

            std::mutex _parameter_mutex;
    };
}
