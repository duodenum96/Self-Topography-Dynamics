function [LZComplexity] = LZC_estimation(series)
% LZC calculates the Lempel-Ziv complexity of a sequence.
%
% Version: 2.1
%
% Creation:   18th April 2006
% Last modification: 22th February 2015
% Taken from dynameas package of Soren Waınıo-Theberge
% https://github.com/SorenWT/dynameas/

% Set parameters
n = length(series);
b = n/log2(n);
threshold = median(series);

% Binary series of 'ones' (higher values than median) and 'zeros' (lower values than median) 
for j = 1:n
    if series(j) >= threshold
   	    series(j) = 1;
	else
   	    series(j) = 0;
    end
end

%% LZ algorithm
% Initialization
c = 1;	% Complexity is set to 1
S = series(1);
Q = series(2);

for i = 2:n
    SQ = [S,Q];
	SQ_pi = [SQ(1:(length(SQ)-1))];
    
    % Look for pattern Q inside SQ_pi
	k = findstr(Q,SQ_pi); 

	if length(k)==0
   	    % New sequence
        % New value of complexity
   	    c = c+1;				
        if (i+1)>n
            break;
        else
            % Updating
            S = [S,Q];
            Q = series(i+1);
        end
   else
        % Not new sequence
        if (i+1)>n
            break;
        else
            % Updating
            Q = [Q,series(i+1)];	
   	    end
    end
end

% Normalization (LZComplexity must be independent of the length of the series)
LZComplexity = c/b;
