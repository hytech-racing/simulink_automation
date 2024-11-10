#include <unordered_map>

class MatlabModel {
    public:

        MatlabModel() = delete;

        bool model_init();

        void initialize_model_inputs();

        std::unordered_map<std::string, float> &get_params();

}