* AFN -> AFD

** Algoritmo de Subconjuntos

*** Recibe como Entrada: AFND

*** Entrega como Salida: AFD

1. Agregar Cerradura_Epsilon(Inicial de AFN) a E

2. Por cada estado e en E

3.  Por cada simbolo s

4.      Agregar Cerradura_Epsilon(Mover(e,s))

5.      Agregar transición  e->(s) Cerradura_Epsilon(Mover(e,s))

6. El final del AFD es Cerradura_Epsilon(Inicial de AFN)

7. Los finales del AFD contienen finales dek AFN  

*** Función Cerradura_Epsion:

Recibe un subconjunto de Estados, y entrega como salida un subconjunto de Estados
