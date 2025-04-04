# Practica 1 Torres de Hanoi

.text
main:
    addi t0, zero, 0 # Inicializa i = 0
    lui s2, 0x10010 # Dirección inicial de la torre A
    addi s3, s2, 4 # Dirección inicial de la torre B
    addi s4, s2, 8 # Dirección inicial de la torre C
    addi a0, a0, 3 # Definimos el número de discos n = 3

for:
    slt t1, t0, a0 # for(int i = 0; i < 3; i++)
    beq t1, zero, startHanoi # Si i == 0, salta a startHanoi
    addi t2, t0, 1 # Guardamos el valor del disco a colocar // t2 = i + 1;
    sw t2, 0(s2) # Guarda el disco en el nivel actual de la torre
    sw zero, 0(s3) # Nos aseguramos que las columnas estén vacías
    sw zero, 0(s4)
    addi s2, s2, 32 # Avanza al siguiente nivel
    addi s3, s3, 32
    addi s4, s4, 32
    addi t0, t0, 1 # Aumentamos i // i++;
    
    j for # Repite el ciclo hasta completar los discos

startHanoi:
    addi t3, zero, -32 # Guarda el número de bits a desplazarse // t3 = -32;
    mul t3, a0, t3 # Calcula el número de direcciones a desplazarse para regresar al inicio de la torre // t3 = 3 * (-32) --> t3 = -96;
    add s2, s2, t3 # Regresa la dirección de a0 al inicio de la torre A // a0 = 0x10010000;
    addi s5, s2, 0 # Almacena la dirección de la torre A en a3 // a3 = 0x10010000;
    addi s6, s2, 4 # Almacena la dirección de la torre A en a3 // a3 = 0x10010004;
    addi s7, s2, 8 # Almacena la dirección de la torre A en a3 // a3 = 0x10010008;

    jal ra hanoiTower # Llama a la función recursiva hanoiTower
    
    j exit

hanoiTower:
    addi t4, a0, 0 # t4 = n; 
    beq t4, zero, hanoiEnd # Si no quedan discos por acomodar saltamos a la parte final de la función o caso base // If(n == 0)
    
    addi sp, sp, -20 #Reservamos espacio en el stack
    sw ra, 0(sp) # Guardamos el valor de retorno
    sw t4, 4(sp) # Guardamos n, o sea el número de disco, en sp+4
    sw s5, 8(sp) # Guardamos la dirección de inicio de la torre A en el sp+8 (origen)
    sw s6, 12(sp) # Guardamos la dirección de inicio de la torre B en el sp+12 (auxiliar)
    sw s7, 16(sp) # Guardamos la dirección de inicio de la torre C en el sp+16 (destino)
    
    addi t4, t4, -1 # Reducimos n en 1 // n -= 1;
    addi t5, s6, 0 # Guardamos en t5 la torre auxiliar
    addi s6, s7, 0 # Guardamos la torre destino donde estaba la auxiliar
    addi s7, t5, 0 # Guardamos la torre auxiliar donde estaba destino
    jal ra hanoiTower

hanoiFor:
    addi t6, 
    
    lw t4, 4(sp) # Guardamos el nuevo valor de n para la función recursiva
    lw s5, 8(sp) # Guardamos nuevamente en el stack las direcciones de las torres actualizadas
    lw s6, 12(sp) # Guardamos nuevamente en el stack las direcciones de las torres actualizadas
    lw s7, 16(sp) # Guardamos nuevamente en el stack las direcciones de las torres actualizadas
    
    addi t4, t4, -1 # Reducimos n en 1 // n -= 1;
    addi t5, s5, 0 # Guardamos en t5 la torre origen
    addi s5, s6, 0 # Guardamos la torre auxiliar donde estaba la origen
    addi s6, t5, 0 # Guardamos la torre origen donde estaba la auxiliar
    jal ra hanoiTower
    
    lw ra, 0(sp) # Recuperamos el valor de retorno
    addi sp, sp, 20 # Regresamos el stack
    ret

hanoiEnd:
    ret

exit:
    nop # Fin del programa
