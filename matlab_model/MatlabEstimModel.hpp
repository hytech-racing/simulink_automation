#ifndef __MATLABESTIMMODEL_H__
#define __MATLABESTIMMODEL_H__
#include <VehicleDataTypes.hpp>
#include <Configurable.hpp>
#include <Loggable.hpp>

#include <google/protobuf/message.h>

#include <memory>

class MatlabEstimModel : public core::common::Loggable<std::shared_ptr<google::protobuf::Message>>,
                         public core::common::Configurable
{
    public:
        MatlabEstimModel(core::JsonFileHandler &config, const std::string & model_name) : Configurable(config, model_name) {}
        virtual ~MatlabEstimModel() = 0;

};

inline MatlabEstimModel::~MatlabEstimModel() {}
#endif