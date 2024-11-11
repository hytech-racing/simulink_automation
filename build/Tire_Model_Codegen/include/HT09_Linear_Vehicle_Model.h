//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: HT09_Linear_Vehicle_Model.h
//
// Code generated for Simulink model 'HT09_Linear_Vehicle_Model'.
//
// Model version                  : 2.17
// Simulink Coder version         : 24.2 (R2024b) 21-Jun-2024
// C/C++ source code generated on : Sun Nov 10 16:49:20 2024
//
// Target selection: ert.tlc
// Embedded hardware selection: ARM Compatible->ARM Cortex-A (64-bit)
// Code generation objectives: Unspecified
// Validation result: Not run
//
#ifndef HT09_Linear_Vehicle_Model_h_
#define HT09_Linear_Vehicle_Model_h_
#include <cmath>
#include "rtwtypes.h"
#include "rt_nonfinite.h"
#include "HT09_Linear_Vehicle_Model_types.h"

extern "C"
{

#include "rtGetNaN.h"

}

#include <cstring>

// Class declaration for model HT09_Linear_Vehicle_Model
class HT09_Linear_Vehicle_Model final
{
  // public data and function members
 public:
  // Block states (default storage) for model 'HT09_Linear_Vehicle_Model'
  struct DW_HT09_Linear_Vehicle_Model_T {
    real_T State_DSTATE[2];            // '<S3>/State'
  };

  // Invariant block signals for model 'HT09_Linear_Vehicle_Model'
  struct ConstB_HT09_Linear_Vehicle_Model_h_T {
    real_T signal2;
    real_T signal4;
  };

  // Real-time Model Data Structure
  struct RT_MODEL_HT09_Linear_Vehicle_Model_T {
    const char_T **errorStatus;
    const char_T** getErrorStatusPointer() const;
    void setErrorStatusPointer(const char_T** aErrorStatusPointer);
    const char_T* getErrorStatus() const;
    void setErrorStatus(const char_T* const aErrorStatus) const;
  };

  // Copy Constructor
  HT09_Linear_Vehicle_Model(HT09_Linear_Vehicle_Model const&) = delete;

  // Assignment Operator
  HT09_Linear_Vehicle_Model& operator= (HT09_Linear_Vehicle_Model const&) & =
    delete;

  // Move Constructor
  HT09_Linear_Vehicle_Model(HT09_Linear_Vehicle_Model &&) = delete;

  // Move Assignment Operator
  HT09_Linear_Vehicle_Model& operator= (HT09_Linear_Vehicle_Model &&) = delete;

  // Real-Time Model get method
  HT09_Linear_Vehicle_Model::RT_MODEL_HT09_Linear_Vehicle_Model_T * getRTM();

  // model step function
  void step(const real_T *rtu_DeltaDeg, const real_T *rtu_Vx, const real_T
            *rtu_FZ_FLN, const real_T *rtu_FZ_FRN, const real_T *rtu_FZ_RLN,
            const real_T *rtu_FZ_RRN, const real_T *rtu_u_offset, real_T
            *rty_Linear_Model_Output_Vy, real_T
            *rty_Linear_Model_Output_psi_dot_no_gain, real_T
            *rty_Linear_Model_Output_Alpha_Deg_Front, real_T
            *rty_Linear_Model_Output_Alpha_Deg_Rear, real_T *rty_Vy_LM, real_T
            *rty_Psi_dot_LMrads, real_T *rty_Psi_dot_LMdegs, real_T
            *rty_DesiredYawRaterads);

  // Constructor
  HT09_Linear_Vehicle_Model();

  // Destructor
  ~HT09_Linear_Vehicle_Model();

  // private data and function members
 private:
  // Block states
  DW_HT09_Linear_Vehicle_Model_T HT09_Linear_Vehicle_Model_DW;

  // Real-Time Model
  RT_MODEL_HT09_Linear_Vehicle_Model_T HT09_Linear_Vehicle_Model_M;
};

// Invariant block signals (default storage)
extern const HT09_Linear_Vehicle_Model::ConstB_HT09_Linear_Vehicle_Model_h_T
  HT09_Linear_Vehicle_Model_ConstB;

//-
//  These blocks were eliminated from the model due to optimizations:
//
//  Block '<Root>/Constant3' : Unused code path elimination
//  Block '<Root>/Constant4' : Unused code path elimination
//  Block '<S3>/ProductC' : Unused code path elimination
//  Block '<S3>/ProductD' : Unused code path elimination
//  Block '<S3>/RSdx' : Unused code path elimination
//  Block '<S3>/RSy' : Unused code path elimination
//  Block '<S3>/ySum' : Unused code path elimination
//  Block '<Root>/Display' : Unused code path elimination
//  Block '<Root>/Display1' : Unused code path elimination
//  Block '<Root>/Display2' : Unused code path elimination


//-
//  The generated code includes comments that allow you to trace directly
//  back to the appropriate location in the model.  The basic format
//  is <system>/block_name, where system is the system number (uniquely
//  assigned by Simulink) and block_name is the name of the block.
//
//  Use the MATLAB hilite_system command to trace the generated code back
//  to the model.  For example,
//
//  hilite_system('<S3>')    - opens system 3
//  hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
//
//  Here is the system hierarchy for this model
//
//  '<Root>' : 'HT09_Linear_Vehicle_Model'
//  '<S1>'   : 'HT09_Linear_Vehicle_Model/Degrees to Radians'
//  '<S2>'   : 'HT09_Linear_Vehicle_Model/Degrees to Radians2'
//  '<S3>'   : 'HT09_Linear_Vehicle_Model/Discrete Varying State Space'
//  '<S4>'   : 'HT09_Linear_Vehicle_Model/MATLAB Function'
//  '<S5>'   : 'HT09_Linear_Vehicle_Model/Radians to Degrees'
//  '<S6>'   : 'HT09_Linear_Vehicle_Model/Radians to Degrees1'
//  '<S7>'   : 'HT09_Linear_Vehicle_Model/Radians to Degrees2'
//  '<S8>'   : 'HT09_Linear_Vehicle_Model/State Space Discretization'

#endif                                 // HT09_Linear_Vehicle_Model_h_

//
// File trailer for generated code.
//
// [EOF]
//
