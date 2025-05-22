#ifndef __MATLABMODEL_H__
#define __MATLABMODEL_H__
#include <VehicleDataTypes.hpp>
#include <Controller.hpp>
#include <Configurable.hpp>
#include <Loggable.hpp>

#include <google/protobuf/message.h>

#include <memory>

class MatlabModel : public control::Controller<core::ControllerOutput, core::VehicleState>,
                    public core::common::Loggable<std::shared_ptr<google::protobuf::Message>>,
                    public core::common::Configurable
{
    public:
        MatlabModel(core::JsonFileHandler &config, const std::string & model_name) : Configurable(config, model_name) {}
        virtual ~MatlabModel() = 0;
        float get_dt_sec() {return 0.004;}

};

inline MatlabModel::~MatlabModel() {}
#endif