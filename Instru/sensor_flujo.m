r1=1000;
r2=2700;
%s=tf('s');
syms s  %Variable simbolica
Gs=r2/(r1+r2);
%sisotool
%%Código extra para gráfica en el tiempo
Gr=(3/s)*(Gs);
%Obtenemos la transformada inversa de laplace
G=ilaplace(Gr,s);
fplot(G,[0 2]);%Graficamos en el tiempo durante dos segundos
