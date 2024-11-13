#ifndef __MATLABMODEL_H__
#define __MATLABMODEL_H__

#include <unordered_map>

class MatlabModel {
    public:

        bool init();

        std::unordered_map<std::string, float> &get_params();

};

#endif