#include <iostream>
#include <cmath>

#using namespace std;
#
#int main() {
#  float num_x{0};
#  float resultado_real{0};
#  float error_cometido{0};
#  int n{1};
#  float sumatorio{1};
#  float adiccionador{1};
#  do {
#    do {
#      cout << "Introduzca el valor de x (|x| < 1): " << endl;
#      cin >> num_x;
#    } while (fabs(num_x) >= 1);
#    if (num_x == 0) {
#      break;
#    }
#    resultado_real = 1 / (1 + num_x);
#    cout << "Resultado real = " << resultado_real << endl;
#    float error_objetivo{0};
#    do {
#      cout << "Introduzca el valor objetivo: " << endl;
#      cin >> error_objetivo;
#    } while (error_objetivo < 0 || error_objetivo > resultado_real); 
#    do {
#      // error cometido = 1 - 0.6
#      // n = iteraciones
#      // sumatorio = suma o resta error cometido
#      // num_x = 0.6
#      adiccionador = adiccionador * num_x; 
#      if (n % 2 == 0) {
#        sumatorio = sumatorio + adiccionador;
#      } else {
#        sumatorio = sumatorio - adiccionador;
#      }
#      error_cometido = fabs(resultado_real - sumatorio);
#      n++;
#    } while (error_cometido > error_objetivo);
#    cout << "Resultado calculado para " << n << " términos = " << sumatorio << endl;
#    cout << "Error cometido para " << n << " términos = " << error_cometido << endl;
#  } while (num_x != 0);
#  cout << "FIN DEL PROGRAMA" << endl;
#}
# NOMBRE: MARCO NAPIERSKI
# FECHA: 25.03.2022
   .data
titulo: .asciiz "PR3 aproximación por serie geométrica\n"
finmsg: .asciiz "\nFIN DEL PROGRAMA.\n"
calmsg: .asciiz "\nResultado real = "
pidex:  .asciiz "\nIntroduzca el valor de x (|x|<1): "
piderr: .asciiz "\nIntroduzca el error objetivo: "
resmsg: .asciiz "\nResultado calculado para "
termsg: .asciiz " terminos = "
errmsg: .asciiz "\nError cometido para "
   .text
main:
 
   la  $a0,titulo# carga cadena de texto
   li  $v0,4 # cadena de texto
   syscall #imprime "PR3 aproximación por serie geométrica\n"
 
   top1: # etiqueta

   la  $a0,pidex# carga cadena de texto
   li  $v0,4# cadena de texto
   syscall #imprime  "\nIntroduzca el valor de x (|x|<1): "

 #cin f2 = 0.6
   li $v0,6 # carga formato flotante
   syscall # pregunta al usuario
   mov.s $f2,$f0 # f2 = x
   mov.s $f7,$f0 # f7 = x

# si f2 == 0 , fin
   li.s $f0,0.0 #f0 = 0
   c.eq.s $f2,$f0 # si es 0 acaba el programa
   bc1t fin # acaba el programa solo si pones un 0 en esta parte
# si f2 < 0 --> f2 = -f2
   c.lt.s $f2,$f0 # f2 < 0
   bc1f nonegativo # si es falso pasa
       sub.s $f2,$f0,$f2 # si sí es negativo, lo pasa a positivo
   nonegativo:#si no era negativo
#f4 = 1.0; si f2 < 1 sigue
   li.s $f4,1.0 # f4 = 1
   c.lt.s $f2,$f4 # f2 < 1(f4)
   bc1f top1 #vuelve a subir ya que no se cumplió con los requisitos
# f4 = f2 + 1.0
# f3 = f3 / f4
   li.s $f3,1.0 #f3 = 1
   add.s $f4,$f2,$f4 # f4 = numerador
   div.s $f3,$f3,$f4 # f3 = VALOR REALLL F3

   la  $a0,calmsg # carga cadena de texto
   li  $v0,4 # cadena de texto
   syscall # imprime "\nResultado real = "
   mov.s $f12,$f3 #f12 = f3
   li  $v0,2 #float
   syscall # imprime el resultado real
# cin f4 = error objetivo
   top2: # etiqueta

   la  $a0,piderr# carga cadena de texto
   li  $v0,4# cadena de texto
   syscall #imprime "\nIntroduzca el error objetivo: "

   li $v0,6 # carga formato flotante
   syscall # pregunta al usuario
   mov.s $f4,$f0 # f4 = ERROR OBJETIVO F4
# f2 = 0
   li.s $f2,0.0 # f2 = 0
   c.le.s $f4,$f2 # f4 <= 0
   bc1t top2#vuelve a subir ya que no se cumplió con los requisitos
   c.lt.s $f4,$f3 # error objetivo !< valor real
   bc1f top2#vuelve a subir ya que no se cumplió con los requisitos
# f2,f6 = 1 , f3 = valor real , f4 = error objetivo , f5 = error cometido, f7 = x, f8 = sumatorio

########################
# HACE DOS ITERACIONES
########################
   li $t3,1 #  t3 son las iteraciones
   li $t2,2 # para hacer el resto despues(comprobar si es par o no)
   li.s $f2,1.0 # f2 = 1
   mov.s $f6,$f7 # f6 = f7
   sub.s $f8,$f2,$f7 # f8 = f2 - f7

   sub.s $f5,$f3,$f8 # f5 = f3 - f8
   li.s $f0,0.0 #f0 = 0.0
   c.lt.s $f5,$f0 # f2 < 0
   bc1f nonegativo3 # si es falso pasa
       sub.s $f5,$f0,$f5 # si sí es negativo, lo pasa a positivo
   nonegativo3:#si no era negativo
   c.lt.s $f5,$f4  # error cometido < error objetivo
   bc1t antes3 # si i < 3 salta despues del while que viene
   li.s $f5,0.0 # f5 = 0
##########################

########
#WHILE
########
   start_while: # etiqueta

   addi $t3,$t3,1 # i++
   mul.s $f7,$f7,$f6 #0.6 * 0.6... 0.36
   div $t3,$t2 # i % 2
   mfhi $t4 #resto

   beq $t4,$zero,suma # si el numero elevado es par = suma, impar = resta
   sub.s $f8,$f8,$f7 #f8 = f8 - f7
   j fin_if #baja para no sumar
   suma: # esto es para no restar
   add.s $f8,$f8,$f7 # f8 = f8 + f7 
   fin_if: # acaba el if

   sub.s $f5,$f3,$f8 #f5 = f3 (0.01 "error al que puede llegar") - f8 (sumatorio)
   li.s $f0,0.0 # f0 = 0.0
   c.lt.s $f5,$f0 # f2 < 0
   bc1f nonegativo2 # si es falso pasa
       sub.s $f5,$f0,$f5 # si sí es negativo, lo pasa a positivo
   nonegativo2: #si no era negativo

   c.lt.s $f5,$f4  # error cometido < error objetivo
   bc1t fin_while ## salde del while

   j start_while # vuelve para arriba
   fin_while: #fin del while
############### FIN  WHILE ############

   antes3: # en caso de que i < 3
   addi $t3,$t3,1 # i++

###############

   la  $a0,resmsg # carga la cadena
   li  $v0,4# cadena de texto
   syscall # imprime "\nResultado calculado para "

   li  $v0,1# int
   move  $a0,$t3 # mete en a0 = t3(numero de iteraciones) 
   syscall # imprime el entero

   la  $a0,termsg# carga la cadena
   li  $v0,4 # cadena de texto
   syscall # imprime " terminos = "
   
   mov.s $f12,$f8# mete en f12 = f5 (sumatorio final)
   li  $v0,2 #float
   syscall # imprime el sumatorio final

   la  $a0,errmsg# carga la cadena
   li  $v0,4# cadena de texto
   syscall #imprime "\nError cometido para "
   
   li  $v0,1# int
   move  $a0,$t3# mete en a0 = t3(numero de iteraciones) 
   syscall# imprime el entero

   la  $a0,termsg# carga la cadena
   li  $v0,4# cadena de texto
   syscall # imprime " terminos = "

   mov.s $f12,$f5 # mete en f12 = f5 (error cometido)
   li  $v0,2 #float
   syscall # imprime el error final cometido

   j top1 # jump a top1
   fin: # para acabar el programa # etiqueta

   la  $a0,finmsg # carga la cadena
   li  $v0,4# cadena de texto
   syscall #imprime "\nFIN DEL PROGRAMA.\n"

   li $v0,10 # cerrar programa
	syscall # acaba