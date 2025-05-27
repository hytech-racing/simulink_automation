#pragma once

#include <vector>
#include <stdexcept>
#include <memory>

#include <google/protobuf/message.h>

#include <VehicleDataTypes.hpp>

#include "EstimatorOutputs.hpp"

#include <Configurable.hpp>
#include <Loggable.hpp>

% for estim in estimator_names:
#include "${estim}_MatlabModel.hpp"
% endfor

// contains all of the simulink code gen estimators and provides their outputs

namespace estimation
{
class EstimatorManager
{
    public:
        EstimatorManager(core::JsonFileHandler &json_file_handler) ${':' if len(estimator_names) >0 else ''}
            % for i, estim in enumerate(estimator_names):
            _${estim}_inst(std::make_shared<::estimation::${estim}_MatlabEstimModel>(json_file_handler))${',' if i < len(estimator_names) - 1 else ''}
            % endfor
        {}

        // called within the controllers to get the POD estimator states
        EstimatorOutputs_s get_latest_estimation() {
            return _estim;
        }
        // NOTE: estimators must be initialized before the controllers
        void handle_inits(std::vector<std::weak_ptr<core::common::Configurable>>& configurable_comps_append) {
            % for estim in estimator_names:

            if(!_${estim}_inst->init())
            {
                throw std::runtime_error("Failed to init ${estim}_MatlabModel estimator");
            }
            configurable_comps_append.push_back(_${estim}_inst);
            % endfor
        }
        
        void set_loggers(std::shared_ptr<core::MsgLogger<std::shared_ptr<google::protobuf::Message>>> message_logger)
        {
            % for estim in estimator_names:
            _${estim}_inst->set_msg_logger(message_logger);
            % endfor
        }

        // gets called in drivebrain app before controllers
        void evaluate_all_estimators(const core::VehicleState &in) {
            _estim = {};
            % for estim, outputs in model_output_dict.items():
            auto ${estim}_res = _${estim}_inst->step_estimator(in);
            % for field in outputs:
                _estim.${estim}_${field} = ${estim}_res.${field}; 
            % endfor
            % endfor
        }

    private:
        % for estim in estimator_names:
        std::shared_ptr<::estimation::${estim}_MatlabEstimModel> _${estim}_inst;
        % endfor
        
        EstimatorOutputs_s _estim = {};
};
}

