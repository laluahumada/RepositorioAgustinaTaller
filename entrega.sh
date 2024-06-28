#!/bin/bash

#Helen Stosky Poluboiarinov, Número de estudiante: 337438
#María Agustina Ahumada, Número de estudiante: 329062

#declaración de variables de las letras, usuario logueado y vocal configuradas
letraInicio=""
letraFin=""
letraContenida=""
vocal=""
usuario=""

#función inicial que corrobora los datos de inicio de sesión
function autenticacion(){
	if  grep -q " $1 " usuarios.txt ; then	 #grep -q: búsqueda silenciosa, no muestra el resultado de la búsqueda
		if  grep -q  "Usuario: $1 Contraseña: $2" usuarios.txt ; then
			clear #se utiliza clear a lo largo del código para limpiar la pantalla y generar un aspecto visual mejorado
			usuario=$1
			echo "Bienvenido $1!"
			echo " "
			menu
		else
			echo "Contraseña Incorrecta"
		fi
	else
		echo "Usuario no encontrado"
	fi
}

#función de salida, escape para volver a la pantalla de menú
function salida(){
	echo "¿Quieres volver al menú? (s/n)"
	read salida
	if [[ $salida == "s" || $salida == "S" ]]; then #condición que permite respuesta en mayúscula o minúscula
		clear
		menu #vuelve al menú
	else
		exit 0 #comando exit finaliza la ejecución del script, el código 0 indica su correcta ejecución
	fi
}

# función del menú, mostrará las opciones y llevará al usuario a la opción seleccionada
function menu(){
	echo " "
	echo "Seleccionar Opción"
	echo "1. Listar usuarios registrados"
	echo "2. Dar de alta a un usuario"
	echo "3. Configurar letra de inicio"
	echo "4. Configurar letra de fin"
	echo "5. Configurar letra contenida"
	echo "6. Consultar diccionario"
	echo "7. Ingresar vocal"
	echo "8. Listar palabras del diccionario con vocal elegida"
	echo "9. Algoritmo 1"
	echo "10. Algoritmo 2"
	echo "11. Salir"
	echo " "
	read opcion

	case $opcion in #case: comando para selección de distintas opciones
		1)
		clear
		listado ;;
		2)
		clear
		altauser ;;
		3)
		clear
		configInicio ;;
		4)
		clear
		configFin ;;
		5)
		clear
		configContenido ;;
		6)
		clear
		consultarDiccionario ;;
		7)
		clear
		configVocal ;;
		8)
		clear
		listaVocal ;;
		9)
		clear
		algoritmo1 ;;
		10)
		clear
		algoritmo2 ;;
		11)
		salir ;;
		*) #la opción * es para cualquier otra opción que no sea las once especificadas anteriormente
		echo "Opción inválida"
		menu ;;
	esac
}

#función listado, mostrará la lista de usuarios ingresados
function listado(){
	cat usuarios.txt #comando cat muestra en terminal el listado de usuarios ingresados
	salida # se utiliza la función salida para llevar al usuario al menú o salir del script
}

#función para ingresar un nuevo usuario
function altauser(){
	echo "Ingrese nuevo usuario"
	read user
	echo "Ingrese Contraseña"
	read pass
	if ! grep -q " $user " usuarios.txt ; then # ! grep -q: busca el usuario en el documento para saber si no fue ingresado
		echo "Usuario: $user Contraseña: $pass" >> usuarios.txt #si no existía, se lo registra y con el comando >> se lleva los datos al archivo que contiene los usuarios registrados
		echo "Registro Exitoso!"
	else
		echo "Usuario ya registrado"
	fi
	salida # se utiliza la función salida para llevar al usuario al menú o salir del script
}

#función para configurar la letra inicial, de la palabra que se buscará en el diccionario
function configInicio(){
	echo "Ingrese letra de Inicio"
	read letraI
	if [[ "$letraI" =~ ^[a-zA-Z]+$ ]]; then # ^[a-zA-Z]+$ : es la expresión que verifica que el dato ingresado en la variable sea una letra
		letraInicio=${letraI,,} # se asigna el dato a la variable global
		if [ $letraInicio == ${letraI,,} ]; then  # con el if verificamos que se haya asignado correctamente, después imprime un mensaje si fue configurada correctamente o no
			echo "Letra inicial configurada correctamente"
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		else
			echo "Error de configuración"
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		fi
	else
		echo "Sólo se pueden configurar letras"
		salida # se utiliza la función salida para llevar al usuario al menú o salir del script
	fi
}

#función para configurar la letra final, de la palabra que se buscará en el diccionario
function configFin(){
	echo "Ingrese letra de Fin"
	read letraF
	if [[ "$letraF" =~ ^[a-zA-Z]+$ ]]; then # ^[a-zA-Z]+$ : es la expresión que verifica que el dato ingresado en la variable sea una letra
		letraFin=${letraF,,} # se asigna el dato a la variable global
		if [ $letraFin == ${letraF,,} ]; then # con el if verificamos que se haya asignado correctamente, después imprime un mensaje si fue configurada correctamente o no
			echo "Letra final configurada correctamente"
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		else
			echo "Error de configuración"
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		fi
	else
		echo "Solamente se pueden ingresar letras"
		salida # se utiliza la función salida para llevar al usuario al menú o salir del script
	fi
}

#función para configurar la letra contenida, de la palabra que se buscará en el diccionario
function configContenido(){
	echo "Ingrese letra Contenida"
	read letraC
	if [[ "$letraC" =~ ^[a-zA-Z]+$ ]]; then # ^[a-zA-Z]+$ : es la expresión que verifica que el dato ingresado en la variable sea una letra
		letraContenida=${letraC,,} # se asigna el dato a la variable global
		if [ $letraContenida == ${letraC,,} ]; then # con el if verificamos que se haya asignado correctamente, después imprime un mensaje si fue configurada correctamente o no
			echo "Letra contenida configurada correctamente"
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		else
			echo "Error de configuración"
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		fi
	else
		echo "Solamente pueden ingresarse letras"
		salida # se utiliza la función salida para llevar al usuario al menú o salir del script
	fi
}

#función para buscar y guardar en archivo que palabras del diccionario coinciden con las letras ingresadas previamente
function consultarDiccionario(){
	if [ -z "$letraInicio" ] || [ -z "$letraFin" ] || [ -z "$letraContenida" ]; then #  se comprueba que ninguna de las variables esté vacía
		echo "Hay una de las letras que no está configurada"
		salida # se utiliza la función salida para llevar al usuario al menú o salir del script
	else
		res=$(grep "^$letraInicio.*$letraContenida.*$letraFin$" diccionario.txt) # se guarda en la variable res todas las palabras que comiencen, contengan y finalicen con las letras ingresadas. Se busca en el archivo diccionario.txt
		if [ "$res" != "" ] ; then # se comprueba que la variable res no esté vacía
			echo "$res" # muestra en la terminal las palabras encontradas
			fecha=$(date +"%Y-%m-%d") #se guarda la fecha del sistema con la función date
			numero_palabras=$(echo "$res" | wc -w) # se guarda el número de palabras  encontradas. Se las cuenta usando wc -w
			numero_total=$(wc -w < diccionario.txt) # se guarda el número total de palabras que hay en el diccionario
			porcentaje=$(awk "BEGIN { printf\"%.2f\", ( $numero_palabras * 100 ) / $numero_total}") # se calcula el porcentaje de palabras que hay en res en relación con el total de palabras que hay en el diccionario
			echo "Fecha de ejecución del informe: $fecha" >> log.txt # escribe la fecha en el archivo log.txt
			echo "Cantidad de palabras del filtrado: $numero_palabras" >> log.txt # escribe la cantidad de palabras que coinciden en el archivo log.txt
			echo "Número total de palabras del diccionario: $numero_total" >> log.txt #escribe el número total de palabras del diccionario en el archivo log.txt
			echo "Porcentaje del número de palabras filtradas: $porcentaje" >> log.txt # escribe el porcentaje de palabras que coinciden con la condición ingresada en log.txt
			echo "Nombre de usuario registrado: $usuario" >> log.txt # escribe el nombre del usuario que ingresó en log.txt
			echo " " #imprime una línea en blanco para mejorar el formato visual
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		else
			echo "No se encontraron resultados"
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		fi
	fi
}

#función para configurar la vocal, de la palabra que se buscará en el diccionario
function configVocal {
	echo "Ingrese la vocal"
	read letraVocal
	if [[ "${letraVocal,,}" == "a" || "${letraVocal,,}" == "á" || "${letraVocal,,}" == "e" || "${letraVocal,,}" == "é" || "${letraVocal,,}" == "i" || "${letraVocal,,}" == "í" || "${letraVocal,,}" == "o" || "${letraVocal,,}" == "ó" || "${letraVocal,,}" == "ú"  || "${letraVocal,,}" == "u" ]]; then # se usa la condición para verificar que se haya ingresado una vocal, teniendo en cuenta que pueda tener tildes. ${letraVocal,,} : convierte la letra ingresada en minúsculas para que no haya errores
		vocal=${letraVocal,,} #asigna la letra a la variable global vocal
		echo "La vocal fue configurada correctamente"
		salida # se utiliza la función salida para llevar al usuario al menú o salir del script
	else
		echo "Error de configuración, la letra no es una vocal"
		salida # se utiliza la función salida para llevar al usuario al menú o salir del script
	fi
}

#función para generar la lista de las palabras del diccionario que contengan la vocal ingresada
function listaVocal {
	if [ -z "$vocal" ]; then # se comprueba si la variable vocal está vacía
		echo "La vocal no está configurada"  # muestra este mensaje si está vacía
		salida # se utiliza la función salida para llevar al usuario al menú o salir del script
	else #si no está vacía la variable
		otras_vocales=$(echo "aeiouáéíóú" | tr -d "$vocal") # se guardan las vocales posibles menos la vocal que fue ingresada previamente
		palabrasCompatibles=$(grep -iE "^[^${otras_vocales}]*$" diccionario.txt | grep -iE "${vocal}") # el primer grep busca palabras que no contengan ninguna de las letras de la variable otras_vocales. El segundo grep, se asegura que las palabras filtradas contengan la vocal específica
		if [ -n "$palabrasCompatibles" ]; then # comprueba que la variable no esté vacía
			echo "$palabrasCompatibles" #muestra las palabras que coinciden con la vocal
			echo " " # imprime una línea en blanco para mejorar el formato visual
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		else
			echo "No se encontraron palabras con dicha descripción"
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		fi
	fi
}

#función para ingresar una cierta cantidad de números para después mostrar su suma, el menor valor ingresado, el mayor valor ingresado, y su promedio
function algoritmo1(){
	echo "Ingrese cantidad de números a ingresar"
	read cantidad
	suma=0 # variable creada para almacenar la suma de todos los números ingresados
	menor= # variable inicialmente vacía, donde se almacenará el número menor ingresado
	mayor= # variable inicialmente vacía, donde se almacenará el número mayor ingresado
	if [[ ! "$cantidad" =~ [a-zA-Z] ]]; then #se verifica que el dato ingresado no sea una letra
		if [ $cantidad -gt 0 ]; then # se verifica que el número ingresado sea mayor a cero
			for (( i = 1; i <= cantidad; i++  )); do # se inicia un for, que se repetirá el número de veces que se haya ingresado en la variable cantidad
				echo "Ingrese el dato $i"
				read dato
				suma=$(( suma + dato )) # suma el dato a la variable suma que lleva el total de todos los números ingresados
				if [[ -z $menor || $dato -lt $menor ]]; then  # verifica si la variable menor está vacía o si el dato ingresado es menor al número que contenga la variable menor
					menor=$dato #si cumple con la condición se asigna el valor de dato a la variable menor
				fi
				if [[ -z $mayor || $dato -gt $mayor ]]; then # verifica si la variable mayor está vacía o si el dato es mayor al valor que tiene mayor en ese momento
					mayor=$dato # si cumple con la condición se asigna el valor de dato a la variable mayor
				fi
			done
			promedio=$(echo "scale=2; $suma / $cantidad" | bc ) # se calcula el promedio de los datos ingresados, se usa el comando bc para que la división tenga una precisión de dos decimales
			echo "Promedio de los datos ingresados: $promedio"
			echo "Mayor dato ingresado: $mayor"
			echo "Menor dato ingresado: $menor"
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		else
			echo "Se debe ingresar un número mayor a 0"
			salida # se utiliza la función salida para llevar al usuario al menú o salir del script
		fi
	else
		echo "Sólo se pueden ingresar números como cantidad"
		salida
	fi
}

#función para ingresar una palabra y que devuelva si la misma es un palíndromo o no
function algoritmo2(){
	echo "Ingrese una palabra"
	read palabra
	palabra_invertida=$(echo "$palabra" | rev) # se crea una variable donde se guarda la palabra ingresada, invertida. Se invierte con el comando rev.
	if  [ "$palabra" == "$palabra_invertida" ]; then # se verifica si la palabra ingresada es igual a la palabra invertida
		echo "La palabra $palabra es un palíndromo" # si es igual, se muestra este mensaje
		salida # se utiliza la función salida para llevar al usuario al menú o salir del script
	else
		echo "La palabra $palabra no es un palíndromo" # si la palabra no es igual, se muestra este mensaje
		salida # se utiliza la función salida para llevar al usuario al menú o salir del script
	fi
}

# función para salir del script
function salir(){
	echo "Saliendo del script" #muestra el mensaje que el usuario saldrá del script
	exit 0 # comando exit finaliza la ejecución del script, el código 0 indica su correcta ejecución
}

echo "Ingrese usuario:"
read user # guarda el usuario ingresado en esta variable
echo "Ingrese Contraseña"
read pass # guarda la contraseña ingresada en esta variable
autenticacion $user $pass # llama a la función autenticación y le pasa los datos de las variables user y pass

