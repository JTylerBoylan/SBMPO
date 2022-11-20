%% Book Model Configuration - Samples Benchmark

clear
close all
clc

%%

% Set total number of runs
runs = 12;

MaxIterations = 10000;
MaxGenerations = 100;
SampleHorizonTime = 0.3;
SampleHorizonTimeIncrement = 0.1;
GoalThreshold = 0.3;

NumberOfStates = 3;
NumberOfControls = 2;
NumberOfGriddedStates = 2;
InitialState = [0, 0, 1.5707];
GoalState = [5, 5, 0];
InitialControl = [0, 0];
GridActiveStates = [1, 1, 0];
GridResolution = [0.01, 0.01];

RotationControls = {
        [0 -0.785398 0.785398 -0.589049 0.589049 -0.392699 0.392699 -0.196350 0.196350];
        [0 -0.589049 0.589049 -0.392699 0.392699 -0.196350 0.196350];
        [0 -0.392699 0.392699 -0.196350 0.196350];
        [0 -0.392699 0.392699];
        [0 -0.785398 0.785398 -0.589049 0.589049 -0.392699 0.392699 -0.196350 0.196350];
        [0 -0.589049 0.589049 -0.392699 0.392699 -0.196350 0.196350];
        [0 -0.392699 0.392699 -0.196350 0.196350];
        [0 -0.392699 0.392699];
        [0 -0.785398 0.785398 -0.589049 0.589049 -0.392699 0.392699 -0.196350 0.196350];
        [0 -0.589049 0.589049 -0.392699 0.392699 -0.196350 0.196350];
        [0 -0.392699 0.392699 -0.196350 0.196350];
        [0 -0.392699 0.392699];
      };
  
LinearControls = {
        [0.1 0.3 0.5];
        [0.1 0.3 0.5];
        [0.1 0.3 0.5];
        [0.1 0.3 0.5];
        [0.3 0.5];
        [0.3 0.5];
        [0.3 0.5];
        [0.3 0.5];
        [0.5];
        [0.5];
        [0.5];
        [0.5];
      };
  
V = @(arr,r) arr(ceil(r * size(arr,1) / runs),:);

Configuration = cell(runs,1);
for r = 1:runs

    LinearControl = cell2mat(V(LinearControls, r));
    RotationControl = cell2mat(V(RotationControls, r));
    
    SizeLinear = length(LinearControl);
    SizeRotation = length(RotationControl);
    NumberOfSamples = SizeRotation * SizeLinear;
    Samples = zeros(1, NumberOfSamples*V(NumberOfControls,r));

    for v = 1:SizeLinear
        for u = 1:SizeRotation
            Samples(2*(v-1)*SizeRotation + 2*(u-1) + 1) = LinearControl(v);
            Samples(2*(v-1)*SizeRotation + 2*(u-1) + 2) = RotationControl(u);
        end
    end 

    Configuration(r) = {[V(MaxIterations,r) V(MaxGenerations,r) V(SampleHorizonTime,r)...
            V(SampleHorizonTimeIncrement,r)  V(GoalThreshold,r) ...
            V(NumberOfStates,r) V(NumberOfControls,r) V(NumberOfGriddedStates,r) ...
            V(InitialState,r) V(GoalState,r) V(InitialControl,r) ...
            V(GridActiveStates,r) V(GridResolution,r)...
            NumberOfSamples Samples]};

end
    
 writecell(Configuration, '../config/book_model_verify.csv', 'Delimiter', ',')