function [out] = vert(in)
%makes sure a vector is a column vector
% Taken from dynameas package of Soren Wainio-Theberge
% https://github.com/SorenWT/dynameas/

if size(in,2) > 1
   out = in';
else
    out = in;
end