//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: interp1_ctBBGdhl.cpp
//
// Code generated for Simulink model 'Tire_Model_Codegen'.
//
// Model version                  : 1.33
// Simulink Coder version         : 24.2 (R2024b) 21-Jun-2024
// C/C++ source code generated on : Sun Nov 10 16:49:50 2024
//
#include "rtwtypes.h"
#include "interp1_ctBBGdhl.h"
#include <cstring>
#include <cmath>
#include "rt_nonfinite.h"

// Function for MATLAB Function: '<S24>/MATLAB Function'
real_T interp1_ctBBGdhl(const real_T varargin_1[100], const real_T varargin_2
  [100], real_T varargin_3)
{
  real_T x[100];
  real_T y[100];
  real_T Vq;
  real_T xtmp;
  int32_T i;
  std::memcpy(&y[0], &varargin_2[0], 100U * sizeof(real_T));
  std::memcpy(&x[0], &varargin_1[0], 100U * sizeof(real_T));
  if (varargin_1[1] < varargin_1[0]) {
    for (i = 0; i < 50; i++) {
      xtmp = x[i];
      x[i] = x[99 - i];
      x[99 - i] = xtmp;
      xtmp = y[i];
      y[i] = y[99 - i];
      y[99 - i] = xtmp;
    }
  }

  Vq = (rtNaN);
  if ((!std::isnan(varargin_3)) && (!(varargin_3 > x[99])) && (!(varargin_3 < x
        [0]))) {
    int32_T high_i;
    int32_T low_ip1;
    i = 1;
    low_ip1 = 2;
    high_i = 100;
    while (high_i > low_ip1) {
      int32_T mid_i;
      mid_i = (i + high_i) >> 1;
      if (varargin_3 >= x[mid_i - 1]) {
        i = mid_i;
        low_ip1 = mid_i + 1;
      } else {
        high_i = mid_i;
      }
    }

    xtmp = x[i - 1];
    xtmp = (varargin_3 - xtmp) / (x[i] - xtmp);
    if (xtmp == 0.0) {
      Vq = y[i - 1];
    } else if (xtmp == 1.0) {
      Vq = y[i];
    } else {
      Vq = y[i - 1];
      if (!(Vq == y[i])) {
        Vq = (1.0 - xtmp) * Vq + xtmp * y[i];
      }
    }
  }

  return Vq;
}

//
// File trailer for generated code.
//
// [EOF]
//
