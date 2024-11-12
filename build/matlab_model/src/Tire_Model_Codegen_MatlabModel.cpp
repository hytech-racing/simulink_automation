#include "Tire_Model_Codegen.h"
#include "Tire_Model_Codegen_MatlabModel.hpp"


    void estimation::Tire_Model_Codegen_MatlabModel::handle_parameter_updates(const std::unordered_map<std::string, core::common::Configurable::ParamTypes> &new_param_map) 
    {
        if (auto pval = std::get_if<float>(&new_param_map.at("LMUXFL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.LMUXFL = *pval;
            std::cout << "Setting new LMUXFL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("LMUXFR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.LMUXFR = *pval;
            std::cout << "Setting new LMUXFR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("LMUXRL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.LMUXRL = *pval;
            std::cout << "Setting new LMUXRL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("LMUXRR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.LMUXRR = *pval;
            std::cout << "Setting new LMUXRR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("LMUYFL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.LMUYFL = *pval;
            std::cout << "Setting new LMUYFL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("LMUYFR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.LMUYFR = *pval;
            std::cout << "Setting new LMUYFR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("LMUYRL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.LMUYRL = *pval;
            std::cout << "Setting new LMUYRL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("LMUYRR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.LMUYRR = *pval;
            std::cout << "Setting new LMUYRR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x1_FL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x1_FL = *pval;
            std::cout << "Setting new Interp_x1_FL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x2_FL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x2_FL = *pval;
            std::cout << "Setting new Interp_x2_FL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x3_FL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x3_FL = *pval;
            std::cout << "Setting new Interp_x3_FL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y1_FL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y1_FL = *pval;
            std::cout << "Setting new interp_y1_FL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y2_FL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y2_FL = *pval;
            std::cout << "Setting new interp_y2_FL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y3_FL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y3_FL = *pval;
            std::cout << "Setting new interp_y3_FL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x1_FR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x1_FR = *pval;
            std::cout << "Setting new Interp_x1_FR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x2_FR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x2_FR = *pval;
            std::cout << "Setting new Interp_x2_FR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x3_FR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x3_FR = *pval;
            std::cout << "Setting new Interp_x3_FR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y1_FR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y1_FR = *pval;
            std::cout << "Setting new interp_y1_FR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y2_FR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y2_FR = *pval;
            std::cout << "Setting new interp_y2_FR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y3_FR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y3_FR = *pval;
            std::cout << "Setting new interp_y3_FR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x1_RL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x1_RL = *pval;
            std::cout << "Setting new Interp_x1_RL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x2_RL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x2_RL = *pval;
            std::cout << "Setting new Interp_x2_RL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x3_RL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x3_RL = *pval;
            std::cout << "Setting new Interp_x3_RL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y1_RL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y1_RL = *pval;
            std::cout << "Setting new interp_y1_RL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y2_RL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y2_RL = *pval;
            std::cout << "Setting new interp_y2_RL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y3_RL"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y3_RL = *pval;
            std::cout << "Setting new interp_y3_RL" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x1_RR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x1_RR = *pval;
            std::cout << "Setting new Interp_x1_RR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x2_RR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x2_RR = *pval;
            std::cout << "Setting new Interp_x2_RR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Interp_x3_RR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Interp_x3_RR = *pval;
            std::cout << "Setting new Interp_x3_RR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y1_RR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y1_RR = *pval;
            std::cout << "Setting new interp_y1_RR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y2_RR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y2_RR = *pval;
            std::cout << "Setting new interp_y2_RR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("interp_y3_RR"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.interp_y3_RR = *pval;
            std::cout << "Setting new interp_y3_RR" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("SteeringWheelAngleDeg"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.SteeringWheelAngleDeg = *pval;
            std::cout << "Setting new SteeringWheelAngleDeg" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("DriveBiasFront"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.DriveBiasFront = *pval;
            std::cout << "Setting new DriveBiasFront" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("BrakeBiasFront"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.BrakeBiasFront = *pval;
            std::cout << "Setting new BrakeBiasFront" << std::endl;
        }
        if (auto pval = std::get_if<bool>(&new_param_map.at("useFakeData"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.useFakeData = *pval;
            std::cout << "Setting new useFakeData" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("Fake_Vx"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.Fake_Vx = *pval;
            std::cout << "Setting new Fake_Vx" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("fake_psi_dot"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.fake_psi_dot = *pval;
            std::cout << "Setting new fake_psi_dot" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("integral_gain"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.integral_gain = *pval;
            std::cout << "Setting new integral_gain" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("psi_dot_gain_slope"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.psi_dot_gain_slope = *pval;
            std::cout << "Setting new psi_dot_gain_slope" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("psi_dot_gain_intercept"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.psi_dot_gain_intercept = *pval;
            std::cout << "Setting new psi_dot_gain_intercept" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("vy_vn_gain_slope"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.vy_vn_gain_slope = *pval;
            std::cout << "Setting new vy_vn_gain_slope" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("vy_vn_gain_intercept"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.vy_vn_gain_intercept = *pval;
            std::cout << "Setting new vy_vn_gain_intercept" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("fake_vy"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.fake_vy = *pval;
            std::cout << "Setting new fake_vy" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("steering_offset"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.steering_offset = *pval;
            std::cout << "Setting new steering_offset" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("fake_fz_fl"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.fake_fz_fl = *pval;
            std::cout << "Setting new fake_fz_fl" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("fake_fz_fr"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.fake_fz_fr = *pval;
            std::cout << "Setting new fake_fz_fr" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("fake_fz_rl"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.fake_fz_rl = *pval;
            std::cout << "Setting new fake_fz_rl" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("fake_fz_rr"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.fake_fz_rr = *pval;
            std::cout << "Setting new fake_fz_rr" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("useTV"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.useTV = *pval;
            std::cout << "Setting new useTV" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("max_mech_power_kw"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.max_mech_power_kw = *pval;
            std::cout << "Setting new max_mech_power_kw" << std::endl;
        }
        if (auto pval = std::get_if<float>(&new_param_map.at("use_power_limit"))) {
            std::unique_lock lk(_parameter_mutex);
            _parameters.use_power_limit = *pval;
            std::cout << "Setting new use_power_limit" << std::endl;
        }
    }


    estimation::Tire_Model_Codegen_MatlabModel::Tire_Model_Codegen_MatlabModel() : Configurable(logger, json_file_handler, "Tire_Model_Codegen_MatlabModel") {
        construction_failed = !init();
        _inputs = { }
    }
    
    bool estimation::Tire_Model_Codegen_MatlabModel::init() {
        auto LMUXFL = get_parameter_value<float>("LMUXFL");
        auto LMUXFR = get_parameter_value<float>("LMUXFR");
        auto LMUXRL = get_parameter_value<float>("LMUXRL");
        auto LMUXRR = get_parameter_value<float>("LMUXRR");
        auto LMUYFL = get_parameter_value<float>("LMUYFL");
        auto LMUYFR = get_parameter_value<float>("LMUYFR");
        auto LMUYRL = get_parameter_value<float>("LMUYRL");
        auto LMUYRR = get_parameter_value<float>("LMUYRR");
        auto Interp_x1_FL = get_parameter_value<float>("Interp_x1_FL");
        auto Interp_x2_FL = get_parameter_value<float>("Interp_x2_FL");
        auto Interp_x3_FL = get_parameter_value<float>("Interp_x3_FL");
        auto interp_y1_FL = get_parameter_value<float>("interp_y1_FL");
        auto interp_y2_FL = get_parameter_value<float>("interp_y2_FL");
        auto interp_y3_FL = get_parameter_value<float>("interp_y3_FL");
        auto Interp_x1_FR = get_parameter_value<float>("Interp_x1_FR");
        auto Interp_x2_FR = get_parameter_value<float>("Interp_x2_FR");
        auto Interp_x3_FR = get_parameter_value<float>("Interp_x3_FR");
        auto interp_y1_FR = get_parameter_value<float>("interp_y1_FR");
        auto interp_y2_FR = get_parameter_value<float>("interp_y2_FR");
        auto interp_y3_FR = get_parameter_value<float>("interp_y3_FR");
        auto Interp_x1_RL = get_parameter_value<float>("Interp_x1_RL");
        auto Interp_x2_RL = get_parameter_value<float>("Interp_x2_RL");
        auto Interp_x3_RL = get_parameter_value<float>("Interp_x3_RL");
        auto interp_y1_RL = get_parameter_value<float>("interp_y1_RL");
        auto interp_y2_RL = get_parameter_value<float>("interp_y2_RL");
        auto interp_y3_RL = get_parameter_value<float>("interp_y3_RL");
        auto Interp_x1_RR = get_parameter_value<float>("Interp_x1_RR");
        auto Interp_x2_RR = get_parameter_value<float>("Interp_x2_RR");
        auto Interp_x3_RR = get_parameter_value<float>("Interp_x3_RR");
        auto interp_y1_RR = get_parameter_value<float>("interp_y1_RR");
        auto interp_y2_RR = get_parameter_value<float>("interp_y2_RR");
        auto interp_y3_RR = get_parameter_value<float>("interp_y3_RR");
        auto SteeringWheelAngleDeg = get_parameter_value<float>("SteeringWheelAngleDeg");
        auto DriveBiasFront = get_parameter_value<float>("DriveBiasFront");
        auto BrakeBiasFront = get_parameter_value<float>("BrakeBiasFront");
        auto useFakeData = get_parameter_value<bool>("useFakeData");
        auto Fake_Vx = get_parameter_value<float>("Fake_Vx");
        auto fake_psi_dot = get_parameter_value<float>("fake_psi_dot");
        auto integral_gain = get_parameter_value<float>("integral_gain");
        auto psi_dot_gain_slope = get_parameter_value<float>("psi_dot_gain_slope");
        auto psi_dot_gain_intercept = get_parameter_value<float>("psi_dot_gain_intercept");
        auto vy_vn_gain_slope = get_parameter_value<float>("vy_vn_gain_slope");
        auto vy_vn_gain_intercept = get_parameter_value<float>("vy_vn_gain_intercept");
        auto fake_vy = get_parameter_value<float>("fake_vy");
        auto steering_offset = get_parameter_value<float>("steering_offset");
        auto fake_fz_fl = get_parameter_value<float>("fake_fz_fl");
        auto fake_fz_fr = get_parameter_value<float>("fake_fz_fr");
        auto fake_fz_rl = get_parameter_value<float>("fake_fz_rl");
        auto fake_fz_rr = get_parameter_value<float>("fake_fz_rr");
        auto useTV = get_parameter_value<float>("useTV");
        auto max_mech_power_kw = get_parameter_value<float>("max_mech_power_kw");
        auto use_power_limit = get_parameter_value<float>("use_power_limit");

        if (!(LMUXFL && LMUXFR && LMUXRL && LMUXRR && LMUYFL && LMUYFR && LMUYRL && LMUYRR && Interp_x1_FL && Interp_x2_FL && Interp_x3_FL && interp_y1_FL && interp_y2_FL && interp_y3_FL && Interp_x1_FR && Interp_x2_FR && Interp_x3_FR && interp_y1_FR && interp_y2_FR && interp_y3_FR && Interp_x1_RL && Interp_x2_RL && Interp_x3_RL && interp_y1_RL && interp_y2_RL && interp_y3_RL && Interp_x1_RR && Interp_x2_RR && Interp_x3_RR && interp_y1_RR && interp_y2_RR && interp_y3_RR && SteeringWheelAngleDeg && DriveBiasFront && BrakeBiasFront && useFakeData && Fake_Vx && fake_psi_dot && integral_gain && psi_dot_gain_slope && psi_dot_gain_intercept && vy_vn_gain_slope && vy_vn_gain_intercept && fake_vy && steering_offset && fake_fz_fl && fake_fz_fr && fake_fz_rl && fake_fz_rr && useTV && max_mech_power_kw && use_power_limit)) 
        {
            return false;
        }

        {
            std::unique_lock lk(_parameter_mutex)
            _parameters = {
                *LMUXFL
                *LMUXFR
                *LMUXRL
                *LMUXRR
                *LMUYFL
                *LMUYFR
                *LMUYRL
                *LMUYRR
                *Interp_x1_FL
                *Interp_x2_FL
                *Interp_x3_FL
                *interp_y1_FL
                *interp_y2_FL
                *interp_y3_FL
                *Interp_x1_FR
                *Interp_x2_FR
                *Interp_x3_FR
                *interp_y1_FR
                *interp_y2_FR
                *interp_y3_FR
                *Interp_x1_RL
                *Interp_x2_RL
                *Interp_x3_RL
                *interp_y1_RL
                *interp_y2_RL
                *interp_y3_RL
                *Interp_x1_RR
                *Interp_x2_RR
                *Interp_x3_RR
                *interp_y1_RR
                *interp_y2_RR
                *interp_y3_RR
                *SteeringWheelAngleDeg
                *DriveBiasFront
                *BrakeBiasFront
                *useFakeData
                *Fake_Vx
                *fake_psi_dot
                *integral_gain
                *psi_dot_gain_slope
                *psi_dot_gain_intercept
                *vy_vn_gain_slope
                *vy_vn_gain_intercept
                *fake_vy
                *steering_offset
                *fake_fz_fl
                *fake_fz_fr
                *fake_fz_rl
                *fake_fz_rr
                *useTV
                *max_mech_power_kw
                *use_power_limit
            }
            param_update_handler_sig.connect(boost::bind(&MatlabMath::_handle_param_updates, this, std::placeholders::_1));

            return true;
        }

    }

    estimation::Tire_Model_Codegen::ExtY_Tire_Model_Codegen_T Tire_Model_Codegen_MatlabModel::evaluate_estimator(inputs &new_inputs) {
        // Update inputs before evaluating estimator
        _inputs.InitialTorqReqFL = new_inputs.InitialTorqReqFL;
        _inputs.InitialTorqReqFR = new_inputs.InitialTorqReqFR;
        _inputs.InitialTorqReqRL = new_inputs.InitialTorqReqRL;
        _inputs.InitialTorqReqRR = new_inputs.InitialTorqReqRR;
        _inputs.FL = new_inputs.FL;
        _inputs.FR = new_inputs.FR;
        _inputs.RL = new_inputs.RL;
        _inputs.RR = new_inputs.RR;
        _inputs.FL_b = new_inputs.FL_b;
        _inputs.FR_b = new_inputs.FR_b;
        _inputs.RL_g = new_inputs.RL_g;
        _inputs.RR_a = new_inputs.RR_a;
        _inputs.LCFL = new_inputs.LCFL;
        _inputs.LCFR = new_inputs.LCFR;
        _inputs.LCRL = new_inputs.LCRL;
        _inputs.LCRR = new_inputs.LCRR;
        _inputs.MotorRPMFL = new_inputs.MotorRPMFL;
        _inputs.MotorRPMFR = new_inputs.MotorRPMFR;
        _inputs.MotorRPMRL = new_inputs.MotorRPMRL;
        _inputs.MotorRPMRR = new_inputs.MotorRPMRR;
        _inputs.Vx_VN = new_inputs.Vx_VN;
        _inputs.Psi_dot_VNrads = new_inputs.Psi_dot_VNrads;
        _inputs.Vy_VN = new_inputs.Vy_VN;

        // Evaluate estimator 
        Tire_Model_Codegen_model.setExternalInputs(&_model_inputs);
        Tire_Model_Codegen_model.step();
        Tire_Model_Codegen::ExtY_Tire_Model_Codegen_T outputs = Tire_Model_Codegen_model.getExternalOutputs();

        return outputs;
    }
