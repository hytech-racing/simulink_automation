#ifndef __MATLABMODEL_H__
#define __MATLABMODEL_H__
#include <StateTracker.hpp>
#include <Controller.hpp>

#include <google/protobuf/message.h>

#include <memory>

class MatlabModel : public control::Controller<core::ControllerOutput, core::VehicleState>

{
    public:
        MatlabModel() {}
        virtual ~MatlabModel() = 0;
        float get_dt_sec() {return 0.004;}

};

inline MatlabModel::~MatlabModel() {}
#endif