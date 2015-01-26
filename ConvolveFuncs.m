function ConvolveFuncs
% This function defines functions used in the file ConvolveGUI.m

cFunc(1).f='U(t)';          % Function to be executed
cFunc(end).d=[];            % Impulse nx2 (time, height) (see examples below)   
cFunc(end).n='Unit Step';   % String for drop down menu
cFunc(end).s='$\gamma(t)$'; % TeX string to be displayed.

cFunc(end+1).f='U(t)-U(t-2)';
cFunc(end).n='Pulse (2 sec)';
cFunc(end).d=[];
cFunc(end).s='$\gamma(t)-\gamma(t-2)$';

cFunc(end+1).f='2*(U(t)-U(t-1))';
cFunc(end).n='Pulse (amp=2, 1 sec)';
cFunc(end).d=[];
cFunc(end).s='$2(\gamma(t)-\gamma(t-1))$';

cFunc(end+1).f='0.*U(t)';  % Must be function of t so it is not zero length
cFunc(end).n='Impulse pulse (h=2, w=1)';  % Approximation to pulse
cFunc(end).d=[0.4 0; 0.4 0.2; 0.4 0.4; 0.4 0.6; 0.4 0.8;]; % dwindling impulses
cFunc(end).s='$0.4(\delta(t)-\delta(t-0.2)-\delta(t-0.4)-\delta(t-0.6)-\delta(t-0.8))$';

cFunc(end+1).f='0.5*(U(t)-U(t-2))';
cFunc(end).n='Pulse (amp=0.5, 2 sec)';
cFunc(end).d=[];
cFunc(end).s='$\frac{\gamma(t)-\gamma(t-2)}{2}$';

cFunc(end+1).f='(U(t)-U(t-0.2))';
cFunc(end).n='Pulse (amp=1, 0.2 sec)';
cFunc(end).d=[];
cFunc(end).s='$\gamma(t)-\gamma(t-0.2)$';

cFunc(end+1).f='U(t)-U(t-1)';
cFunc(end).n='Pulse (amp=1, 1 sec)';
cFunc(end).d=[];
cFunc(end).s='$\gamma(t)-\gamma(t-1)$';

cFunc(end+1).f='t.*(U(t)-U(t-1))';
cFunc(end).n='Ramp (1 sec)';
cFunc(end).d=[];
cFunc(end).s='$t(\gamma(t)-\gamma(t-1))$';

cFunc(end+1).f='(1-t).*(U(t)-U(t-1))';
cFunc(end).n='Inverse Ramp (1 sec)';
cFunc(end).d=[];
cFunc(end).s='$(1-t)(\gamma(t)-\gamma(t-1))$';

cFunc(end+1).f='t.*U(t) - (2*t-2).*U(t-1) + (t-2).*U(t-2)';
cFunc(end).n='Triangle (2 sec)';
cFunc(end).d=[];
cFunc(end).s='$t\gamma(t) - 2(t-1)\gamma(t-1) + (t-2)\gamma(t-2)$';

cFunc(end+1).f='U(t) - 2*U(t-1) + U(t-2)';
cFunc(end).n='BiPhasic (2 sec)';
cFunc(end).d=[];
cFunc(end).s='$\gamma(t) - 2\gamma(t-1) + \gamma(t-2)$';

cFunc(end+1).f='U(t).*exp(-t/2)/2';
cFunc(end).n='Exponential, slow';
cFunc(end).d=[];
cFunc(end).s='$\gamma(t)e^{-\frac{t}{2}}/2$';

cFunc(end+1).f='U(t).*exp(-2*t)*2';
cFunc(end).n='Exponential, fast';
cFunc(end).d=[];
cFunc(end).s='$\gamma(t)2e^{-2t}$';

cFunc(end+1).f='U(t).*exp(-10*t)*10';
cFunc(end).n='Exponential, very fast';
cFunc(end).d=[];
cFunc(end).s='$\gamma(t)10e^{-10t}$';

cFunc(end+1).f='0.*U(t)';  % Must be function of t so it is not zero length
cFunc(end).n='Impulse (t=0)';  % impulse
cFunc(end).d=[2 0]; % dwindling impulses
cFunc(end).s='$2\delta(t)$';

cFunc(end+1).f='0.*U(t)';  % Must be function of t so it is not zero length
cFunc(end).n='Impulse (t=2.5)';  % Delayed impulse
cFunc(end).d=[-1 2.5]; % dwindling impulses
cFunc(end).s='$-\delta(t)$';
cFunc(end+1).f='-2*exp(-2*t).*U(t)';
cFunc(end).n='High Pass';
cFunc(end).d=[1 0];
cFunc(end).s='$\delta(t)-2exp^{-2*t}$';

cFunc(end+1).f='0.*U(t)';  % Must be function of t so it is not zero length
cFunc(end).n='Echo';
cFunc(end).d=[1 0; 0.5 1]; % Unit impulse at 0, 0.5 impulse at t=1
cFunc(end).s='$\delta(t)-\frac{1}{2}\delta(t-1)$';


cFunc(end+1).f='0.*U(t)';  % Must be function of t so it is not zero length
cFunc(end).n='Impulse Ramp';  % Approximation to ramp
cFunc(end).d=[1 0; 0.8 0.2; 0.6 0.4; 0.4 0.6; 0.2 0.8]; % dwindling impulses
cFunc(end).s='$\delta(t)-0.8\delta(t-0.2)-0.6\delta(t-0.4)-0.4\delta(t-0.6)-0.2\delta(t-0.8)$';


cFunc(end+1).f='U(t).*exp(-0.5.*t).*sin(sqrt(3/4)*t)/sqrt(3/4)';
cFunc(end).n='Damped Sinusoid';
cFunc(end).d=[];
cFunc(end).s='$\gamma(t)\sqrt{\frac{4}{3}}e^{-\frac{t}{2}}sin(\sqrt{\frac{3}{4}}t)$';

cFunc(end+1).f='(sin(t).*t+1).*(U(t)-U(t-4))';
cFunc(end).n='Oddball function';
cFunc(end).d=[];
cFunc(end).s='$(tsin(t)+1)(\gamma(t)-\gamma(t-4))$';

cFunc(end+1).f='sin(20*t)./t/20';
cFunc(end).n='Narrow Sinc';
cFunc(end).d=[];
cFunc(end).s='$\frac{sin(20t)}{20t}$';

cFunc(end+1).f='sin(5*t)./t/5';
cFunc(end).n='Wide Sinc';
cFunc(end).d=[];
cFunc(end).s='$\frac{sin(5t)}{5t}$';

save 'ConvFuncs' cFunc  % Save the functions