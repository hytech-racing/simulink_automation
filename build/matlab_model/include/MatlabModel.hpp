#include <unordered_map>
#include <Configurable.hpp>


    class MatlabModel : public core::common::Configurable {
        public:

            MatlabModel() = delete;

            bool init();

            std::unordered_map<std::string, float> &get_params();

            void handle_parameter_updates(const std::unordered_map<std::string, core::common::Configurable::ParamTypes> &new_param_map);

    };
