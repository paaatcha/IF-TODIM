%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Algorithm TOPSIS
%	
%	Authors: Andre Pacheco and Andre Siviero
%	Supervisors: Renato Krohling and Rodolfo Lourenzutti
%
%	This file is implemented the method of decision making Topsis. Here,
%   it is assumed that the intuitionistic fuzzy decision matrix is already
%   normalized. It is also supposes that the weight vector is known or has 
%   been previously calculated.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function vectorRanking = TOPSIS (IFM)
    vectorRC = relativeCloseness (IFM);
    order = size (vectorRC);
    vectorRanking = zeros(order);
    for i=1:order(1)
        vectorRanking(i) = i;
    end
    
    bar(vectorRanking,vectorRC);
        
end %end TOPSIS


function [vector_PIS,vector_NIS] = solutionsIdeals (IFM)
    % positive ideal solution (TIFPIS)
    TIFPIS = IntuitionistFuzzyNumber([1 1 1 1],1,0);
    %negative ideal solution (TIFNIS)
    TIFNIS = IntuitionistFuzzyNumber([0 0 0 0],0,1);
    
    order = size (IFM.matrixD);
    m = order(1);
    n = order(2);    
    
    % Finding vectors the positive ideal solution (vector_PIS) and the negative
    % ideal solution (vector_NIS)    
    for j=1:n
        if IFM.vector_cost_or_benefit(j) == 1
            vector_PIS(j) = TIFPIS;
            vector_NIS(j) = TIFNIS;
        else
            vector_PIS(j) = TIFNIS;
            vector_NIS(j) = TIFPIS;
        end %if
    end %for
end %solutionsIdeals


function [vectorDPlus, vectorDLess] = distanceToIdeal (IFM)
    order = size (IFM.matrixD);
    m = order(1);
    n = order(2);      
    
    [vector_PIS,vector_NIS] = solutionsIdeals (IFM);
    vectorDPlus = zeros(1,n); % initialization
    vectorDLess = zeros(1,n); % initialization
    
    % Finding the vectors D+ e D-    
    for i=1:m
        sumDPlus = 0;
        sumDLess = 0;
        for j=1:n
            sumDPlus = sumDPlus + (I4FN_discreteHammingDistace2(IFM.matrixD(i,j),vector_PIS(j)));
            sumDLess = sumDLess + (I4FN_discreteHammingDistace2(IFM.matrixD(i,j),vector_NIS(j)));
        end %for
        vectorDPlus(i) = sumDPlus;
        vectorDLess(i) = sumDLess;
    end %for
end %end matrixDistance


function vectorRC = relativeCloseness (IFM)
    order = size (IFM.matrixD);
    m = order(1);
    vectorRC = zeros(m,1);
    [vectorDPlus,vectorDLess] = distanceToIdeal (IFM);   
    
    for i=1:m
        vectorRC(i) = (vectorDLess(i))/(vectorDPlus(i)+vectorDLess(i));
    end %for    
end %relativeCloseness
