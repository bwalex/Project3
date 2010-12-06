function y = ampl(x)
     %AMPL          Find amplitudes of a 128 element complex
     %              vector. Result is "wrapped round" to negative
     %              frequencies for plotting with axis defined
     %              by FAXIS function.
     [a b]=size(x);
     if (a>b),
          x=x';
     end
     temp=abs(x);
     len = length(temp);
     y=[temp(len/2+1:len) temp(1:len/2)];
end
