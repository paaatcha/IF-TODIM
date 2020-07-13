%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Intuiniotist Fuzzy TODIM Group Oil
%
% Authors: Andre Pacheco and Andre Siviero
% Supervisors: Renato Krohling and Rodolfo Lourenzutti
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MatrixD = [
    IntuitionistFuzzyNumber([7.7643 8.1957 9.05840 9.48970])    IntuitionistFuzzyNumber([4.7007 4.9619 5.4841 5.7453])
    IntuitionistFuzzyNumber([8.8542 9.3461 10.3299 10.8218])    IntuitionistFuzzyNumber([3.6207 3.8218 4.2241 4.4253])
    IntuitionistFuzzyNumber([9.3366 9.8553 10.8927 11.4114])    IntuitionistFuzzyNumber([3.1455 3.3203 3.6698 3.8445])
    IntuitionistFuzzyNumber([7.3800 7.7900 8.61000 9.02000])    IntuitionistFuzzyNumber([5.0931 5.3761 5.9419 6.2249])
    IntuitionistFuzzyNumber([5.2686 5.5613 6.14670 6.43940])    IntuitionistFuzzyNumber([7.1901 7.5896 8.3885 8.7879])
    IntuitionistFuzzyNumber([7.2972 7.7026 8.51340 8.91880])    IntuitionistFuzzyNumber([5.2110 5.5005 6.0795 6.3690])
    IntuitionistFuzzyNumber([6.1605 6.5027 7.18720 7.52950])    IntuitionistFuzzyNumber([6.3747 6.7289 7.4371 7.7913])
    IntuitionistFuzzyNumber([5.1642 5.4511 6.02490 6.31180])    IntuitionistFuzzyNumber([7.4142 7.8261 8.6499 9.0618])
    IntuitionistFuzzyNumber([4.1366 4.7104 6.14490 6.43180])    IntuitionistFuzzyNumber([5.7176 6.5414 8.6009 9.0128])
    IntuitionistFuzzyNumber([5.6421 5.9556 6.58240 6.89590])    IntuitionistFuzzyNumber([7.0272 7.4176 8.1984 8.5888])
    ];


CBVector = [0 1]; %In each column vector: = 0 = 1 and cost benefits
WeightsAg = [0.5 0.5]; %Weight vector matrix for Agency
WeightsCompany = [0.05 0.95]; %Weight vector matrix for Oil Company
WeightsONG = [0.95 0.05]; %Weight vector matrix for NGO
teta = 1; %Defining teta

%Building the objects
IFM_Ag = IntuitionistFuzzyMatrix(CBVector,MatrixD,WeightsAg);
IFM_Company = IntuitionistFuzzyMatrix(CBVector,MatrixD,WeightsCompany);
IFM_ONG = IntuitionistFuzzyMatrix(CBVector,MatrixD,WeightsONG);

IFM_Ag.normalizeDecisionMatrixTODIM; %Normalizing
IFM_Company.normalizeDecisionMatrixTODIM; %Normalizing
IFM_ONG.normalizeDecisionMatrixTODIM; %Normalizing

%Building the vector IFM's
Matrixes = [IFM_Ag IFM_Company IFM_ONG];

TODIM_group (Matrixes,teta,[0.1 0.8 0.1]) %Applying the method TODIM. The last parameter is the people of each decision maker




