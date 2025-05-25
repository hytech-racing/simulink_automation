# Simulink automation

This repo will handle the automation of releasing the generated code libraries from the simulink models for both control and estimation.

## Usage: 

1. Any time HyTech_sim is pushed to, it will trigger the `gen_code.yaml` workflow
2. When the workflow is triggered, it will run the `gencode_v2.m` matlab script to create header/source files. 
3. The `process_simulink_codegen.py` file will then organize the header/source files, generate a cmakelists, and generate `Model_Name_MatlabModel` files that includes methods that can be called from the state estimator to `handle_paramaeter_updates`, `evaluate_estimator`, `get_params`, and more (see generated files for implementation details). 
4. **It is the respomsibility of the drivebrain maintainer to ensure that the correct inputs are being passed into the `evaluate_estimator` method and determine what to do with the estimator outputs.**

## Why is this in a separate repo from HyTech_sim? 

This is because it allows us to update the method(s) we use to release the model without releasing new models upon push and minimizes changes in the source repo. additionally, it allows us to trigger this workflow / generate a release from multiple different simulink repos if need be (prob not something we need right now). for the most part it just allows us to work on the automation seperately from the model itself which is desireable to keep down potential conflicts in simulink repo.

## Responsibilities:

1. shall handle automated running of the code generation matlab script on desired models
2. the release process shall be kicked off upon push from a releasing repo upon changes to models
3. shall generate a cmake package containing multiple libraries, one for each code generation target.


TODO:

- [x] make the estimator generation (should be very similar to the controller gen)
- [x] be able to have estimators feed their outputs into the controllers directly
	- [x] ideally with a generated POD from the outports of the estimators
	- [x] figure out the way to get the estimator inputs into the generated controllers - solved by making an estimator manager that can be passed into the controller model and have a getter for the results of the estimator 
		- [x] the estimator model outputs are formatted like "${model}_${field}" for the controller inputs