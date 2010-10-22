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
     y=[temp(1025:2048) temp(1:1024)];
