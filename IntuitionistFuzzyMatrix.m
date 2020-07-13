%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% IntuiniotistFuzzyMatrix
%
% Authors: Andre Pacheco and Andre Siviero
% Supervisors: Renato Krohling and Rodolfo Lourenzutti
%
% This file contains the class Intuiniotist Fuzzy Matrix. Most of the definitions
% comes from Chen & Li paper "Dynamic multi-attribute decision making model based on triangular
% intuitionistic fuzzy numbers", published on Scientia Iranica and available through www.sciencedirect.com
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef IntuitionistFuzzyMatrix < handle % Handle proprierty assures that all copies of a object share the same data
    properties
        vector_cost_or_benefit
        matrixD
        vectorW
        
    end % properties
    
    methods
        
        %Constructor
        function ifm = IntuitionistFuzzyMatrix(vector_cost_or_benefit,matrixD,weightV)
            if nargin == 0
                return
            end
            ifm.vector_cost_or_benefit = vector_cost_or_benefit;
            ifm.matrixD = matrixD;
            order = size(matrixD);
            n = order(2);
            ifm.vectorW = weightV;
            
        end % Constructor
        
        function vectorR = calculateVectorRj (matrixFuzzy)
            order = size(matrixFuzzy.matrixD);
            m = order(1);
            n = order (2);
            sumRjs = IntuitionistFuzzyNumber([0 0 0 0],0,1); %Initialization
            %vectorR = IntuitionistFuzzyNumber([0 0 0 0],0,1); %Initialization
            
            for j=1:n
                sumRjs = IntuitionistFuzzyNumber([0 0 0 0],0,1);
                %for i=1:m
                %    sumRjs = sumRjs + matrixFuzzy.matrixD(i,j)
                %end % for
                sumRjs = sum(matrixFuzzy.matrixD(:,j));
                vectorR(j) = (sumRjs)*(1/m);
            end % for
        end % calculateRj
        
        
        function matrixM = calculateMatrixM (matrixFuzzy)
            %vectorR = IntuitionistFuzzyNumber([0 0 0 0],0,1); %Initialization
            vectorR = matrixFuzzy.calculateVectorRj;
            order = size(matrixFuzzy.matrixD);
            m = order(1);
            n = order (2);
            matrixM = zeros(m,n);
            
            for j=1:n
                for i=1:m
                    matrixM(i,j) = I4FN_fuzzyDistance(matrixFuzzy.matrixD(i,j),vectorR(j));
                end % for
                
                
            end % for
            
            matrixM
        end %calculateVectorMj
        
       function matrixP = normalizeMatrixM (matrixFuzzy)
            matrixM = matrixFuzzy.calculateMatrixM;
            order = size(matrixFuzzy.matrixD);
            m = order(1);
            n = order (2);
            matrixP = zeros(m,n);
            vAux = zeros(1,n);
%             
%             %find de max of the line
%             for i=1:m
%                 for j=1:n
%                     vAux(j)=matrixM(i,j);
%                 end %for
%                 vAux = sort(vAux);
%                 max = vAux(n)
%                 for j=1:n
%                     matrixP(i,j) = matrixM(i,j)/max;
%                 end %for
%             end % for
%             matrixP
%             
            %max = 0;
            for j = 1:n
                max_v = max(matrixM(:,j));
                for i=1:m
                    matrixP(i,j) = matrixM(i,j)/max_v;
                end % for
            end % for
            
            matrixP
        end %normalizeVectorMj
        
        % find entropy
        function en = entropy (matrixFuzzy)
            matrixP = matrixFuzzy.normalizeMatrixM;
            order = size(matrixFuzzy.matrixD);
            m = order(1);
            n = order (2);
            en = zeros (1,n);
            P = zeros (1,n);
            aux1 = 0; %buffer p1/sum pi
            aux2 = 0;
            
            for j=1:n
                for i=1:m
                    P(i) = matrixP(i,j);
                end %for
                
                for i=1:m
                    aux1 = (P(i))/sum(P);
                    aux2 = aux2 + (aux1*(log(aux1)));
                end %for
                en(j) = (-1/log(m))*aux2;
                aux2 = 0;
            end %for
            en
        end %entropy
        function weights(matrixFuzzy)
            en = matrixFuzzy.entropy;
            order = size(en);
            n = order(2);
            sumek = sum(en);
            for j=1:n
                matrixFuzzy.vectorW(j) = (1-en(j))/(n-sumek);
            end %for
        end %weights
        
        % Normalization for TODIM
        function normalizeDecisionMatrixTODIM (matrixFuzzy)
            order = size(matrixFuzzy.matrixD);
            m = order(1);
            n = order (2);
            vectorMax = zeros(n,1);
            vectorMin = zeros(n,1);
         
            for j=1:n                
                max = matrixFuzzy.matrixD(1,j).valuesSet(4);
                min = matrixFuzzy.matrixD(1,j).valuesSet(1);                
                for i=1:m
                    if max < matrixFuzzy.matrixD(i,j).valuesSet(4)
                        max = matrixFuzzy.matrixD(i,j).valuesSet(4);
                    end% if                    
                    if min > matrixFuzzy.matrixD(i,j).valuesSet(1)
                        min = matrixFuzzy.matrixD(i,j).valuesSet(1);
                    end %for                    
                end %for
                vectorMax(j) = max;
                vectorMin(j) = min;
            end %for
            
            
            for j=1:n
                if matrixFuzzy.vector_cost_or_benefit(j) == 0
                    for i=1:m
                        for v=1:4
                            aux(v) = (vectorMax(j)-matrixFuzzy.matrixD(i,j).valuesSet(v))/(vectorMax(j)-vectorMin(j));                            
                        end %for
                        for v=1:4
                        	matrixFuzzy.matrixD(i,j).valuesSet(5-v) = aux(v);
                        end%for
                    end %for
                elseif matrixFuzzy.vector_cost_or_benefit(j) == 1
                    for i=1:m
                        for v=1:4
                            matrixFuzzy.matrixD(i,j).valuesSet(v) = (matrixFuzzy.matrixD(i,j).valuesSet(v)-vectorMin(j))/(vectorMax(j)-vectorMin(j));
                        end %for    
                    end %for                    
                end%if
            end %for
            
        end %normalizeMatrixD        
        
        
        
        % Normalize Decision Matrix
        function normalizeDecisionMatrix(fuzzyMatrix)
            order = size(fuzzyMatrix.matrixD);
            m = order(1);
            n = order (2);
            
            for j = 1:n
                d_values = zeros(m,1);
                
                % Getting d values
                for i=1:m
                    d_values(i) = fuzzyMatrix.matrixD(i,j).valuesSet(4);
                end % for i
                vectorAux = sort(d_values);
                max_d = vectorAux(m);
                min_d = vectorAux(1);
                
                % Normalization
                if fuzzyMatrix.vector_cost_or_benefit(j) == 1 % benefit
                    for i = 1:m
                        for k = 1:4
                            fuzzyMatrix.matrixD(i,j).valuesSet(k) = fuzzyMatrix.matrixD(i,j).valuesSet(k)/max_d;
                        end % for k
                    end % for i
                else % cost
                    for i = 1:m
                        buffer = fuzzyMatrix.matrixD(i,j).valuesSet;
                        for k = 1:4
                            
                            fuzzyMatrix.matrixD(i,j).valuesSet(k) = min_d / buffer(5-k);
                            
                        end % for k
                    end % for i
                    
                end % if
                
            end % for j
            
        end % Normalize Decision Matrix
        
        % Aggregate Intuitionist Fuzzy Matrixes - as described in Ye
        function IFM_result = aggregateFuzzyMatrixes(IFM_Vector, decisionMakersWeightVector)
        	
        	%IFM_result = IntuitionistFuzzyMatrix;
        	
        	% Validations

		% Check if parameters are vectors
		orderMatrixVector = size(IFM_Vector);
	    	m_ifm = orderMatrixVector(1);
		n_ifm = orderMatrixVector(2); 	
		
		orderWeightVector = size(decisionMakersWeightVector);
	    m_dmwv = orderWeightVector(1);
		n_dmwv = orderWeightVector(2); 	
		
		
        	if m_ifm ~= 1 && n_ifm ~=1   % not a vector
        		error('Parameter passed as IFM_Vector is not a vector')
        	end
        	
        	if m_dmwv ~=1 && n_dmwv ~=1  % not a vector
        		error('Parameter passed as decisionMakersWeightVector is not a vector')
            end
            
            if m_dmwv == 1 && n_dmwv ~=1 % vectorize to use in TIFN_WAA
                decisionMakersWeightVector = decisionMakersWeightVector';
            end
        	
        	% Check if number of matrix equals the number of decision makers
        	nFuzzyMatrixes = length(IFM_Vector);
        	nDecisionMatrixes = length(decisionMakersWeightVector);
        	
        	if nFuzzyMatrixes ~= nDecisionMatrixes
        		error('Number of Matrixes and Decision Makers differ')
        	end
        	
        	% Check if all decision matrixes are of same order
        	buffer = size(IFM_Vector(1).matrixD);
            m_decisionMatrix = buffer(1)
            n_decisionMatrix = buffer(2)
        	
        	for i = 1:nFuzzyMatrixes
        		if isequal(buffer,size(IFM_Vector(i).matrixD)) == 0
        			error('There are matrixes of different orders ion IFM_Vector')
        		end
        		
        	end % for
            
            % Check for consistency on cost and benefit vectors
            buffer_costbenefit = IFM_Vector(1).vector_cost_or_benefit;
        	for i = 1:nFuzzyMatrixes
        		if isequal(buffer_costbenefit,IFM_Vector(i).vector_cost_or_benefit) == 0
        			error('Inconsistent definitions on cost and benefit')
        		end
        		
        	end % for
            
            
            
        	
        	% End of Validations
        	
        	% Building the Aggregated Decision Matrix
        	
            for i = 1:m_decisionMatrix
                for j=1:n_decisionMatrix
                        aggregated_D(i,j) = IntuitionistFuzzyNumber;
                    for k = 1:nFuzzyMatrixes
                        aggregated_D(i,j) = aggregated_D(i,j) + ...
                            IFM_Vector(k).matrixD(i,j) * decisionMakersWeightVector(k);
                    end % for
                end %for
            end % for
            
            % Aggregated Weight Vector - Not to confuse this with the
            % decisionMakersWeightVector
            
            % Build weights matrix
            for i = 1:nFuzzyMatrixes
                for j = 1:n_decisionMatrix
                    weightMatrix(i,j) = IFM_Vector(i).vectorW(j);                     
                end %for
            end %for
            
            weightMatrix
            
            % Aggregate Criteria            
            for i = 1:n_decisionMatrix
                aggregated_vectorW(i) = TIFN_WAA(weightMatrix(:,i),decisionMakersWeightVector);
            end %for
            
            %aggregated_vectorW
            
            % Build the result
            IFM_result = IntuitionistFuzzyMatrix(buffer_costbenefit,aggregated_D,aggregated_vectorW);
            
        end % Aggregate
        
        % Apply Weights
        function applyWeights(I4FN_Matrix)
            
            order = size(I4FN_Matrix.matrixD);
            
            for i = 1:order(1)
                for j = 1:order(2)
                    I4FN_Matrix.matrixD(i,j) = I4FN_Matrix.matrixD(i,j) * I4FN_Matrix.vectorW(j);
                end % for j
            end % for i
            
        end % function
        
        
    end %methods
    
end %classdef
