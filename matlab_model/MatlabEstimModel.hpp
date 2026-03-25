#ifndef __MATLABESTIMMODEL_H__
#define __MATLABESTIMMODEL_H__
#include <VehicleDataTypes.hpp>
#include <Configurable.hpp>
#include <Loggable.hpp>

#include <google/protobuf/message.h>

#include <memory>

class MatlabEstimModel
{
    public:
        MatlabEstimModel() {}
        virtual ~MatlabEstimModel() = 0;
};

inline MatlabEstimModel::~MatlabEstimModel() {}
#endif