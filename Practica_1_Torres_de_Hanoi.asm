# Practica 1 Torres de Hanoi

.text
main:
    addi t0, zero, 0 # Inicializa i = 0
    lui s0, 0x10010 # Dirección inicial de la torre A
    addi s1, s0, 4 # Dirección inicial de la torre B
    addi s2, s0, 8 # Dirección inicial de la torre C
    addi a0, a0, 3 # Definimos el número de discos n = 3

for:
    slt t1, t0, a0 # for(int i = 0; i < 3; i++)
    beq t1, zero, startHanoi # Si i >= 3, salta a startHanoi
    addi t2, t0, 1 # Guardamos el valor del disco a colocar // t2 = i + 1;
    sw t2, 0(s0) # Guarda el disco en el nivel actual de la torre
    sw zero, 0(s1) # Nos aseguramos que las columnas estén vacías
    sw zero, 0(s2)
    addi s0, s0, 32 # Avanza al siguiente nivel
    addi s1, s1, 32
    addi s2, s2, 32
    addi t0, t0, 1 # Aumentamos i // i++;
    
    j for # Repite el ciclo hasta completar los discos

startHanoi:
    addi t3, zero, -32 # Guarda el número de bits a desplazarse // t3 = -32;
    mul t3, a0, t3 # Calcula el número de direcciones a desplazarse para regresar al inicio de la torre // t3 = 3 * (-32) --> t3 = -96;
    add s0, s0, t3 # Regresa la dirección de a0 al inicio de la torre A // a0 = 0x10010000;
    addi s3, s0, 0 # Almacena la dirección de la torre A en a3 // a3 = 0x10010000;
    addi s4, s0, 0 # Almacena la dirección de la torre A en a3 // a3 = 0x10010004;
    addi s5, s0, 0 # Almacena la dirección de la torre A en a3 // a3 = 0x10010008;

    jal ra hanoiTower # Llama a la función recursiva hanoiTower
    
    j exit

hanoiTower:
    lui s0, 0x10010 # Reinicio de s0 apuntando al inicio de la Torre A
    beq t4, zero, hanoiEnd # Si no quedan discos por acomodar saltamos a la parte final de la función o caso base // If(n == 0)
    addi sp, sp, -20 #Reservamos espacio en el stack
    sw ra, 0(sp) # Guardamos el valor de retorno
    sw a0, 4(sp) # Guardamos n, o sea el número de discos, en sp+4
    sw s3, 8(sp) # Guardamos la dirección de inicio de la torre A en el sp+8 (origen)
    sw s4, 12(sp) # Guardamos la dirección de inicio de la torre B en el sp+12 (auxiliar)
    sw s5, 16(sp) # Guardamos la dirección de inicio de la torre C en el sp+16 (destino)
    
    addi a0, a0, -1 # Reducimos n en 1 // n -= 1;
    addi t5, s4 # Guardamos en t5 la torre auxiliar
    addi s4, s5 # Guardamos la torre destino donde estaba la auxiliar
    addi s5, t5 # Guardamos la torre auxiliar donde estaba destino
    
    jal ra hanoiTower
    
    lw a0, 4(sp) # Guardamos el nuevo valor de n para la función recursiva
    lw s3, 8(sp) # Guardamos nuevamente en el stack las direcciones de las torres actualizadas
    lw s4, 12(sp) # Guardamos nuevamente en el stack las direcciones de las torres actualizadas
    lw s5, 16(sp) # Guardamos nuevamente en el stack las direcciones de las torres actualizadas

    ret

hanoiEnd:
    ret

exit:
    nop # Fin del programa