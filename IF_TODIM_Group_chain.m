%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Intuiniotist Fuzzy TODIM Group
%
% Authors: Andre Pacheco and Andre Siviero
% Supervisors: Renato Krohling and Rodolfo Lourenzutti
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%These matrixes are already normalized
R1 = [
        IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.5,0.4) IntuitionistFuzzyNumber([0.1 0.2 0.3 0.4],0.6,0.3) IntuitionistFuzzyNumber([0.5 0.6 0.8 0.9],0.3,0.6) IntuitionistFuzzyNumber([0.4 0.5 0.6 0.7],0.2,0.7)
        IntuitionistFuzzyNumber([0.6 0.7 0.8 0.9],0.7,0.3) IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.7,0.2) IntuitionistFuzzyNumber([0.4 0.5 0.7 0.8],0.7,0.2) IntuitionistFuzzyNumber([0.5 0.6 0.7 0.9],0.4,0.5)
        IntuitionistFuzzyNumber([0.1 0.2 0.4 0.5],0.6,0.4) IntuitionistFuzzyNumber([0.2 0.3 0.5 0.6],0.5,0.4) IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.5,0.3) IntuitionistFuzzyNumber([0.3 0.5 0.7 0.9],0.2,0.3)
        IntuitionistFuzzyNumber([0.3 0.4 0.5 0.6],0.8,0.1) IntuitionistFuzzyNumber([0.1 0.3 0.4 0.5],0.6,0.3) IntuitionistFuzzyNumber([0.1 0.3 0.5 0.7],0.3,0.4) IntuitionistFuzzyNumber([0.6 0.7 0.8 0.9],0.2,0.6)
        IntuitionistFuzzyNumber([0.2 0.3 0.4 0.5],0.6,0.2) IntuitionistFuzzyNumber([0.3 0.4 0.5 0.6],0.4,0.3) IntuitionistFuzzyNumber([0.2 0.3 0.4 0.5],0.7,0.1) IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.1,0.3)
    ];

R2 = [
        IntuitionistFuzzyNumber([0.4 0.5 0.6 0.7],0.4,0.3) IntuitionistFuzzyNumber([0.1 0.2 0.3 0.4],0.6,0.2) IntuitionistFuzzyNumber([0.4 0.5 0.7 0.8],0.2,0.5) IntuitionistFuzzyNumber([0.3 0.4 0.5 0.6],0.1,0.6)
        IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.6,0.2) IntuitionistFuzzyNumber([0.4 0.5 0.6 0.7],0.6,0.1) IntuitionistFuzzyNumber([0.3 0.4 0.6 0.7],0.6,0.1) IntuitionistFuzzyNumber([0.4 0.5 0.6 0.8],0.3,0.4)
        IntuitionistFuzzyNumber([0.1 0.2 0.3 0.4],0.5,0.3) IntuitionistFuzzyNumber([0.1 0.2 0.4 0.5],0.4,0.3) IntuitionistFuzzyNumber([0.4 0.5 0.6 0.7],0.4,0.2) IntuitionistFuzzyNumber([0.2 0.4 0.6 0.6],0.5,0.2)
        IntuitionistFuzzyNumber([0.3 0.4 0.5 0.6],0.8,0.1) IntuitionistFuzzyNumber([0.1 0.2 0.3 0.5],0.5,0.2) IntuitionistFuzzyNumber([0.1 0.2 0.4 0.6],0.2,0.3) IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.1,0.5)
        IntuitionistFuzzyNumber([0.1 0.2 0.3 0.4],0.5,0.1) IntuitionistFuzzyNumber([0.2 0.3 0.4 0.5],0.3,0.2) IntuitionistFuzzyNumber([0.1 0.2 0.3 0.4],0.6,0.2) IntuitionistFuzzyNumber([0.4 0.5 0.6 0.7],0.4,0.2)
    ];

R3 = [
        IntuitionistFuzzyNumber([0.6 0.7 0.8 0.9],0.4,0.5) IntuitionistFuzzyNumber([0.2 0.3 0.4 0.5],0.5,0.4) IntuitionistFuzzyNumber([0.6 0.7 0.9 1.0],0.2,0.7) IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.1,0.8)
        IntuitionistFuzzyNumber([0.7 0.8 0.9 1.0],0.6,0.4) IntuitionistFuzzyNumber([0.6 0.7 0.8 0.9],0.6,0.3) IntuitionistFuzzyNumber([0.5 0.6 0.8 0.9],0.6,0.3) IntuitionistFuzzyNumber([0.6 0.7 0.8 1.0],0.3,0.6)
        IntuitionistFuzzyNumber([0.2 0.3 0.5 0.6],0.5,0.5) IntuitionistFuzzyNumber([0.3 0.4 0.6 0.7],0.4,0.5) IntuitionistFuzzyNumber([0.6 0.7 0.8 0.9],0.4,0.4) IntuitionistFuzzyNumber([0.4 0.6 0.8 1.0],0.5,0.4)
        IntuitionistFuzzyNumber([0.4 0.5 0.6 0.7],0.7,0.2) IntuitionistFuzzyNumber([0.2 0.4 0.5 0.6],0.5,0.4) IntuitionistFuzzyNumber([0.2 0.4 0.6 0.8],0.2,0.5) IntuitionistFuzzyNumber([0.7 0.8 0.9 1.0],0.1,0.7)
        IntuitionistFuzzyNumber([0.3 0.4 0.5 0.6],0.5,0.3) IntuitionistFuzzyNumber([0.4 0.5 0.6 0.7],0.3,0.4) IntuitionistFuzzyNumber([0.3 0.4 0.5 0.6],0.6,0.2) IntuitionistFuzzyNumber([0.6 0.7 0.8 0.9],0.4,0.4)
    ];

CBVector = [1 1 1 0]; %In each column vector: = 0 = 1 and cost benefits
Weights = [0.2 0.1 0.3 0.4]; %Weight vector matrix
teta = 2.5; %Defining teta

%Building the objects
IFM_1 = IntuitionistFuzzyMatrix(CBVector,R1,Weights);
IFM_2 = IntuitionistFuzzyMatrix(CBVector,R2,Weights);
IFM_3 = IntuitionistFuzzyMatrix(CBVector,R3,Weights);

%Building the vector IFM's
Matrixes = [IFM_1 IFM_2 IFM_3];

TODIM_group (Matrixes,teta,[0.05 0.9 0.05]) %Applying the method TODIM. The last parameter is the people of each decision maker
