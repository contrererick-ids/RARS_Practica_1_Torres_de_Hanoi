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