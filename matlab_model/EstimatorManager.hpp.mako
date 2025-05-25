#pragma once

#include <vector>
#include <stdexcept>
#include <memory>

#include <google/protobuf/message.h>

#include <VehicleDataTypes.hpp>

#include "EstimatorOutputs.hpp"


% for estim in estimator_names:
#include "${estim}_MatlabModel.hpp"
% endfor

// contains all of the simulink code gen estimators and provides their outputs

namespace matlab_model_gen
{
namespace estimation
{
class EstimatorManager
{
    public:
        EstimatorManager(core::JsonFileHandler &json_file_handler) :
            % for i, estim in enumerate(estimator_names):
            _${estim}_inst(json_file_handler)${',' if i < len(estimator_names) - 1 else ''}
            % endfor
        {}

        EstimatorOutputs_s get_latest_estimation() {
            return _estim;
        }

        void handle_inits() {
            % for estim in estimator_names:
            if(!_${estim}_inst.init())
            {
                throw std::runtime_error("Failed to init ${estim}_MatlabModel estimator");
            }
            % endfor
        }
            
        void set_loggers(std::shared_ptr<core::MsgLogger<std::shared_ptr<google::protobuf::Message>>> message_logger)
        {
            % for estim in estimator_names:
            _${estim}_inst.set_msg_logger(message_logger);
            % endfor
        }

        void evaluate_all_estimators() {
            % for estim in estimator_names:
            _${estim}_inst.evaluate();
            % endfor
        }

    private:
        % for estim in estimator_names:
        ${estim}_MatlabEstimModel _${estim}_inst;
        % endfor
        
        EstimatorOutputs_s _estim = {};
};
}
}
