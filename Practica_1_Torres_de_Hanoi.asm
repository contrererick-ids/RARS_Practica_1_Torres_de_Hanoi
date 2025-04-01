#Practica 1 Torres de Hanoi

.text
main:		addi s0, zero, 0 # int a = 0;
		addi t0, zero, 0 # int i = 0;
for:		slti t1, t0, 3 #
		beq t1, zero, exit
		sw a1, 0(s1)
		
		addi t0, t0, 1 # i ++
		j for
exit: 		nop