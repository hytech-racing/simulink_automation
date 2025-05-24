#pragma once

#include <VehicleDataTypes.hpp>

#include "EstimatorOutputs.hpp"

// contains all of the simulink code gen estimators and provides their outputs

namespace matlab_model_gen
{
namespace estimation
{
class EstimatorManager
{
    public:
        EstimatorManager() = default;

        EstimatorOutputs_s get_latest_estimation() {
            return _estim;
        }

        void evaluate_all_estimators() {

        }
    private:
        
        EstimatorOutputs_s _estim;
};
}
}
