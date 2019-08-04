s=tf('s');
z=tf('z');
Gp=1740/(s*(0.25*s + 1));
% bode(Gp)
Dig1=c2d(Gp,1/1000,'tustin')
[NUM,DEN] = tfdata(Dig1,'v')
sisotool
% 
%                                                                                                                                                                          