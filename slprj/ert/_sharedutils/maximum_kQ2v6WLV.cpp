//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: maximum_kQ2v6WLV.cpp
//
// Code generated for Simulink model 'Tire_Model_Codegen'.
//
// Model version                  : 1.32
// Simulink Coder version         : 24.2 (R2024b) 21-Jun-2024
// C/C++ source code generated on : Tue Nov  5 20:01:42 2024
//
#include "rtwtypes.h"
#include "maximum_kQ2v6WLV.h"
#include <cmath>

// Function for MATLAB Function: '<S24>/MATLAB Function'
real_T maximum_kQ2v6WLV(const real_T x[100])
{
  real_T ex;
  int32_T idx;
  int32_T k;
  if (!std::isnan(x[0])) {
    idx = 1;
  } else {
    boolean_T exitg1;
    idx = 0;
    k = 2;
    exitg1 = false;
    while ((!exitg1) && (k < 101)) {
      if (!std::isnan(x[k - 1])) {
        idx = k;
        exitg1 = true;
      } else {
        k++;
      }
    }
  }

  if (idx == 0) {
    ex = x[0];
  } else {
    ex = x[idx - 1];
    for (k = idx + 1; k < 101; k++) {
      real_T x_0;
      x_0 = x[k - 1];
      if (ex < x_0) {
        ex = x_0;
      }
    }
  }

  return ex;
}

//
// File trailer for generated code.
//
// [EOF]
//
