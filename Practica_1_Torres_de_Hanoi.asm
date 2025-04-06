#Práctica 1 Torres de Hanoi
# León Blanco David Rodrigo
# Contreras Salas Erick Alejandro

.text
main:	
    addi s0, s0, 3 # Establece la cantidad de discos N en 3
    lui t0, 0x10010 # Carga en t0 la dirección inicial de la primera torre
    add  a0, t0, zero # a0 apunta a la torre origen
    add  t2, s0, zero # Guardamos el valor de n en t2 para usarlo más adelante
    addi a1, a0, -28 # Inicia la segunda torre en a1 con un offset de -28 respecto a la primera torre
    addi a2, a1, 4 # Inicia la tercera torre en a2 con un offset de 4 respecto a la segunda torre

    add  s1, a0, zero # Copia la dirección de la torre origen en s1
    jal  initialPosition # Llamamos a la función que inicializa las torres y coloca los discos en el estado inicial
    addi s1, s1, 32 # Desplazamos el puntero al siguiente nivel de la torre origen
    jal  HanoiTowers # Iniciamos el algoritmo para las torres
    jal  exit # Saltamos al final del programa
	
initialPosition:
    sw   s0, 0(s1) # Almacena el valor actual de s0 (el disco) en la dirección apuntada por s1 (torre origen)
    addi s0, s0, -1 # Decrementamos el contador de discos
    addi s1, s1, 32 # Desplaza el apuntador s1 al siguiente nivel
    bne  s0, zero, initialPosition # Volvemos a llamar a la función mientras queden discos por colocar
    add  s0, t2, s0 # Recuperamos el valor de n guardándolo en s0
    jalr ra # Volvemos a la siguiente instrucción por ejecutar antes de la llamada a initialPosition
	
HanoiTowers:
    addi sp, sp, -8 # Reserva espacio en la pila para guardar la dirección de la torre y el valor de n
    sw   ra, 4(sp) # Guarda la dirección de retorno en la pila
    addi t3, zero, 1 # Prepara t3 con el valor 1 para verificar el caso base
    beq  s0, t3, BaseCase # Si n == 1, salta a BaseCase
    addi s0, s0, -1 # Si n es mayor a 1 se le resta 1
    sw   s0, 0(sp) # Guarda el nuevo valor de n en la pila
    add  a4, a2, zero # Copia en a4 la dirección de la torre destino
    add  a2, a1, zero # Intercambia: la torre auxiliar pasa a a2
    add  a1, a4, zero # Intercambia: la torre destino original pasa a a1
    jal  HanoiTowers # Llamada recursiva con n-1 discos
	
    lw   s0, 0(sp) # Recupera n de la pila
    lw   ra, 4(sp) # Recupera la dirección de retorno
    add  a4, a2, zero # Copia la torre auxiliar en a4
    add  a2, a1, zero # Intercambia: la torre destino se asigna a a2
    add  a1, a4, zero # Intercambia: la torre auxiliar original se asigna a a1
    
    lw   a5, 0(s1) # Carga en a5 el disco superior de la torre origen
    sw   zero, 0(s1) # Elimina el disco de la torre origen (pone 0)
    addi s1, s1, -32 # Ajusta s1 para apuntar al siguiente disco en la torre origen
    addi a2, a2, 32 # Apunta a un espacio disponible en la otra torre
    sw   a5, 0(a2) # Almacena el disco en la torre auxiliar/destino
    
    add  a4, s1, zero # Copia la dirección actual de la torre origen en a4
    add  s1, a1, zero # Intercambia: la torre auxiliar pasa a s1
    add  a1, a4, zero # Intercambia: la torre origen pasa a a1
    jal  HanoiTowers # Llama recursivamente para seguir con el resto de discos
    
    add  a4, s1, zero # Copia la torre auxiliar en a4
    add  s1, a1, zero # La torre origen se asigna a s1
    add  a1, a4, zero # La torre auxiliar original vuelve a a1
    jal  nextMovement # Salta para realizar el siguiente movimiento
	
BaseCase:
    lw   a5, 0(s1) # Carga en a5 el disco superior de la torre origen
    sw   zero, 0(s1) # Elimina ese disco de la torre origen
    addi s1, s1, -32 # Ajusta el apuntador de la torre origen al siguiente disco
    addi a2, a2, 32 # Desplaza el apuntador de la torre destino para colocar el disco
    sw   a5, 0(a2) # Coloca el disco en la torre destino
	
nextMovement:
    lw   s0, 0(sp) # Recupera el valor de n de la pila
    lw   ra, 4(sp) # Recupera la dirección de retorno
    addi sp, sp, 8 # Restaura el puntero de pila
    jalr ra # Retorna para continuar la ejecución previa
	
exit:
    nop
