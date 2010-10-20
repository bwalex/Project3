%======================================================
% Author:    Alexander HORNUNG
%
%            Department of Electronic and Electrical Engineering
%            University College London
%            Torrington Place
%            London WC1E 7JE
%======================================================
% Date:     16/12/2008
%======================================================

function [ValueOut, prefix] = ImproveValues( Value )

if (mean(abs(Value)) > 1e12)
    ValueOut = Value./1e12;
    prefix='T';
elseif (mean(abs(Value)) > 1e9)
    ValueOut = Value./1e9;
    prefix='G';
elseif (mean(abs(Value)) > 1e6)
    ValueOut = Value./1e6;
    prefix='M';
elseif (mean(abs(Value)) > 1e3)
    ValueOut = Value./1e3;
    prefix='k';
elseif (mean(abs(Value)) < 1e-12)
    ValueOut = Value./1e-15;
    prefix='f';      
elseif (mean(abs(Value)) < 1e-9)
    ValueOut = Value./1e-12;
    prefix='p';       
elseif (mean(abs(Value)) < 1e-6)
    ValueOut = Value./1e-9;
    prefix='n';   
elseif (mean(abs(Value)) < 1e-3)
    ValueOut = Value./1e-6;
    prefix='\mu';
elseif (mean(abs(Value)) < 1e-0)
    ValueOut = Value./1e-3;
    prefix='m';
else
    prefix = '';
    ValueOut = Value;
end

end