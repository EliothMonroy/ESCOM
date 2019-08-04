%Circuito acelerometro
m=.1;
kf=1;
kd=.01009;%Ganancia potenciometro
ka=10;%Ganancia amplificador
r=1000;
e=.5;
k=10;
K=1/k;
%s=tf('s');
syms s  %Variable simbolica
Ha=kf/(m*r);
wn=sqrt(k/m);
Ga=(((1/k)*kd*ka*m*r)/(((1/wn^2)*s^2)+((2*e)/wn)*s+1));
%sisotool
%%Código extra para gráfica en el tiempo
Gr=((12/s)*(Ga))/(1+(Ga*Ha));
%Obtenemos la transformada inversa de laplace
G=ilaplace(Gr,s);
fplot(G,[0 2]);%Graficamos en el tiempo durante dos segundos
