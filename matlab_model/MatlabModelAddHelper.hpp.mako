#pragma once

#include <Controller.hpp>

#include <memory>
#include <vector>
#include <string>
#include <stdexcept>
	

% for model_class in all_model_names:
#include "${model_class}_MatlabModel.hpp"
% endfor

% for model_class in all_model_names:
#include "${model_class}_estimation_msgs.pb.h"
% endfor


namespace matlab_model_gen
{

std::vector<std::shared_ptr<MatlabModel>> create_controllers(core::JsonFileHandler & conf, std::vector<std::weak_ptr<core::common::Configurable>> & conf_comps, std::shared_ptr<estimation::EstimatorManager> estim_manager)
{
    std::vector<std::shared_ptr<MatlabModel>> vec{};
    % for i, model in enumerate(controller_model_names):
    auto ${model}_controller_inst = std::make_shared<estimation::${model}_MatlabModel>(conf, estim_manager);
    if (!${model}_controller_inst->init()) {
        throw std::runtime_error("Failed to ${model}_MatlabModel controller");
    }
    vec.push_back(${model}_controller_inst);
    conf_comps.push_back(${model}_controller_inst);
    % endfor
    return vec;
}

const size_t num_controllers = ${num_controller_models};

std::vector<std::string> get_proto_filenames()
{
    std::vector<std::string> names;
    % for model_class in all_model_names:
    names.push_back("${model_class}_estimation_msgs.proto");
    % endfor

    return names;
}


}