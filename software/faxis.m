     function y=faxis(s)
     %FAXIS         Computes a 128 element vector
     %              of frequencies for use with AMPL and 
     %              PHASE functions. User must supply s, the
     %              sampling rate of the original signal. The
     %              frequency axis is "wrapped round" for the
     %              negative frequencies.
     f = (0:2047)*s/2048;
     y = [f(1025:2048)-s f(1:1024)];
