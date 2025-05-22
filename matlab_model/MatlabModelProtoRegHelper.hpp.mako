#pragma once

#include <vector>
#include <string>

namespace matlab_model_gen
{
<%!
from mako.template import Template
%>
const std::vector<std::string> matlab_model_gend_protos = {
% for i, item in enumerate(proto_file_names):
% if i < (len(proto_file_names)-1):
    "${item}",
% else:
    "${item}"
% endif
% endfor
};

}