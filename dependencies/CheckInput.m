function [torf] = CheckInput(cellin,name)
% Taken from dynameas package of Soren Wainio-Theberge
% https://github.com/SorenWT/dynameas/

torf = 0;

for c = 1:length(cellin)
    if ischar(cellin{c}) && strcmpi(cellin{c},name)
        torf = 1;
        break;
    end
end