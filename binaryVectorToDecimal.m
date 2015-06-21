function out = binaryVectorToDecimal( input )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
out = 0;
for ii=0:length(input)-1
    out = out + input(ii + 1) * 2^(ii);
end

end

