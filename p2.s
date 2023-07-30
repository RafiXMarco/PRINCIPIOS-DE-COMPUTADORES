# practica 2. Principio de computadoras
# OBJETIVO: introduce el codigo necesario para reproducir el comportamiento del programa
# C++ que se adjunta como comentarios
# Debes documentar debidamente el uso de los registros que has elegido y la correspondencia
# con las variables que has utilizado.

##include <iostream>
# int main()
# {
#     std::cout << "Suma las cifras de un número entero." << std::endl;
#     std::cout << "Introduzca un 0 para salir del programa." << std::endl;


#     int numero,cifra,suma;
#     do {
#         std::cout << "Introduzca un entero para calcular la suma de sus cifras (0 para salir): ";
#         std::cin >> numero;
#		  if (numero == 0) break;
#         if (numero < 0 ) numero = 0 - numero; 
#         suma = 0;
#         while ( numero != 0 ){
#             cifra = numero % 10;
#             suma += cifra;
#             numero /= 10;
#         }
#         std::cout << "La suma de las cifras es " << suma << std::endl;
#     } while (true);
#     std::cout << "FIN DEL PROGRAMA. " << std::endl;
#     return 0;
# }

	.data		# directiva que indica la zona de datos
titulo: 	.asciiz	"\nSuma las cifras de un número entero. Introduzca un 0 para salir del programa.\n "
msgnumero:	.asciiz	"\n\nIntroduzca un entero para calcular la suma de sus cifras (0 para salir): "

msgresultado1:	.asciiz	"\nLa suma de las cifras es  "
msgfin:			.asciiz "\nFIN DEL PROGRAMA."


	.text		# directiva que indica la zona de código
main:
	# IMPRIME EL TITULO POR CONSOLA
	# std::cout << "Suma las cifras de un número entero." << std::endl;
	# std::cout << "Introduzca un 0 para salir del programa." << std::endl;
 
	la	$a0,titulo
	li	$v0,4
	syscall

	# EL MAYOR PORCENTAJE DEL CÓDIGO C++ SE ENCUENTRA DENTRO DE UNA ESTRUCTURA do { ...  } while (true).
	# IMPLEMENTA EN MIPS ESE BUCLE INFINITO, Y A CONTINUACIÓN DESARROLLA CADA UNA DE LAS SECCIONES QUE 
	# SE ENCUENTRAN EN SU INTERIOR.

	etiqueta_do:

	

	# INTRODUCE EN ESTA SECCION EL CÓDIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
	# TEN EN CUENTA QUE break NO ES SINO UN SALTO A LA SIGUIENTE INSTRUCCION QUE ESTE FUERA DEL BUCLE
	# do { ...  } while (true).
	#         std::cout << "Introduzca un entero para calcular la suma de sus cifras (0 para salir): ";
	#         std::cin >> numero;
	#		  if (numero == 0) break;

	la	$a0,msgnumero # carga el mensage
	li	$v0,4 # carga el formato mensage
	syscall # imprime el mensage

	li $v0,5 # carga formato pregunta
	syscall # pregunta al usuario
	move $t0,$v0 # t0 = v0
	beq $t0,$zero,fin # si es 0 acaba el prgrama

	# INTRODUCE EN ESTA SECCION EL CODIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
	#         if (numero < 0 ) numero = 0 - numero;
	
	bge $t0,$zero,nonegativo # si no es negativo pasar 
		sub $t0,$zero,$t0 # si sí es negativo, lo pasa a positivo
	nonegativo:
	# INTRODUCE EN ESTA SECCION EL CODIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
	#         suma = 0;
	#         while ( numero != 0 ){
	#             cifra = numero % 10;
	#             suma += cifra;
	#             numero /= 10;
	#         }

	move $t1,$zero # t1 = 0

	start_while:
	beq $t0,$zero,end_while # si t0 == 0 , acaba

	li $t3,10 #dar valor 10 a t3
	div $t0,$t3 #division
	mflo $t0 # cociente
	mfhi $t3 # resto o cifra
	add $t4,$t4,$t3 # t4 es sumatorio 

	j start_while # vuelve a subir 
	end_while: # termina el while 
	# INTRODUCE EN ESTA SECCION EL CODIGO MIPS EQUIVALENTE AL SIGUIENTE FRAGMENTO C++
	#         std::cout << "La suma de las cifras es " << suma << std::endl;	
	
	la	$a0,msgresultado1 # mensage de resultado
	li	$v0,4 # carga formato de texto
	syscall # imprime el texto

	move $a0,$t4 # a0 = t4
	li $v0,1  # carga formato numero entero
	syscall # imprime resultado (sumatorio de cifras)

	move $t4,$zero # t4 = 0 (resetear e, resultado)

	j etiqueta_do
	fin:
	# las siguientes instrucciones  imprimen la cadena de fin y finalizan el programa
	li $v0,4
	la $a0,msgfin
	syscall
	li $v0,10
	syscall
 
