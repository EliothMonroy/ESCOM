%Diagrama bloque página 66 del libro
s=tf('s');
A=(4*(10^-6))/(1+10*s);
B=(10^3)/(1+(10^(-4))*s);
C=(25)/(2.5*(10^-5)*(s^2)+(10^-2)*s+1);
Gs=A*B*C*3085.1;%Este valor se obtuvo del edit compensator
sisotool