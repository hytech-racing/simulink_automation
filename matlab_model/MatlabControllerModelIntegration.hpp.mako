#ifndef __${model.upper()}_MATLABMODEL_H__
#define __${model.upper()}_MATLABMODEL_H__

// stuff from drivebrain_core

#include <VehicleDataTypes.hpp>

#include <google/protobuf/message.h>

#include <unordered_map>
#include <mutex> 
#include <memory>

#include "${model}.h"
#include "${model}_estimation_msgs.pb.h"

#include "EstimatorOutputs.hpp"
#include "EstimatorManager.hpp"

#include <MatlabModel.hpp>


namespace estimation
{
    struct ${model}_inputs {
        % for input in inputs:
        float ${input};
        % endfor
        % for in_estim in estim_outputs:
        float ${in_estim};
        % endfor
    };

    class ${model}_MatlabModel : public MatlabModel {

        public:

            struct parameters {
                % for parameter in parameters:
                ${parameters[parameter]} ${parameter};
                % endfor
            };
            bool init() override final;

            ${model}_MatlabModel(core::JsonFileHandler &json_file_handler, std::shared_ptr<estimation::EstimatorManager> estim_manager);

            void handle_parameter_updates(const std::unordered_map<std::string, core::common::Configurable::ParamTypes> &new_param_map);

            std::shared_ptr<${model}_estimation_msgs::${model}_Outports> get_proto_msg(${model}::ExtY_${model}_T res);

            ${model}::ExtY_${model}_T evaluate_estimator(${model}_inputs &new_inputs);


            core::ControllerOutput step_controller(const core::VehicleState &in) override final;

            EstimatorOutputs_s get_latest_estimator_outputs();
        private: 
            ${model}::ExtU_${model}_T _model_inputs;
            ${model} ${model}_model;
            
            std::shared_ptr<EstimatorManager> _estim_manager = nullptr;
            
            parameters _parameters;

            std::mutex _parameter_mutex;
            std::mutex _input_mutex;
    };
}

#endif