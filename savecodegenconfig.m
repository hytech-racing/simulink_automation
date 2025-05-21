% Names of the source and target models
srcModel = 'test_mode0';

% Load models (optional if already open)
load_system(srcModel);

% Get active config set from source model
srcCfg = getActiveConfigSet(srcModel);

% Create a copy of the config set for the target model
hytech_codegen_config = copy(srcCfg);
hytech_codegen_config.Name = 'hytech_codegen_config';  % Optional: give it a clear name
save('hytech_codegen_config.mat', 'hytech_codegen_config');