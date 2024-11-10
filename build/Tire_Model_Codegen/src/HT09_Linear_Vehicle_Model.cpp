//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: HT09_Linear_Vehicle_Model.cpp
//
// Code generated for Simulink model 'HT09_Linear_Vehicle_Model'.
//
// Model version                  : 2.17
// Simulink Coder version         : 24.2 (R2024b) 21-Jun-2024
// C/C++ source code generated on : Tue Nov  5 20:01:12 2024
//
// Target selection: ert.tlc
// Embedded hardware selection: ARM Compatible->ARM Cortex-A (64-bit)
// Code generation objectives: Unspecified
// Validation result: Not run
//
#include "HT09_Linear_Vehicle_Model.h"
#include "rtwtypes.h"
#include <cmath>
#include "look1_binlcapw.h"
#include "cmath"
#include "HT09_Linear_Vehicle_Model_private.h"

// Output and update for referenced model: 'HT09_Linear_Vehicle_Model'
void HT09_Linear_Vehicle_Model::step(const real_T *rtu_DeltaDeg, const real_T
  *rtu_Vx, const real_T *rtu_FZ_FLN, const real_T *rtu_FZ_FRN, const real_T
  *rtu_FZ_RLN, const real_T *rtu_FZ_RRN, const real_T *rtu_u_offset, real_T
  *rty_Linear_Model_Output_Vy, real_T *rty_Linear_Model_Output_psi_dot_no_gain,
  real_T *rty_Linear_Model_Output_Alpha_Deg_Front, real_T
  *rty_Linear_Model_Output_Alpha_Deg_Rear, real_T *rty_Vy_LM, real_T
  *rty_Psi_dot_LMrads, real_T *rty_Psi_dot_LMdegs, real_T
  *rty_DesiredYawRaterads)
{
  real_T rtb_Ad_idx_1;
  real_T rtb_Ad_idx_2;
  real_T rtb_Add;
  real_T rtb_Add5;
  real_T rtb_Delta_deg;
  real_T rtb_Gain1_j;
  real_T rtb_Gain_d;
  real_T rtb_MatrixConcatenate3_idx_0;
  real_T rtb_MatrixConcatenate3_idx_1;
  real_T rtb_Switch;
  real_T rtb_delta_deg;
  real_T tmp;
  real_T tmp_0;

  // Lookup_n-D: '<Root>/1-D Lookup Table'
  rtb_Gain1_j = look1_binlcapw(*rtu_FZ_FLN, rtCP_uDLookupTable_bp01Data,
    rtCP_uDLookupTable_tableData, 40U);

  // Lookup_n-D: '<Root>/1-D Lookup Table1'
  rtb_Switch = look1_binlcapw(*rtu_FZ_FRN, rtCP_uDLookupTable1_bp01Data,
    rtCP_uDLookupTable1_tableData, 40U);

  // Sum: '<Root>/Add3' incorporates:
  //   Gain: '<Root>/Gain10'
  //   Gain: '<Root>/Gain9'
  //   Sum: '<Root>/Add'
  //   Sum: '<Root>/Add1'

  rtb_Switch = 57.295779513082323 * rtb_Gain1_j + 57.295779513082323 *
    rtb_Switch;

  // Gain: '<Root>/Gain6' incorporates:
  //   Gain: '<Root>/Gain5'
  //   Sum: '<Root>/Add3'

  rtb_MatrixConcatenate3_idx_0 = -(rtb_Switch * 0.004);

  // Gain: '<Root>/Gain'
  rtb_Gain_d = rtb_Switch * 0.755;

  // Gain: '<Root>/Gain8' incorporates:
  //   Gain: '<Root>/Gain7'

  rtb_MatrixConcatenate3_idx_1 = -(0.012657587236929698 * rtb_Gain_d);

  // Lookup_n-D: '<Root>/1-D Lookup Table2'
  rtb_Add5 = look1_binlcapw(*rtu_FZ_RLN, rtCP_uDLookupTable2_bp01Data,
    rtCP_uDLookupTable2_tableData, 40U);

  // Gain: '<Root>/Gain11'
  rtb_Add5 *= 57.295779513082323;

  // Lookup_n-D: '<Root>/1-D Lookup Table3'
  rtb_Delta_deg = look1_binlcapw(*rtu_FZ_RRN, rtCP_uDLookupTable3_bp01Data,
    rtCP_uDLookupTable3_tableData, 40U);

  // Gain: '<Root>/Gain12'
  rtb_Delta_deg *= 57.295779513082323;

  // Sum: '<Root>/Add'
  rtb_Add = (rtb_Switch + rtb_Add5) + rtb_Delta_deg;

  // Switch: '<Root>/Switch' incorporates:
  //   Constant: '<Root>/Constant'

  if (*rtu_Vx > 0.0) {
    rtb_Switch = *rtu_Vx;
  } else {
    rtb_Switch = 0.001;
  }

  // End of Switch: '<Root>/Switch'

  // Gain: '<Root>/Gain1'
  rtb_Gain1_j = 250.0 * rtb_Switch;

  // Gain: '<Root>/Gain2' incorporates:
  //   Sum: '<Root>/Add2'

  rtb_Delta_deg = (rtb_Add5 + rtb_Delta_deg) * 0.77999999999999992;

  // Product: '<Root>/Product' incorporates:
  //   Constant: '<Root>/Constant2'

  rtb_Add5 = rtb_Switch * 79.003998256666662;

  // MATLAB Function: '<Root>/State Space Discretization' incorporates:
  //   Constant: '<Root>/Constant1'
  //   Product: '<Root>/Divide'

  rtb_Add = 1.0 - rtb_Add / rtb_Gain1_j * 0.001;

  // Sum: '<Root>/Subtract2' incorporates:
  //   Sum: '<Root>/Subtract'

  rtb_Ad_idx_1 = rtb_Gain_d - rtb_Delta_deg;

  // MATLAB Function: '<Root>/State Space Discretization' incorporates:
  //   Constant: '<Root>/Constant1'
  //   Gain: '<Root>/Gain3'
  //   Gain: '<Root>/Gain4'
  //   Product: '<Root>/Divide1'
  //   Product: '<Root>/Divide2'
  //   Product: '<Root>/Divide3'
  //   Sum: '<Root>/Subtract1'
  //   Sum: '<Root>/Subtract2'
  //   Sum: '<Root>/Subtract3'

  rtb_delta_deg = 0.0 - rtb_Ad_idx_1 / rtb_Add5 * 0.001;
  rtb_Gain1_j = 0.0 - (rtb_Ad_idx_1 / rtb_Gain1_j - rtb_Switch) * 0.001;
  rtb_Delta_deg = 1.0 - (0.755 * rtb_Gain_d + 0.77999999999999992 *
    rtb_Delta_deg) / rtb_Add5 * 0.001;
  if (std::abs(rtb_delta_deg) > std::abs(rtb_Add)) {
    rtb_Add5 = rtb_Add / rtb_delta_deg;
    rtb_Gain_d = 1.0 / (rtb_Add5 * rtb_Delta_deg - rtb_Gain1_j);
    rtb_Delta_deg = rtb_Delta_deg / rtb_delta_deg * rtb_Gain_d;
    rtb_Ad_idx_1 = -rtb_Gain_d;
    rtb_Ad_idx_2 = -rtb_Gain1_j / rtb_delta_deg * rtb_Gain_d;
    rtb_Gain_d *= rtb_Add5;
  } else {
    rtb_Add5 = rtb_delta_deg / rtb_Add;
    rtb_Gain_d = 1.0 / (rtb_Delta_deg - rtb_Add5 * rtb_Gain1_j);
    rtb_Delta_deg = rtb_Delta_deg / rtb_Add * rtb_Gain_d;
    rtb_Ad_idx_1 = -rtb_Add5 * rtb_Gain_d;
    rtb_Ad_idx_2 = -rtb_Gain1_j / rtb_Add * rtb_Gain_d;
  }

  // Delay: '<S3>/State' incorporates:
  //   Reshape: '<S3>/RSx'

  rtb_Add = HT09_Linear_Vehicle_Model_DW.State_DSTATE[0];
  rtb_Gain1_j = HT09_Linear_Vehicle_Model_DW.State_DSTATE[1];

  // MATLAB Function: '<Root>/MATLAB Function'
  rtb_Add5 = *rtu_DeltaDeg + *rtu_u_offset;
  if (rtb_Add5 > 119.0) {
    rtb_Add5 = 119.0;
  }

  if (rtb_Add5 < -130.0) {
    rtb_Add5 = -130.0;
  }

  if (std::isnan(rtb_Add5)) {
    rtb_delta_deg = (rtNaN);
  } else {
    rtb_Add5 = (rtb_Add5 - -130.0) / 249.0;
    if (rtb_Add5 == 0.0) {
      rtb_delta_deg = 24.0;
    } else if (rtb_Add5 == 1.0) {
      rtb_delta_deg = -24.0;
    } else {
      rtb_delta_deg = (1.0 - rtb_Add5) * 24.0 + rtb_Add5 * -24.0;
    }
  }

  // End of MATLAB Function: '<Root>/MATLAB Function'

  // Gain: '<S1>/Gain1' incorporates:
  //   Sum: '<Root>/Add6'

  rtb_Add5 = 0.017453292519943295 * rtb_delta_deg;

  // Sum: '<S3>/dxSum' incorporates:
  //   Concatenate: '<Root>/Matrix Concatenate3'
  //   Constant: '<Root>/Constant1'
  //   Delay: '<S3>/State'
  //   MATLAB Function: '<Root>/State Space Discretization'
  //   Product: '<S3>/ProductA'
  //   Product: '<S3>/ProductB'

  tmp = rtb_Delta_deg * HT09_Linear_Vehicle_Model_DW.State_DSTATE[0] +
    rtb_Ad_idx_2 * HT09_Linear_Vehicle_Model_DW.State_DSTATE[1];
  tmp_0 = rtb_Ad_idx_1 * HT09_Linear_Vehicle_Model_DW.State_DSTATE[0] +
    rtb_Gain_d * HT09_Linear_Vehicle_Model_DW.State_DSTATE[1];
  HT09_Linear_Vehicle_Model_DW.State_DSTATE[0] = (0.001 * rtb_Delta_deg *
    rtb_MatrixConcatenate3_idx_0 + 0.001 * rtb_Ad_idx_2 *
    rtb_MatrixConcatenate3_idx_1) * rtb_Add5 + tmp;
  HT09_Linear_Vehicle_Model_DW.State_DSTATE[1] = (0.001 * rtb_Ad_idx_1 *
    rtb_MatrixConcatenate3_idx_0 + 0.001 * rtb_Gain_d *
    rtb_MatrixConcatenate3_idx_1) * rtb_Add5 + tmp_0;

  // Sum: '<Root>/Subtract4' incorporates:
  //   Gain: '<Root>/Gain13'
  //   Gain: '<S5>/Gain'
  //   Product: '<Root>/Divide4'
  //   Sum: '<Root>/Add4'
  //   Sum: '<Root>/Add6'

  *rty_Linear_Model_Output_Alpha_Deg_Front = (0.755 * rtb_Gain1_j + rtb_Add) /
    rtb_Switch * 57.295779513082323 - rtb_delta_deg;

  // Gain: '<S6>/Gain' incorporates:
  //   Gain: '<Root>/Gain14'
  //   Product: '<Root>/Divide5'
  //   Sum: '<Root>/Add5'

  *rty_Linear_Model_Output_Alpha_Deg_Rear = (rtb_Add - 0.77999999999999992 *
    rtb_Gain1_j) / rtb_Switch * 57.295779513082323;

  // SignalConversion generated from: '<Root>/Linear_Model_Outport_1'
  *rty_Linear_Model_Output_Vy = rtb_Add;

  // SignalConversion generated from: '<Root>/Linear_Model_Outport_1'
  *rty_Linear_Model_Output_psi_dot_no_gain = rtb_Gain1_j;

  // Gain: '<S7>/Gain'
  *rty_Psi_dot_LMdegs = 57.295779513082323 * rtb_Gain1_j;

  // SignalConversion generated from: '<Root>/Psi_dot_LM [rad//s]'
  *rty_Psi_dot_LMrads = rtb_Gain1_j;

  // SignalConversion generated from: '<Root>/Vy_LM'
  *rty_Vy_LM = rtb_Add;

  // Product: '<Root>/Divide6' incorporates:
  //   Constant: '<Root>/wb'
  //   Gain: '<S2>/Gain1'
  //   Sum: '<Root>/Add6'
  //   Trigonometry: '<Root>/Tan'

  *rty_DesiredYawRaterads = std::tan(0.017453292519943295 * rtb_delta_deg) *
    rtb_Switch / 1.535;
}

const char_T** HT09_Linear_Vehicle_Model::RT_MODEL_HT09_Linear_Vehicle_Model_T::
  getErrorStatusPointer() const
{
  return errorStatus;
}

void HT09_Linear_Vehicle_Model::RT_MODEL_HT09_Linear_Vehicle_Model_T::
  setErrorStatusPointer(const char_T** aErrorStatusPointer)
{
  (errorStatus = aErrorStatusPointer);
}

const char_T* HT09_Linear_Vehicle_Model::RT_MODEL_HT09_Linear_Vehicle_Model_T::
  getErrorStatus() const
{
  return (*(errorStatus));
}

void HT09_Linear_Vehicle_Model::RT_MODEL_HT09_Linear_Vehicle_Model_T::
  setErrorStatus(const char_T* const aErrorStatus) const
{
  (*(errorStatus) = aErrorStatus);
}

// Constructor
HT09_Linear_Vehicle_Model::HT09_Linear_Vehicle_Model() :
  HT09_Linear_Vehicle_Model_DW(),
  HT09_Linear_Vehicle_Model_M()
{
  // Currently there is no constructor body generated.
}

// Destructor
// Currently there is no destructor body generated.
HT09_Linear_Vehicle_Model::~HT09_Linear_Vehicle_Model() = default;

// Real-Time Model get method
HT09_Linear_Vehicle_Model::RT_MODEL_HT09_Linear_Vehicle_Model_T
  * HT09_Linear_Vehicle_Model::getRTM()
{
  return (&HT09_Linear_Vehicle_Model_M);
}

//
// File trailer for generated code.
//
// [EOF]
//
