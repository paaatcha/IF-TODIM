%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Algorithm TODIM
%	
%	Authors: Andre Pacheco and Andre Siviero
%	Supervisors: Renato Krohling and Rodolfo Lourenzutti
%
%	In this file is implemented the method of decision making TODIM. Here,
%   it is assumed that the intuitionistic fuzzy decision matrix is already
%   normalized. It is also supposes that the weight vector is known or has 
%   been previously calculated.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function Ei = TODIM (IFM,teta,vWeights)
if isa(IFM,'IntuitionistFuzzyMatrix') || isa (IFM,'IVIFN')
    matrixD = IFM.matrixD;
    weights = IFM.vectorW;
else
    matrixD = IFM;
    weights = vWeights;
end %if

order = size(matrixD);
nLin = order(1); %number lines
nCol = order(2);% number coluns

c_ref = reference (weights); %reference
Ei = valueGlobal (matrixD,nLin,nCol,teta,c_ref,weights);
end

%choosing the benchmark according to their weight
function ref = reference (weights)
    order = size(weights);
    nCol = order(2);
    max = 0;
    ref = 1;
    for j=1:nCol
        if max < weights(j)
            max = weights(j);
            ref = j;
        end %if
    end% for
end %reference

%here may change the distance
function d = distance (matrixD,alt_i,alt_j,c)
    if isa(matrixD(alt_i,c),'IntuitionistFuzzyNumber')
        d = I4FN_discreteHammingDistace2(matrixD(alt_i,c),matrixD(alt_j,c));
    elseif isa(matrixD(alt_i,c),'IVIFN')
        d = DiscreteDistanceIVIFN(matrixD(alt_i,c),matrixD(alt_j,c));
    else
        d = matrixD(alt_i,c) - matrixD(alt_j,c);
    end %if   
end %distance

%defuzz defined in Khroling & Tatagiba
%function m = defuzzified (matrixD,i,j)
%    a1 = matrixD (i,j).valuesSet(1);
%    a2 = matrixD (i,j).valuesSet(2);
%    a3 = matrixD (i,j).valuesSet(3);
%    a4 = matrixD (i,j).valuesSet(4);    
%    m = (a1+a2+a3+a4)/4;    
%    u = matrixD (i,j).informationConfidence;
%    v = matrixD (i,j).informationNonConfidence;
    
%    m = m - m*(1-u)/2 - (m*v)/2;    
%end %defuzzified

function c = comparison (matrixD,alt_i,alt_j,c)
    %dm = I4FN_defuzzificationCOA(matrixD(alt_i,c)) - I4FN_defuzzificationCOA (matrixD(alt_j,c));
    %dm = defuzzified (matrixD,alt_i,c) - defuzzified (matrixD,alt_j,c);
    if isa(matrixD(alt_i,c),'IntuitionistFuzzyNumber')
        c = cmp (matrixD(alt_i,c),matrixD(alt_j,c));
    elseif isa(matrixD(alt_i,c),'IVIFN')
        c = cmpIVIFN (matrixD(alt_i,c),matrixD(alt_j,c));
    else
        c = matrixD(alt_i,c) - matrixD(alt_j,c);
    end %if
end %diferenceFuzzified

%alternance
function a = arc (weights,c,ref)
    a = weights(c)/weights(ref);
end %arcs

%sum alternances
function sa = sum_arc (weights,nCol,ref)
    sa = 0;
    for c=1:nCol
        sa = sa + arc(weights,c,ref);
    end % for    
end %sum_arc

%finding the matrix relevance
function matrixPhi = phi (matrixD,nLin,nCol,teta,ref,weights)
    matrixPhi = zeros(nCol,nLin,nLin);    
    for c = 1:nCol    
        for i = 1:nLin
            for j = 1:nLin    
                d_ij = distance(matrixD,i,j,c);
                m_ij = comparison(matrixD,i,j,c);
                if m_ij == 0
                    matrixPhi(c,i,j) = 0;  
                    %mat = matrixPhi(c,i,j);
                    %d = d_ij
                elseif m_ij > 0
                    matrixPhi(c,i,j) = sqrt(arc(weights,c,ref)*(d_ij)/(sum_arc (weights,nCol,ref))); 
                    %mat = matrixPhi(c,i,j);
                    %d = d_ij
                elseif m_ij < 0
                    matrixPhi(c,i,j) = ((-1)/teta)*sqrt(sum_arc(weights,nCol,ref)*(abs(d_ij))/(arc(weights,c,ref)));
                    %mat = matrixPhi(c,i,j);
                    %d = d_ij
                end %if
            end %for
        end %for
    end %for
end %phi

%finding the matrix relevance global
function matrixDelta = delta (matrixD,nLin,nCol,teta,ref,weights)
    matrixPhi = phi(matrixD,nLin,nCol,teta,ref,weights);
    
    %printPhi (matrixPhi);
    
    matrixDelta = zeros(nLin,nLin);
    for i = 1:nLin
        for j = 1:nLin
            for c = 1:nCol
                matrixDelta(i,j) = matrixDelta(i,j) + matrixPhi(c,i,j);
            end %for
        end %for
    end %for    
end %delta

% Finding Ranking and normalization
function finalValueNormalized = valueGlobal (matrixD,nLin,nCol,teta,ref,weights)
    matrixDelta = delta (matrixD,nLin,nCol,teta,ref,weights);

  
    min = zeros(nLin,1);
    max = zeros(nLin,1);
    
    for j = 1:nLin
        for i = 1:nLin
            if matrixDelta(i,j) < min(i)
                min(i) = matrixDelta(i,j);
            elseif matrixDelta(i,j) > max(i)
                max(i) = matrixDelta(i,j);
            end %for
        end% for
    end% for   
    
    finalValue = zeros(nLin,1);
    for i=1:nLin
        a=0; %aux
        b=0; %aux
        c=0; %aux
        
        for j = 1:nLin
            a = a + matrixDelta(i,j);
        end %for
        
        for j = 1:nLin
            b = b + min(j);
        end %for
        
        for j = 1:nLin
            c = c + max(j);
        end
        finalValue(i) = (a + b) / (c - b);
    end% for    
    
    valueMin = finalValue(1);
    for i = 1:nLin
        if finalValue(i) < valueMin
            valueMin = finalValue(i);
        end
    end

    finalValuePositive = zeros(nLin,1);
    for i = 1:nLin
        finalValuePositive(i) = finalValue(i) - valueMin;
    end

    valueMax = finalValuePositive(i);
    for i = 1:nLin
        if finalValuePositive(i) > valueMax
            valueMax = finalValuePositive(i);
        end
    end

    finalValueNormalized = zeros(nLin,1);
    
    for i = 1:nLin
        finalValueNormalized(i) = finalValuePositive(i) / valueMax;
    end
    finalValueNormalized
    bar(finalValueNormalized)  
end %valueGlobal














