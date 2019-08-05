def convertir(num):
	if num==0:
		return '0000'
	if num==1:
		return '0001'
	if num==2:
		return '0010'
	if num==3:
		return '0011'
	if num==4:
		return '0100'
	if num==5:
		return '0101'
	if num==6:
		return '0110'
	if num==7:
		return '0111'
	if num==8:
		return '1000'
	if num==9:
		return '1001'
	if num==10:
		return '1010'
	if num==11:
		return '1011'
	if num==12:
		return '1100'
	if num==13:
		return '1101'
	if num==14:
		return '1110'
	if num==15:
		return '1111'
#Entrada en bcd
numero1='0001'
numero2='0001'
numero3='0001'
aux=''
nuevo=None
salida='0000000000000000'
for i in range(16):
	if int(numero1,2)>4:
		numero1=convertir(int(numero1,2)+3)
	if int(numero2,2)>4:
		numero2=convertir(int(numero2,2)+3)
	if int(numero3,2)>4:
		numero3=convertir(int(numero3,2)+3)
	aux=numero1+numero2+numero3
	nuevo = list(salida)
	nuevo[i] = aux[0]
	salida=''.join(nuevo)
	aux=aux[1:12]+'0'
	numero1=aux[0:4]
	numero2=aux[4:8]
	numero3=aux[8:12]
print(salida)