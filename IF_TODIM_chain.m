%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Intuiniotist Fuzzy TODIM
%
% Authors: Andre Pacheco and Andre Siviero
% Supervisors: Renato Krohling and Rodolfo Lourenzutti
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This matrix is already normalized
MatrixD = [
    IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.5,0.4) IntuitionistFuzzyNumber([0.1 0.2 0.3 0.4],0.6,0.3) IntuitionistFuzzyNumber([0.5 0.6 0.8 0.9],0.3,0.6) IntuitionistFuzzyNumber([0.4 0.5 0.6 0.7],0.2,0.7)
    IntuitionistFuzzyNumber([0.6 0.7 0.8 0.9],0.7,0.3) IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.7,0.2) IntuitionistFuzzyNumber([0.4 0.5 0.7 0.8],0.7,0.2) IntuitionistFuzzyNumber([0.5 0.6 0.7 0.9],0.4,0.5)
    IntuitionistFuzzyNumber([0.1 0.2 0.4 0.5],0.6,0.7) IntuitionistFuzzyNumber([0.2 0.3 0.5 0.6],0.5,0.4) IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.5,0.3) IntuitionistFuzzyNumber([0.3 0.5 0.7 0.9],0.2,0.3)
    IntuitionistFuzzyNumber([0.3 0.4 0.5 0.6],0.8,0.1) IntuitionistFuzzyNumber([0.1,0.3,0.4,0.5],0.6,0.3) IntuitionistFuzzyNumber([0.1 0.3 0.5 0.7],0.3,0.4) IntuitionistFuzzyNumber([0.6 0.7 0.8 0.9],0.2,0.6)
    IntuitionistFuzzyNumber([0.2 0.3 0.4 0.5],0.6,0.2) IntuitionistFuzzyNumber([0.3 0.4 0.5 0.6],0.4,0.3) IntuitionistFuzzyNumber([0.2 0.3 0.4 0.5],0.7,0.1) IntuitionistFuzzyNumber([0.5 0.6 0.7 0.8],0.1,0.3)    
];

CBVector = [1 1 1 0]; %In each column vector: = 0 = 1 and cost benefits
Weights = [0.3500 0.2333 0.3000 0.1167]; %Weight vector matrix
teta = 10; %Defining teta

IFM = IntuitionistFuzzyMatrix(CBVector,MatrixD,Weights); %Building the object


TODIM (IFM,teta,[0 0]); %Applying the method TODIM

%%The last parameter is the people of each decision maker (TODIM Group). Therefore, they are not used here
