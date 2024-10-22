# simulink automation

this repo will handle the automation of releasing the generated code libraries from the simulink models for both control and estimation.


## why is this in a separate repo from HyTech_sim? 

this is because it allows us to update the method(s) we use to release the model without releasing new models upon push and minimizes changes in the source repo. additionally, it allows us to trigger this workflow / generate a release from multiple different simulink repos if need be (prob not something we need right now). for the most part it just allows us to work on the automation seperately from the model itself which is desireable to keep down potential conflicts in simulink repo.

## responsibilities:

1. shall handle automated running of the code generation matlab script on desired models
2. the release process shall be kicked off upon push from a releasing repo upon changes to models
3. shall generate a cmake package containing multiple libraries, one for each code generation target.