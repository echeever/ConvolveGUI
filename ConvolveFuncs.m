function ConvolveFuncs

s='U(t)';
d='Unit Step';
cFuncStep={s d};

s='U(t)-U(t-2)';
d='Pulse (2 sec)';
cFuncPulse2={s d};

s='2*(U(t)-U(t-1))';
d='Pulse (amp=2, 1 sec)';
cFuncPulseDouble={s d};

s='0.5*(U(t)-U(t-2))';
d='Pulse (amp=0.5, 2 sec)';
cFuncPulseHalf={s d};

s='(U(t)-U(t-0.2))';
d='Pulse (amp=1, 0.2 sec)';
cFuncNarrow={s d};

s='t.*(U(t)-U(t-1))';
d='Ramp (1 sec)';
cFuncRamp1={s d};

s='(1-t).*U(t)+(t-1).*U(t-1)';
d='Inverse Ramp (1 sec)';
cFuncRamp2={s d};

s='t.*U(t) - (2*t-2).*U(t-1) + (t-2).*U(t-2)';
d='Triangle (2 sec)';
cFuncTriangle={s d};

s='U(t) - 2*U(t-1) + U(t-2)';
d='BiPhasic (2 sec)';
cFuncBiphasic={s d};

s='U(t).*exp(-0.5.*t).*sin(sqrt(3/4)*t)/sqrt(3/4)';
d='Damped Sinusoid';
cFuncDampedSine={s d};

s='U(t).*(sin(t).*t+1).*U(4-t)';
d='Oddball function';
cFuncOddBall={s d};

s='U(t).*exp(-t/2)/2';
d='Exponential, slow';
cFuncExpSlow={s d};

s='U(t).*exp(-2*t)*2';
d='Exponential, fast';
cFuncExpFast={s d};

s='U(t).*exp(-10*t)*10';
d='Exponential, very fast';
cFuncExpVFast={s d};

s='U(t)-U(t-1)';
d='Pulse (1 sec)';
cFuncPulse1={s d};

s='sin(20*t)./t/20';
d='Narrow Sinc';
cFuncNarrowSinc={s d};

s='sin(5*t)./t/5';
d='Wide Sinc';
cFuncWideSinc={s d};


%% The following lines are useful for debugging.
% tmin=-4;  tmax=5;
% t=tmin:((tmax-tmin)/1000):tmax;
% s
% plot(t,eval(s));

save 'ConvolveFuncs' cFunc*



function u=U(t)
u=t>0;