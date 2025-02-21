
# Trabajo práctico Nro. 10: Ordenamiento por método de Inserción

* 75.03 / 95.57 Organización del Computador *

* 2c 2019 *

* Universidad de Buenos Aires *

## Consigna

Dado un archivo que contiene n números en BPF c/signo de 8 bits (n <= 30) se pide codificar en assembler Intel 80x86 un programa que imprima por pantalla que movimiento se realiza (por ejemplo “Iniciando el ciclo de i menor a la longitud del vector”) y contenido de dicho archivo ordenado en forma ascendente o descendente de acuerdo a lo que elija el usuario, usando un algoritmo de ordenamiento basado en el método de inserción.

procedure insercion (int[] vector) 
	i ← 1 while i < length(vector) 
			j ← i while j > 0 and vector[j-1] > vector[j] 
				swap vector[j] and vector[j-1]
				j ← j - 1
			end while
	i ← i + 1
	end while
end procedure

## Desarrollo

El método de ordenamiento por inserción es una manera muy natural de ordenar para un ser humano. Inicialmente se tiene un solo elemento, que obviamente es un conjunto ordenado. Después, cuando hay k elementos ordenados de menor a mayor, se toma el elemento k+1 y se compara con todos los elementos ya ordenados, deteniéndose cuando se encuentra un elemento menor (todos los elementos mayores han sido desplazados una posición a la derecha) o cuando ya no se encuentran elementos (todos los elementos fueron desplazados y este es el más pequeño). En este punto se inserta el elemento k+1 debiendo desplazarse los demás elementos 

Nota: no es correcto generar el archivo con un editor de textos de forma tal que cada registro sea una tira de 16 caracteres 1 y 0. Se aconseja el uso de un editor hexadecimal ( https://hexed.it/ ).

## Esquema de resolución

### MANEJO DE ARCHIVO

- Manejo de archivo (abrir, cerrer y validar si existe)				OK

- Leer archivo e imprimir por pantalla						OK

- Averigiuar longitud de vector							OK

### VALIDACION

- Validar numeros ingresados							NULL

### INSERCION

- Almacenar contenido de archivo en vector					OK		

- Recorrer vector e imprimir por pantalla					OK

- Recorrer de a dos elementos							OK

- Swap de direccion de memoria							OK

- Implementacion comparacion ascendente o descendente				OK

- Doble loop acortado e imprimir su posicion					OK

- Comparar dentro del doble loop y swapear 					OK

### MANEJO DE PANTALLA

- Manejo de pantalla ( Ascendente o descendente + nombre de archivo)		OK

- Mensajes									OK	


## Instalación de herramientas

```
$ sudo apt-get install -y nasm
```

## Compilación y ejecución del programa

```
$ nasm -f elf finale.asm
```

```
$ gcc -m32 -o finale finale.o
```

```
$ ./finale
```
