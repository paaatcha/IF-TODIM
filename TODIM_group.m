%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Algorithm TODIM group
%	
%	Authors: Andre Pacheco and Andre Siviero
%	Supervisors: Renato Krohling and Rodolfo Lourenzutti
%
%	This file is implemented the method of decision making TODIM group. Here,
%   it is assumed that the intuitionistic fuzzy decision matrix is already
%   normalized. It is also supposes that the weight vector is known or has 
%   been previously calculated.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function TODIM_group (Matrixes,teta,vWeights)
    order = size (Matrixes);
    nLin = order(1);
    nCol = order(2);
    
    order2 = size(Matrixes(1).matrixD);     
    LinMat = order2(1);
    
    MatrixFinal = zeros (LinMat,nCol);
    
    if (nLin ~= 1)
        error('Numbers lines of Matrixes is bigger than 1')
    end %if        
    
    for j=1:nCol
        vectorEi = TODIM (Matrixes(j),teta,vWeights);
        for i=1:LinMat
            MatrixFinal(i,j) = vectorEi(i);
        end %for        
    end%for
    
    MatrixFinal
    
    result = TODIM (MatrixFinal,teta,vWeights)
    
    
    
end %TODIM_group












