#pragma once

#include <Controller.hpp>

#include <memory>

% for model_class in model_names:
#include "${model_class}_MatlabModel.hpp";
% endfor

% for model_class in model_names:
#include "${model_class}_estimation_msgs.pb.h"
% endfor


namespace matlab_model_gen
{

std::vector<std::shared_ptr<MatlabModel>> create_controllers(core::JsonFileHandler & conf, std::vector<std::weak_ptr<core::common::Configurable>> & conf_comps)
{
    std::vector<std::shared_ptr<MatlabModel>>, ${model_name_length}> vec;
    % for i, model in enumerate(model_names):
    auto ${model}_controller_inst = std::make_shared<estimation::${model}_MatlabModel>(conf);
    if (!${model}_controller_inst->init()) {
        throw std::runtime_error("Failed to ${model}_MatlabModel controller");
    }
    vec.push_back(${model}_controller_inst);
    conf_comps.push_back(${model}_controller_inst);
    % endfor
    return vec;
}

const size_t num_controllers = ${model_name_length};

std::vector<std::string> get_proto_filenames()
{
    std::vector<std::string> names;
    % for model_class in model_names:
    names.push_back("${model_class}_estimation_msgs.proto");
    % endfor

    return names;
}


}