#pragma once



<%
# model_outputs is a dict: model name -> list of field names
%>

% for model, outputs in model_outputs.items():

% endfor

struct EstimatorOutputs_s {
% for model, outputs in model_outputs.items():
% for field in outputs:
    float ${model}_${field};
% endfor
% endfor
};