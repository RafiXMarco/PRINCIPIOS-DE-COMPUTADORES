#int min,max,distancia;
#float normalizado;
#std::cout << "Normalizar un rango de enteros a flotantes entre 0 y 1. \nIntroduzca los límites del rango
#[min,max].\n";
#do {
#std::cout << "Introduzca límite inferior del rango (min): ";
#std::cin >> min;
#std::cout << "Introduzca límite superior del rango (max): ";
#std::cin >> max;
#if (max <= min)
#std::cout << "Error. min tiene que ser menor estrictamente que max.\n";
#} while (max <= min);
#int i;

######## 2º PARTE ###########

#for (i = min ; i <= max ; i++) {
#normalizado = float((i - min)) / float((max - min));
#std::cout << "Normalizado(" << i << ") = " << normalizado << std::endl;
#}
#std::cout << "\nFIN DEL PROGRAMA.\n";
#}


.data

msg1: .asciiz "Normalizar un rango de enteros a flotantes entre 0 y 1. \nIntroduzca los límites del rango
#[min,max].\n"
msg2: .asciiz "Introduzca límite inferior del rango (min): "
msg3: .asciiz "Introduzca límite superior del rango (max): "
msg4: .asciiz "Error. min tiene que ser menor estrictamente que max.\n"
msg5: .asciiz "\nNormalizado("
msg6: .asciiz ") = "

.text
main:

la $a0,msg1#STRING
li $v0,4 # carga cadena de texto
syscall

#######
#LA PRIMERA VEZ QUE ENTRA EN EL WHILE
#(SALTE DESPUES DEL ERROR)
j while
a_while:

##############
#error msg
la $a0,msg4#STRING
li $v0,4# carga cadena de texto
syscall
# error FIN
#############

while:

la $a0,msg2 #STRING
li $v0,4# carga cadena de texto
syscall

li $v0,5# INT
syscall
move $t3,$v0 #min


la $a0,msg3#STRING
li $v0,4# carga cadena de texto
syscall

li $v0,5 #INT
syscall
move $t4,$v0#max

bgt $t3,$t4,a_while #si t3 > t4 , va hacia arriba + el mensage de error


####################### 2º PARTE ###########################
move $t5,$t3 # i es t5

while2:

blt $t4,$t5,whilefin2 # si t4 < t5 , va al final

#RESTA EN ENTERO
sub $t7,$t5,$t3 # para 1ºfloat (i - min)
sub $t8,$t4,$t3 # para 2ºfloat (max - min)

#######################
#CONVIERTE DE INT A FLOAT
move $t0,$t7 #t0 = t7
mtc1 $t0,$f7 # pasa a flotante
cvt.s.w $f7,$f7# tendrá decimal
move $t0,$t8 #t0 = t8
mtc1 $t8,$f8# pasa a flotante
cvt.s.w $f8,$f8# tendrá decimal
######################
#HACE LA DIVISIÓN
div.s $f6,$f7,$f8
######################

##################
#EMPIEZA A IMPRIMIR TODO
la $a0,msg5 #STRING
li $v0,4# carga cadena de texto
syscall

move $a0,$t5 # s0 = t5
li $v0,1 # IMPRIME ITERACION
syscall

la $a0,msg6 #STRING
li $v0,4# carga cadena de texto
syscall

li $v0,2 # INT
mov.s $f12,$f6#IMPRIME EL VALOR DE LA DIVISIÓN
syscall
#FIN IMPRIMIR
#################

addi $t5,1 # i++
j while2
whilefin2: #FIN WHILE

#FIN
li $v0,10#FIN PROGRAMA
syscall