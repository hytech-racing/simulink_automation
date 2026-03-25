#ifndef __MATLABMODEL_H__
#define __MATLABMODEL_H__
#include <VehicleDataTypes.hpp>
#include <Controller.hpp>
#include <Configurable.hpp>
#include <Loggable.hpp>

#include <google/protobuf/message.h>

#include <memory>

class MatlabModel : public control::Controller<core::ControllerOutput, core::VehicleState>,

{
    public:
        MatlabModel() : Configurable() {}
        virtual ~MatlabModel() = 0;
        float get_dt_sec() {return 0.004;}

};

inline MatlabModel::~MatlabModel() {}
#endif