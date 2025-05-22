#ifndef __MATLABMODEL_H__
#define __MATLABMODEL_H__
#include <VehicleDataTypes.hpp>
#include <Controller.hpp>
#include <Configurable.hpp>
#include <Loggable.hpp>

#include <google/protobuf/message.h>

#include <memory>

class MatlabModel : public control::Controller<core::ControllerOutput, core::VehicleState>,
                                 public core::common::Loggable<std::shared_ptr<google::protobuf::Message>>
                                 public core::common::Configurable {
    public:

        virtual ~MatlabModel() = 0;

};

inline MatlabModel::~MatlabModel() {}
#endif