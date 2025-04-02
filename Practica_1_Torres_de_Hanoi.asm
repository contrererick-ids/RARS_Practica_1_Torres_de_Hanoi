#Practica 1 Torres de Hanoi

.text
main:		addi t0, zero, 0 # int i = 0;
		lui a0, 0x10010 # Dirección inicial de la torre A (el punto más alto dónde irá el disco más pequeño)
		addi a1, a0, 4 # Dirección inicial de la torre B
		addi a2, a1, 4 # Dirección inicial de la torre C 
		
for:		slti t1, t0, 3 # Inicio del ciclo "For" para rellenar la torre origen 
		beq t1, zero, hanoi # Validación para determinar si quedan discos por guardar
		addi t2, t0, 1 # Variable temporal para guardar el "disco" o valor del disco
		sw t2, 0(a0) # Asignación de disco al espacio de memoria correspondiente
		addi a0, a0, 32 # Desplazamiento de memoria para apuntar a la siguiente dirección
		addi t0, t0, 1 # i ++
		j for # Regreso a la ejecución del ciclo "For" hasta que no haya más discos por agregar 

hanoi:		addi t3, t0, 0 # Iniciamos "n" en el número de discos a jugar

exit: 		nop