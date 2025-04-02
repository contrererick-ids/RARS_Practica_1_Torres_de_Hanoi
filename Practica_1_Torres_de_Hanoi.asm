#Practica 1 Torres de Hanoi

.text
main:
	addi t0, zero, 0 # int i = 0;
	lui a0, 0x10010 # Dirección inicial de la torre A (el punto más alto dónde irá el disco más pequeño)
	addi a1, a0, 4 # Dirección inicial de la torre B
	addi a2, a1, 4 # Dirección inicial de la torre C 
		
for:
	slti t1, t0, 3 # Inicio del ciclo "For" para rellenar la torre origen 
	beq t1, zero, hanoi # Validación para determinar si quedan discos por guardar
	addi t2, t0, 1 # Variable temporal para guardar el "disco" o valor del disco
	sw t2, 0(a0) # Asignación de disco al espacio de memoria correspondiente
	addi a0, a0, 32 # Desplazamiento de memoria para apuntar a la siguiente dirección
	addi t0, t0, 1 # i ++
	
	j for # Regreso a la ejecución del ciclo "For" hasta que no haya más discos por agregar 

startHanoi:
	addi t3, zero, -32 # Desplazamiento de -32 bytes para cambiar entre un nivel de la torrre y otro
	mul t3, t0, t3 # Calcula el desplazamiento total para regresar al inicio de la torre A
	add a0, a0, t3 # Corrige la dirección de a0 al inicio de la torre A
	addi t4, t0, 0 # t4 = n (número de discos)
	addi a3, a0, 0 # Almacena la dirección de la torre A en a3
	addi a4, a1, 0 # Almacena la dirección de la torre B en a4
	addi a5, a2, 0 # Almacena la dirección de la torre C en a5

exit: 
	nop