     function y=faxis(s, n)
     %FAXIS         Computes a 128 element vector
     %              of frequencies for use with AMPL and 
     %              PHASE functions. User must supply s, the
     %              sampling rate of the original signal. The
     %              frequency axis is "wrapped round" for the
     %              negative frequencies.
     f = (0:n-1)*s/n;
     y = [f(n/2+1:n)-s f(1:n/2)];
