# Leon Blanco David Rodrigo
# Contreras Salas Erick Alejandro
.text
main:	
	addi s0, s0, 8 # n discos
	lui t0, 0x10010 # direccion de la primer torre
	add a0, t0, zero # a0 es la torre origen
	add t2, s0, zero # guardamos el valor de s0 para luego recuperarlo
	addi a1, a0, -28 # torre auxiliar inicia su referencia un nivel mas abajo inicia una palabra a la derecha de torre origen
	addi a2, a1, 4 # igual con torre destino e inicia una palabra a la derecha de torre auxiliar
	add s1, a0, zero # le damos la dirección de la torre origen