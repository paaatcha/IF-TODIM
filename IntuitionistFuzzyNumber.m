%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Intuitionist Fuzzy Number Class
%	
%	Authors: Andre Pacheco and Andre Siviero
%	Supervisors: Renato Krohling and Rodolfo Lourenzutti
%
%	This file contains the Intuitionist Fuzzy Number class definition. Most of the definitions
%	come from Chen & Li paper "Dynamic multi-attribute decision making model based on triangular
%	intuitionistic fuzzy numbers", published on Scientia Iranica and available through www.sciencedirect.com, however
%	we are expanding to trapezoidal numbers.
%
%	An intuitionist fuzzy number is defined as a tuple of values defining its pertinence interval, and the confidence
%	and non-confidence of the information, defined as crisp values.
%
%	In this file we define the IntuitionistFuzzyNumberClass, its constructor, pertinence and non-pertinence,fuzzy addition, 
%	multiplication, distance and TFN_WAA (an operator defined by Chen & Li).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef IntuitionistFuzzyNumber < handle % Handle proprierty assures that all copies of a object share the same data
	properties 
		valuesSet
		informationConfidence = 1;
		informationNonConfidence = 0;
	end % properties
	
	methods
		
		%Constructor
		function ifn = IntuitionistFuzzyNumber(valuesSet,informationConfidence,informationNonConfidence)
			if nargin == 0 
		        ifn.valuesSet = zeros(1,4);
                ifn.informationConfidence = 0;
                return			
			end
			
			if isequal(size(valuesSet),[1 4]) || isequal(size(valuesSet),[4 1]) % trapezoidal Intuitionistic Fuzzy Number (I4FN)
				ifn.valuesSet = valuesSet;	
			elseif	isequal(size(valuesSet),[1 3]) || isequal(size(valuesSet),[3 1]) % triangular Intuitionistic Fuzzy Number (I3FN)
				auxValuesSet = zeros(1,4);
				auxValuesSet(1) = valuesSet(1);
				auxValuesSet(2) = valuesSet(2);
				auxValuesSet(3) = valuesSet(2);
				auxValuesSet(4) = valuesSet(3);												
				ifn.valuesSet = auxValuesSet;	
			else	
				error('Values Set is not a 4-element array')
			end
			
			
			if nargin >= 2 	
				ifn.informationConfidence = informationConfidence;
			end
			
			if nargin >= 3
				ifn.informationNonConfidence = informationNonConfidence;
			end

			
		end % Constructor
		
		% Display Function
		function display(I4FN)
			sizeI4FN = size(I4FN);
			
			% Single Fuzzy Number
			if(isequal(sizeI4FN,[1 1]))
				disp(' ')
				disp([inputname(1) ' =']);
				disp(' ');
				fprintf(1,'< ( %g , %g , %g , %g ) , %g , %g >',I4FN.valuesSet(1),I4FN.valuesSet(2),I4FN.valuesSet(3),I4FN.valuesSet(4),I4FN.informationConfidence, I4FN.informationNonConfidence)	
				disp(' ');
				
			% Matrix of Fuzzy Numbers
			else
				disp(' ')
				disp([inputname(1) ' =']);
				disp(' ');
				rows = sizeI4FN(1);
				columns = sizeI4FN(2);
				
				for i = 1:rows
					for j = 1:columns;
						fprintf(1,'< ( %g , %g , %g , %g ) , %g , %g >	',I4FN(i,j).valuesSet(1),I4FN(i,j).valuesSet(2),I4FN(i,j).valuesSet(3),I4FN(i,j).valuesSet(4),I4FN(i,j).informationConfidence, I4FN(i,j).informationNonConfidence)	

					end
					disp(' ');
				end
			end
			disp(' ');	
		end % Display
		
		
		
		% Pertinence Function - as defined in Chen & Li
		function pertinence = I4FN_pertinence(I4FN,x)
		    if x >= I4FN.valuesSet(1) && x < I4FN.valuesSet(2)
		        pertinence = (x-I4FN.valuesSet(1))*I4FN.informationConfidence / (I4FN.valuesSet(2) - I4FN.valuesSet(1));
		    elseif x >= I4FN.valuesSet(2) && x <= I4FN.valuesSet(3)
		        pertinence = I4FN.informationConfidence;
		    elseif x > I4FN.valuesSet(3) && x < I4FN.valuesSet(4)
		        pertinence = (I4FN.valuesSet(4)-x)*I4FN.informationConfidence / (I4FN.valuesSet(4) - I4FN.valuesSet(3));
		        else pertinence = 0;
		    end
		end % Pertinence function
		
		% Non-pertinence function - similar
		function non_pertinence = I4FN_non_pertinence(I4FN,x)
		    if x >= I4FN.valuesSet(1) && x < I4FN.valuesSet(2)
		        non_pertinence = (I4FN.valuesSet(2) - x + I4FN.informationNonConfidence*(x-I4FN.valuesSet(1))) / (I4FN.valuesSet(2) - I4FN.valuesSet(1));
		    elseif x >= I4FN.valuesSet(2) && x <= I4FN.valuesSet(3)
		        non_pertinence = I4FN.informationNonConfidence;
		    elseif x > I4FN.valuesSet(3) && x < I4FN.valuesSet(4)
		        non_pertinence = (x - I4FN.valuesSet(3) + I4FN.informationNonConfidence*(I4FN.valuesSet(4))) / (I4FN.valuesSet(4) - I4FN.valuesSet(3));
		        else non_pertinence = 1;
		    end
		end % Non Pertinence function

		% Pi Function
        function pi = I4FN_pi(I4FN,x)
            pi = 1 - I4FN.I4FN_pertinence(x) - I4FN.I4FN_non_pertinence(x);
        end % pi
        
        %minus
        %TODO implementar a sobrecarga da subtração (se existir)
        
		% Plus
		function ifn_result = plus(ifn_a, ifn_b)
		  ifn_result = IntuitionistFuzzyNumber;
		  for j=1:4
		    ifn_result.valuesSet(j) = ifn_a.valuesSet(j) + ifn_b.valuesSet(j);
		  end
		  ifn_result.informationConfidence = ifn_a.informationConfidence + ifn_b.informationConfidence -(ifn_a.informationConfidence*ifn_b.informationConfidence);
		  ifn_result.informationNonConfidence = ifn_a.informationNonConfidence*ifn_b.informationNonConfidence;
		end % sum
		
		% Product By Scalar or by fuzzy number
		function ifn_result = mtimes(param_1, param_2)
            ifn_result = IntuitionistFuzzyNumber;
            flag = 0;
            if isa(param_1,'IntuitionistFuzzyNumber') && isa(param_2,'IntuitionistFuzzyNumber')
                I4FN = param_1;
                I4FN_2 = param_2;
                flag = 1;
            elseif isa(param_1,'IntuitionistFuzzyNumber')
                I4FN = param_1;
                lambda = param_2;              
            elseif isa(param_2,'IntuitionistFuzzyNumber')
                I4FN = param_2;
                lambda = param_1;                          
            end
            
            if flag == 0
                if lambda >= 0
                    for j=1:4
                        ifn_result.valuesSet(j) = I4FN.valuesSet(j) * lambda;
                    end
                else
                    for j=1:4
                        ifn_result.valuesSet(5-j) = I4FN.valuesSet(j) * lambda;
                    end
                end
                ifn_result.informationConfidence = 1 - (1-I4FN.informationConfidence)^lambda;
                ifn_result.informationNonConfidence = (I4FN.informationNonConfidence)^lambda;
            else
                for j=1:4
                    ifn_result.valuesSet(j) = I4FN.valuesSet(j) * I4FN_2.valuesSet(j);
                    ifn_result.informationConfidence = I4FN.informationConfidence * I4FN_2.informationConfidence;
                    ifn_result.informationNonConfidence = I4FN.informationNonConfidence + I4FN_2.informationNonConfidence - I4FN.informationNonConfidence * I4FN_2.informationNonConfidence;
                end %for
            end % if
		end % product by scalar or fuzzy number
        
        % power fuzzy number by scalar
        function ifn_result = mpower (ifn,a)
            ifn_result = IntuitionistFuzzyNumber;

            for j=1:4
                ifn_result.valuesSet(j) = (ifn.valuesSet(j))^a;
            end  
            ifn_result.informationConfidence = ifn.informationConfidence^a;
            ifn_result.informationNonConfidence = 1 - ((1-ifn.informationNonConfidence)^a);            
        end %mpower
        
        function ifn_result = sum(I4FN_vector)
            % Validation
            
            % Checks if input is an array
            I4FN_size = size(I4FN_vector);
            
            if (I4FN_size(1) ~= 1 && I4FN_size(2) ~= 1) || ...
                (min(I4FN_size) ~= 1)
                
                error('Input arguments are inconsistent');
            end % if
            
            ifn_result = IntuitionistFuzzyNumber([0 0 0 0],0,1); %Initialization
            for i=1:max(I4FN_size)
                ifn_result = ifn_result + I4FN_vector(i);
            end %for
        end % sum
        
        %This function return 1 if ifn_1 is bigger than ifn2, -1 if ifn_1
        %is smaller than inf_2 and 0 if both are equal
        %DefinedSome Arithmetic Aggregation Operators within 
        %Intuitionistic Trapezoidal Fuzzy Setting and Their 
        %Application to Group Decision Making 
        function result = cmp (ifn_1,ifn_2)            
            %number fuzzy 1
            a1 = ifn_1.valuesSet(1);
            b1 = ifn_1.valuesSet(2);
            c1 = ifn_1.valuesSet(3);
            d1 = ifn_1.valuesSet(4);
            u1 = ifn_1.informationConfidence;
            v1 = ifn_1.informationNonConfidence;            
            
            %number fuzzy 2
            a2 = ifn_2.valuesSet(1);
            b2 = ifn_2.valuesSet(2);
            c2 = ifn_2.valuesSet(3);
            d2 = ifn_2.valuesSet(4);
            u2 = ifn_2.informationConfidence;
            v2 = ifn_2.informationNonConfidence;               
            
            %finding I's,S's and H's
            I1 = ((a1+b1+c1+d1)*(1+u1-v1))/8;
            S1 = I1*(u1-v1);
            H1 = I1*(u1+v1);
            
            I2 = ((a2+b2+c2+d2)*(1+u2-v2))/8;
            S2 = I2*(u2-v2);
            H2 = I2*(u2+v2);
            
            
            
            %Comparison
            if S1 > S2
                result = 1;
            elseif S1 < S2
                result = -1;
            elseif S1 == S2
                if H1 > H2
                    result = 1;
                elseif H1 < H2
                    result = -1;
                elseif H1 == H2
                    result = 0;                    
                end%if
            end%if           
        end %cmp
        

		% Fuzzy Distance - As defined in Chen & Li

		function distance = I4FN_fuzzyDistance(I4FN_A,I4FN_B)
			distance = sqrt(0.5 * ( ...
                                    (I4FN_A.informationConfidence - I4FN_B.informationConfidence)^2 + ...
                                    (I4FN_A.informationNonConfidence - I4FN_B.informationNonConfidence)^2 +...
                                    (I4FN_A.informationConfidence + I4FN_A.informationNonConfidence - I4FN_B.informationConfidence - I4FN_B.informationNonConfidence)^2 ...
                                    ))...
                                    + sqrt(I4FN_auxIntegral(I4FN_A,I4FN_B));
                                %distance = distance*3;
		end % distance
		
			% Auxiliary functions to fuzzy distance
			% Most users will never need to touch these. For details on why they're here, refer to the pdf "distance integral calculus"
			
			% alpha function
			function auxAlpha = I4FN_auxAlpha(I4FN_A,I4FN_B)
				auxAlpha = (I4FN_A.valuesSet(2) - I4FN_A.valuesSet(1)) - (I4FN_B.valuesSet(2) - I4FN_B.valuesSet(1));
			end % alfa
			
			% beta function
			function auxBeta = I4FN_auxBeta(I4FN_A,I4FN_B)
				auxBeta = (I4FN_B.valuesSet(4) - I4FN_B.valuesSet(3)) - (I4FN_A.valuesSet(4) - I4FN_A.valuesSet(3));
			end % beta
			
			% integral function
			function integral = I4FN_auxIntegral(I4FN_A,I4FN_B)
				% auxiliary vars
				alpha = I4FN_auxAlpha(I4FN_A,I4FN_B);
				beta = I4FN_auxBeta(I4FN_A,I4FN_B);
				aa_minus_ab = I4FN_A.valuesSet(1) - I4FN_B.valuesSet(1);
				da_minus_db = I4FN_A.valuesSet(4) - I4FN_B.valuesSet(4);
				
				integral = (alpha^2 + beta^2)/3 + alpha*aa_minus_ab + beta*da_minus_db + (aa_minus_ab)^2 + (da_minus_db)^2;
			
			end % integral
            
            
            
            
        % Defuzzification via Center of Area (Angelov) - please refer to
        % 'defuzz calculation.pdf' to further explanation in this code
        function defuzz = I4FN_defuzzificationCOA(I4FN)
            
            % Numerator
            defuzz = (I4FN.valuesSet(2)^3 - I4FN.valuesSet(1)^3)/3 * (1 + I4FN.informationConfidence - I4FN.informationNonConfidence) / (I4FN.valuesSet(2)-I4FN.valuesSet(1)) +  ...
                (I4FN.valuesSet(2)^2 - I4FN.valuesSet(1)^2)/2 * (I4FN.valuesSet(1)*I4FN.informationNonConfidence - I4FN.valuesSet(2) - I4FN.valuesSet(1)*I4FN.informationConfidence) / (I4FN.valuesSet(2)-I4FN.valuesSet(1)) + ...
                (I4FN.valuesSet(3)^2 - I4FN.valuesSet(2)^2)/2 * (I4FN.informationConfidence-I4FN.informationNonConfidence) + ...
                (I4FN.valuesSet(4)^3 - I4FN.valuesSet(3)^3)/3 * (I4FN.informationNonConfidence - I4FN.informationConfidence - 1) / (I4FN.valuesSet(4)-I4FN.valuesSet(3)) +  ...
                (I4FN.valuesSet(4)^2 - I4FN.valuesSet(3)^2)/2 * (I4FN.valuesSet(4)*I4FN.informationConfidence + I4FN.valuesSet(3) - I4FN.valuesSet(4)*I4FN.informationNonConfidence) / (I4FN.valuesSet(4)-I4FN.valuesSet(3));
            
            % Denominator
            defuzz = defuzz / ( ...
                (I4FN.valuesSet(2)^2 - I4FN.valuesSet(1)^2)/2 * (1 + I4FN.informationConfidence - I4FN.informationNonConfidence) / (I4FN.valuesSet(2)-I4FN.valuesSet(1)) +  ...
                (I4FN.valuesSet(1)*I4FN.informationNonConfidence - I4FN.valuesSet(2) - I4FN.valuesSet(1)*I4FN.informationConfidence) + ...
                (I4FN.valuesSet(3) - I4FN.valuesSet(2)) * (I4FN.informationConfidence-I4FN.informationNonConfidence) + ...
                (I4FN.valuesSet(4)^2 - I4FN.valuesSet(3)^2)/2 * (I4FN.informationNonConfidence - I4FN.informationConfidence - 1) / (I4FN.valuesSet(4)-I4FN.valuesSet(3)) +  ...
                (I4FN.valuesSet(4)*I4FN.informationConfidence + I4FN.valuesSet(3) - I4FN.valuesSet(4)*I4FN.informationNonConfidence) ...
            );
        end % function
        
        % Defuzzification via Centroid (Varghese & Kuriakose) - please refer to
        % 'defuzz calculation 2.pdf' to further explanation in this code
        function defuzz = I4FN_defuzzificationCentroid(I4FN)
            
            % Numerator
            defuzz = (I4FN.valuesSet(2)-I4FN.valuesSet(1))*(I4FN.valuesSet(1)+2*I4FN.valuesSet(2))*(1+I4FN.informationConfidence-I4FN.informationNonConfidence)/12 + (I4FN.valuesSet(3)^2-I4FN.valuesSet(2)^2)*(I4FN.informationConfidence-I4FN.informationNonConfidence+1)/4 + (I4FN.informationConfidence-I4FN.informationNonConfidence+1)*(I4FN.valuesSet(4)-I4FN.valuesSet(3))*(2*I4FN.valuesSet(3)+I4FN.valuesSet(4))/12;
            
            % Denominator
            defuzz = defuzz / ( ...
                (I4FN.valuesSet(2)-I4FN.valuesSet(1))*(I4FN.informationConfidence-I4FN.informationNonConfidence+1)/4 + (I4FN.valuesSet(3)-I4FN.valuesSet(2))*(I4FN.informationConfidence-I4FN.informationNonConfidence+1)/2 + (I4FN.valuesSet(4)-I4FN.valuesSet(3))*(I4FN.informationConfidence-I4FN.informationNonConfidence+1)/4 ...
            );
        end % function
        
        % Defuzzification via Center of Area (Angelov) - DISCRETE
        function defuzz = I4FN_defuzzificationCOADiscrete(ifn)
            n = 100; %interval size
            min = ifn.valuesSet(1);
            max = ifn.valuesSet(4);
            interval = (max - min)/n; 
            numerator = 0;
            denominator = 0;
            
            for i=1:n
                xi = (i-1)*interval + min;
                numerator = numerator + (ifn.I4FN_pertinence(xi) - ifn.I4FN_non_pertinence(xi))*xi;
                denominator = denominator + (ifn.I4FN_pertinence(xi) - ifn.I4FN_non_pertinence(xi));
            end %for            
            defuzz = numerator/denominator;           
        end %I4FN_defuzzificationCOADiscrete
        
        
        % Discrete Fuzzy Distance
  		function distance = I4FN_discreteFuzzyDistance(ifn_a,ifn_b)
            sum_d = 0;
            n = 100; %interval size
            min_a = min(ifn_a.valuesSet(1),ifn_b.valuesSet(1));
            max_d = max(ifn_a.valuesSet(4),ifn_b.valuesSet(4));
            interval = (max_d - min_a)/n;            

            for i=1:n
                xi = (i-1)*interval + min_a;
                sum_d = sum_d + (abs(ifn_a.I4FN_pertinence(xi) - ifn_b.I4FN_pertinence(xi)) + ...
                      abs(ifn_a.I4FN_non_pertinence(xi) - ifn_b.I4FN_non_pertinence(xi)) + ...
                      abs(ifn_a.I4FN_pi(xi) - ifn_b.I4FN_pi(xi)));
            end %for
            distance = 0.5*sum_d/1000;
            
        end % function
        

        % Euclidean Distace - As defined in Guha & Chakraborty
        function distance = I4FN_discreteEuclideanDistance(ifn_a,ifn_b)
            n = 1000; % interval size
            %interval_a = (ifn_a.valuesSet(4)-ifn_a.valuesSet(1))/n;
            %interval_b = (ifn_b.valuesSet(4)-ifn_b.valuesSet(1))/n;            
            min_a = min(ifn_a.valuesSet(1),ifn_b.valuesSet(1));
            max_d = max(ifn_a.valuesSet(4),ifn_b.valuesSet(4));
            interval = (max_d - min_a)/n;
            sum_d = 0;
            
            for i=1:n+1
                xi = (i-1)*interval + min_a;
                sum_d = sum_d + ((ifn_a.I4FN_pertinence(xi) - ifn_b.I4FN_pertinence(xi))^2) + ((ifn_a.I4FN_non_pertinence(xi) - ifn_b.I4FN_non_pertinence(xi))^2);
            end %for
            distance = sqrt(sum_d/(2*n));
            
        end %I4FN_euclideanDistace
        
        % Hamming Distace - As defined in Guha & Chakraborty
        function distance = I4FN_discreteHammingDistance(ifn_a,ifn_b)
            n = 100; % interval size
            min_a = min(ifn_a.valuesSet(1),ifn_b.valuesSet(1));
            max_d = max(ifn_a.valuesSet(4),ifn_b.valuesSet(4));
            interval = (max_d - min_a)/n;            
            sum_d = 0;
            
            for i=1:n+1
                xi = (i-1)*interval + min_a;
                sum_d = sum_d + (abs(ifn_a.I4FN_pertinence(xi) - ifn_b.I4FN_pertinence(xi))) + (abs(ifn_a.I4FN_non_pertinence(xi) - ifn_b.I4FN_non_pertinence(xi)));
            end %for
            distance =(sum_d/(2*n));
            
        end %I4FN_hammingDistace  
        
        % Discrete Fuzzy Distance 2 - As defined in Fei Ye in Definition 2.3
        function distance = I4FN_discreteFuzzyDistance2(ifn_a,ifn_b)
            n = 100; % interval size
            min_a = min(ifn_a.valuesSet(1),ifn_b.valuesSet(1));
            max_d = max(ifn_a.valuesSet(4),ifn_b.valuesSet(4));
            interval = (max_d - min_a)/n;           
            sum_d = 0;
            
            for i=1:n+1
                xi = (i-1)*interval + min_a;               
                sum_d = sum_d + ((ifn_a.I4FN_pertinence(xi) - ifn_b.I4FN_pertinence(xi))^2) + ((ifn_a.I4FN_non_pertinence(xi) - ifn_b.I4FN_non_pertinence(xi))^2) + ((ifn_a.I4FN_pi(xi) - ifn_b.I4FN_pi(xi))^2);
            end %for
            distance =sqrt(sum_d/2);
            
        end %I4FN_discreteFuzzyDistance2          

        % Euclidean Distace 2
        function distance = I4FN_discreteEuclideanDistance2(ifn_a,ifn_b)
            n = 1000; % interval size
            %interval_a = (ifn_a.valuesSet(4)-ifn_a.valuesSet(1))/n;
            %interval_b = (ifn_b.valuesSet(4)-ifn_b.valuesSet(1))/n;   
            min_a = min(ifn_a.valuesSet(1),ifn_b.valuesSet(1));
            max_d = max(ifn_a.valuesSet(4),ifn_b.valuesSet(4));
            interval = (max_d - min_a)/n;
            sum_d = 0;
            
            for i=1:n+1
                xi = (i-1)*interval + min_a;
                sum_d = sum_d + ((ifn_a.I4FN_pertinence(xi) - ifn_b.I4FN_pertinence(xi))^2) + ((ifn_a.I4FN_non_pertinence(xi) - ifn_b.I4FN_non_pertinence(xi))^2);
            end %for
            distance = sqrt(sum_d/(2*n));
            
        end %I4FN_euclideanDistace
      
       % defined in Guiwu Wei, definition 3
       function distance = I4FN_discreteHammingDistace2 (ifn_1,ifn_2)
        % number fuzzy 1
        a1 = ifn_1.valuesSet(1);
        b1 = ifn_1.valuesSet(2);
        c1 = ifn_1.valuesSet(3);
        d1 = ifn_1.valuesSet(4);
        u1 = ifn_1.informationConfidence;
        v1 = ifn_1.informationNonConfidence;
       
       % number fuzzy 2
        a2 = ifn_2.valuesSet(1);
        b2 = ifn_2.valuesSet(2);
        c2 = ifn_2.valuesSet(3);
        d2 = ifn_2.valuesSet(4);                        
        u2 = ifn_2.informationConfidence;        
        v2 = ifn_2.informationNonConfidence;

        alpha = (1+u1-v1); % auxiliary vars
        beta = (1+u2-v2);% auxiliary vars
        
        distance = 0.125 * (abs(alpha*a1 - beta*a2) + abs(alpha*b1 - beta*b2) + abs(alpha*c1 - beta*c2) + abs(alpha*d1 - beta*d2));        
       end %I4FN_discreteHammingDistace2
        
        
	end % methods			
end % classdef










