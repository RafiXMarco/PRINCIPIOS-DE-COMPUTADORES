# ENUNCIADO:
# Realiza un programa para realizar la ordenación de un vector de enteros por el método de la burbuja. 
# para ello deberás realizar lo siguiente:
# * Implementa una función llamada printv que reciba dos argumentos enteros. El primero, la direccion base del vector
#   y el segundo, el numero de elementos del mismo. La funcion imprimira por consola cada elemento del vector pasado
#   separados por un espacio, y un caracter de nueva linea al finalizar de imprimir el vector.
#
# * Implementa una funcion llamada burbuja que reciba dos argumentos enteros. El primero, la direccion base del vector
#   y el segundo, el numero de elementos del mismo. La funcion debera ordenar el vector suministrado por el metodo de
#   la burbuja. La funcion burbuja debera llamar a la funcion printv cada vez que se realice un cambio en el orden
#   de los elementos del vector.
#
# * Desarrolla el cuerpo principal del programa de forma que se imprima la cadena etiquetada como "title" y se invoque
#   a la funcion printv y depues se invoque a la funcion burbuja
#
#  El programa no solamente debe funcionar, sino que para ser correcto debe cumplir con los convenios explicados en clase
#  y hacer un uso adecuado de los recursos explicados.

# #include<iostream>
# const int N=10;

# void printv(int vector[], int dimension) {
#     int i;
#     for ( i = 0 ; i < dimension ; i++) {
#         std::cout << vector[i] << " ";
#     }
#     std::cout << std::endl;
#     return;
# }

# void burbuja(int vector[], int dimension) {
#     int i,j,aux;
#     for (i = 0; i < dimension - 1 ; i++) 
#         for ( j = i + 1 ; j < dimension ; j++) 
#             if (vector[i] > vector[j]) {
#                 aux = vector[i];
#                 vector[i] = vector[j];
#                 vector[j] = aux;
#                 printv(vector,dimension);
#             }
#     return;
# }

# int main(void) {
    
#     int v[N] = {3, 1, 2, 5, 7, 9, 5, 0, 8, 3};
#     burbuja(v,N);

#     std::cout << "Ordenacion metodo de la bubuja\n";
#     printv(v,N);
#     return(0);
# }





N = 10
size = 4
    .data
v:          .word  3, 1, 2, 5, 7, 9, 5, 0, 8, 3
space:      .asciiz " "
newline:    .asciiz "\n"
title:      .asciiz "Ordenacion por el metodo de la burbuja.\n"

    .text

# void printv(int vector[], int dimension) {
#     int i;
#     for ( i = 0 ; i < dimension ; i++) {
#         std::cout << vector[i] << " ";
#     }
#     std::cout << std::endl;
#     return;
# }
printv: 
    move $t1,$a0#$a0 direccion v
    move $t2,$a1#$a1 numeros de elementos
    li $t0,0
    bucle1:
        bge $t0,$t2,fin_printv
        
        lw $t3,0($t1)
        move $a0,$t3
     	li	$v0,1
     	syscall

        la	$a0,space
        li	$v0,4
        syscall

        addu $t1,$t1,size
        addi $t0,1

    j bucle1

fin_printv: 
    la	$a0,newline
    li	$v0,4
    syscall
    jr $ra

# void burbuja(int vector[], int dimension) {
#     int i,j,aux;
#     for (i = 0; i < dimension - 1 ; i++) 
#         for ( j = i + 1 ; j < dimension ; j++) 
#             if (vector[i] > vector[j]) {
#                 aux = vector[i];
#                 vector[i] = vector[j];
#                 vector[j] = aux;
#                 printv(vector,dimension);
#             }
#     return;
# }
burbuja: 
    move $t1,$a0#$a0 direccion v
    move $t2,$a1#$a1 numeros de elementos    
    li $t0,0

    addi $sp,$sp,-4
    sw $ra,0($sp)

    bucle2:
        sub $t2,$t2,1
        bge $t0,$t2,fin_burbuja
        addi $t2,1

        bucle3:
            add $t5,$t0,1
            bge $t5,$t2,fin_bucle3
            li $t3,4
            mul $t8,$t3,$t0
            addu $t8,$t1,$t8 # t8 vector[i]
            lw $t6,0($t8)

            mul $t9,$t3,$t5
            addu $t9,$t1,$t9 # t9 vector[j]
            lw $t7,0($t9)


            ble $t6,$t7,fin_if

            sw $t6,0($t9)
            sw $t7,0($t8)


            move $a0,$t1
            move $a1,$t2
            jal printv

            fin_if:

            addi $t5,1 # j++
        j bucle3

        fin_bucle3:
        addi $t0,1 # i++

    j bucle2
fin_burbuja: 

    lw $ra,0($sp)
    addi $sp,$sp,4

    jr $ra




main:

    la	$a0,title
    li	$v0,4
    syscall

    la $a0,v
    li $a1,N
    jal printv

    la $a0,v
    li $a1,N
    jal burbuja

fin:
 li $v0,10
 syscall
