function [outthing] = EasyParse(cellin,name,value)
% Taken from dynameas package of Soren Wainio-Theberge
% https://github.com/SorenWT/dynameas/

outthing = 0;


if isempty(cellin)
   return; 
end



if nargin < 3
    %if no value is supplied
    for c = 1:length(cellin)
        if ischar(cellin{c}) && strcmpi(cellin{c},name)
            outthing = cellin{c+1};
            break;
        end
    end
else
    for c = 1:length(cellin)
        if ischar(cellin{c}) && strcmpi(cellin{c},name) && strcmpi(cellin{c+1},value)
            outthing = 1;
            break;
        end
    end
    
end
