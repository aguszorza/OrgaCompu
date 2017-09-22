#/bin/bash

bash compilar.sh


# Pruebas con archivo de pruebas entrada.txt y resultado.txt

./tp1 -i entrada.txt -o salida.txt -I 1 -O 1
diff salida.txt resultado.txt
./tp1 -i entrada.txt -o salida.txt -I 20 -O 20
diff salida.txt resultado.txt
./tp1 -i entrada.txt -o salida.txt -I 100 -O 100
diff salida.txt resultado.txt
./tp1 -i entrada.txt -o salida.txt -I 1000 -O 1000
diff salida.txt resultado.txt
./tp1 -i entrada.txt -o salida.txt -I 20 -O 100
diff salida.txt resultado.txt
./tp1 -i entrada.txt -o salida.txt -I 100 -O 20
diff salida.txt resultado.txt
./tp1 -i entrada.txt -o salida.txt -I 1 -O 100
diff salida.txt resultado.txt
./tp1 -i entrada.txt -o salida.txt -I 100 -O 1
diff salida.txt resultado.txt
./tp1 -i entrada.txt -o salida.txt -I 20 -O 1000
diff salida.txt resultado.txt
./tp1 -i entrada.txt -o salida.txt -I 1000 -O 20
diff salida.txt resultado.txt

# Prueba con archivo vacio
touch vacio.txt
touch resultado_vacio.txt
./tp1 -i vacio.txt -o salida.txt -I 1 -O 1
diff salida.txt resultado_vacio.txt
./tp1 -i vacio.txt -o salida.txt -I 20 -O 20
diff salida.txt resultado_vacio.txt
./tp1 -i vacio.txt -o salida.txt -I 100 -O 100
diff salida.txt resultado_vacio.txt
./tp1 -i vacio.txt -o salida.txt -I 1000 -O 1000
diff salida.txt resultado_vacio.txt
./tp1 -i vacio.txt -o salida.txt -I 20 -O 100
diff salida.txt resultado_vacio.txt
./tp1 -i vacio.txt -o salida.txt -I 100 -O 20
diff salida.txt resultado_vacio.txt
./tp1 -i vacio.txt -o salida.txt -I 1 -O 100
diff salida.txt resultado_vacio.txt
./tp1 -i vacio.txt -o salida.txt -I 100 -O 1
diff salida.txt resultado_vacio.txt
./tp1 -i vacio.txt -o salida.txt -I 20 -O 1000
diff salida.txt resultado_vacio.txt
./tp1 -i vacio.txt -o salida.txt -I 1000 -O 20
diff salida.txt resultado_vacio.txt

# Pruebas con una sola letra mayúscula
echo M > res.txt
echo M | ./tp1 -o salida.txt -I 1 -O 1
diff salida.txt res.txt
echo M | ./tp1 -o salida.txt -I 20 -O 20
diff salida.txt res.txt
echo M | ./tp1 -o salida.txt -I 100 -O 100
diff salida.txt res.txt
echo M | ./tp1 -o salida.txt -I 1000 -O 1000
diff salida.txt res.txt
echo M | ./tp1 -o salida.txt -I 20 -O 100
diff salida.txt res.txt
echo M | ./tp1 -o salida.txt -I 100 -O 20
diff salida.txt res.txt
echo M | ./tp1 -o salida.txt -I 1 -O 100
diff salida.txt res.txt
echo M | ./tp1 -o salida.txt -I 100 -O 1
diff salida.txt res.txt
echo M | ./tp1 -o salida.txt -I 20 -O 1000
diff salida.txt res.txt
echo M | ./tp1 -o salida.txt -I 1000 -O 20
diff salida.txt res.txt

# Pruebas con una sola letra minúscula
echo m > res.txt
echo m | ./tp1 -o salida.txt -I 1 -O 1
diff salida.txt res.txt
echo m | ./tp1 -o salida.txt -I 20 -O 20
diff salida.txt res.txt
echo m | ./tp1 -o salida.txt -I 100 -O 100
diff salida.txt res.txt
echo m | ./tp1 -o salida.txt -I 1000 -O 1000
diff salida.txt res.txt
echo m | ./tp1 -o salida.txt -I 20 -O 100
diff salida.txt res.txt
echo m | ./tp1 -o salida.txt -I 100 -O 20
diff salida.txt res.txt
echo m | ./tp1 -o salida.txt -I 1 -O 100
diff salida.txt res.txt
echo m | ./tp1 -o salida.txt -I 100 -O 1
diff salida.txt res.txt
echo m | ./tp1 -o salida.txt -I 20 -O 1000
diff salida.txt res.txt
echo m | ./tp1 -o salida.txt -I 1000 -O 20
diff salida.txt res.txt

# Prueba con un número
echo 3 > res.txt
echo 3 | ./tp1 -o salida.txt -I 1 -O 1
diff salida.txt res.txt
echo 3 | ./tp1 -o salida.txt -I 20 -O 20
diff salida.txt res.txt
echo 3 | ./tp1 -o salida.txt -I 100 -O 100
diff salida.txt res.txt
echo 3 | ./tp1 -o salida.txt -I 1000 -O 1000
diff salida.txt res.txt
echo 3 | ./tp1 -o salida.txt -I 20 -O 100
diff salida.txt res.txt
echo 3 | ./tp1 -o salida.txt -I 100 -O 20
diff salida.txt res.txt
echo 3 | ./tp1 -o salida.txt -I 1 -O 100
diff salida.txt res.txt
echo 3 | ./tp1 -o salida.txt -I 100 -O 1
diff salida.txt res.txt
echo 3 | ./tp1 -o salida.txt -I 20 -O 1000
diff salida.txt res.txt
echo 3 | ./tp1 -o salida.txt -I 1000 -O 20
diff salida.txt res.txt

# Pruebas con un guion
echo - > res.txt
echo - | ./tp1 -o salida.txt -I 1 -O 1
diff salida.txt res.txt
echo - | ./tp1 -o salida.txt -I 20 -O 20
diff salida.txt res.txt
echo - | ./tp1 -o salida.txt -I 100 -O 100
diff salida.txt res.txt
echo - | ./tp1 -o salida.txt -I 1000 -O 1000
diff salida.txt res.txt
echo - | ./tp1 -o salida.txt -I 20 -O 100
diff salida.txt res.txt
echo - | ./tp1 -o salida.txt -I 100 -O 20
diff salida.txt res.txt
echo - | ./tp1 -o salida.txt -I 1 -O 100
diff salida.txt res.txt
echo - | ./tp1 -o salida.txt -I 100 -O 1
diff salida.txt res.txt
echo - | ./tp1 -o salida.txt -I 20 -O 1000
diff salida.txt res.txt
echo - | ./tp1 -o salida.txt -I 1000 -O 20
diff salida.txt res.txt

# Pruebas con un guion bajo
echo _ > res.txt
echo _ | ./tp1 -o salida.txt -I 1 -O 1
diff salida.txt res.txt
echo _ | ./tp1 -o salida.txt -I 20 -O 20
diff salida.txt res.txt
echo _ | ./tp1 -o salida.txt -I 100 -O 100
diff salida.txt res.txt
echo _ | ./tp1 -o salida.txt -I 1000 -O 1000
diff salida.txt res.txt
echo _ | ./tp1 -o salida.txt -I 20 -O 100
diff salida.txt res.txt
echo _ | ./tp1 -o salida.txt -I 100 -O 20
diff salida.txt res.txt
echo _ | ./tp1 -o salida.txt -I 1 -O 100
diff salida.txt res.txt
echo _ | ./tp1 -o salida.txt -I 100 -O 1
diff salida.txt res.txt
echo _ | ./tp1 -o salida.txt -I 20 -O 1000
diff salida.txt res.txt
echo _ | ./tp1 -o salida.txt -I 1000 -O 20
diff salida.txt res.txt

# Pruebas con un simbolo
echo @ | ./tp1 -o salida.txt -I 1 -O 1
diff salida.txt vacio.txt
echo @ | ./tp1 -o salida.txt -I 20 -O 20
diff salida.txt vacio.txt
echo @ | ./tp1 -o salida.txt -I 100 -O 100
diff salida.txt vacio.txt
echo @ | ./tp1 -o salida.txt -I 1000 -O 1000
diff salida.txt vacio.txt
echo @ | ./tp1 -o salida.txt -I 20 -O 100
diff salida.txt vacio.txt
echo @ | ./tp1 -o salida.txt -I 100 -O 20
diff salida.txt vacio.txt
echo @ | ./tp1 -o salida.txt -I 1 -O 100
diff salida.txt vacio.txt
echo @ | ./tp1 -o salida.txt -I 100 -O 1
diff salida.txt vacio.txt
echo @ | ./tp1 -o salida.txt -I 20 -O 1000
diff salida.txt vacio.txt
echo @ | ./tp1 -o salida.txt -I 1000 -O 20
diff salida.txt vacio.txt

# Prueba con espacios
echo "                    " > ent.txt 
./tp1 -i ent.txt -o salida.txt -I 1 -O 1
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 20 -O 20
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 100 -O 100
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 1000 -O 1000
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 20 -O 100
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 100 -O 20
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 1 -O 100
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 100 -O 1
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 20 -O 1000
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 1000 -O 20
diff salida.txt vacio.txt

# Pruebas con simbolos
echo "@#$%^*()!{}[],./?<>;:*+\|=+" > ent.txt 
./tp1 -i ent.txt -o salida.txt -I 1 -O 1
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 20 -O 20
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 100 -O 100
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 1000 -O 1000
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 20 -O 100
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 100 -O 20
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 1 -O 100
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 100 -O 1
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 20 -O 1000
diff salida.txt vacio.txt
./tp1 -i ent.txt -o salida.txt -I 1000 -O 20
diff salida.txt vacio.txt


#Prueba con un archivo con 30 lineas de 5000 caracteres cada una,
# donde cada una es palindromo en su totalidad

./tp1 -i archivo_largo.txt -o salida.txt -I 1 -O 1
diff salida.txt archivo_largo.txt
./tp1 -i archivo_largo.txt -o salida.txt -I 20 -O 20
diff salida.txt archivo_largo.txt
./tp1 -i archivo_largo.txt -o salida.txt -I 100 -O 100
diff salida.txt archivo_largo.txt
./tp1 -i archivo_largo.txt -o salida.txt -I 1000 -O 1000
diff salida.txt archivo_largo.txt
./tp1 -i archivo_largo.txt -o salida.txt -I 20 -O 100
diff salida.txt archivo_largo.txt
./tp1 -i archivo_largo.txt -o salida.txt -I 100 -O 20
diff salida.txt archivo_largo.txt
./tp1 -i archivo_largo.txt -o salida.txt -I 1 -O 100
diff salida.txt archivo_largo.txt
./tp1 -i archivo_largo.txt -o salida.txt -I 100 -O 1
diff salida.txt archivo_largo.txt
./tp1 -i archivo_largo.txt -o salida.txt -I 20 -O 1000
diff salida.txt archivo_largo.txt
./tp1 -i archivo_largo.txt -o salida.txt -I 1000 -O 20
diff salida.txt archivo_largo.txt

# Prueba error: no se ingresa archivo de entrada
echo "Debe indicar un archivo de entrada luego de -i" > res.txt
./tp1 -i 2> error.txt
diff error.txt res.txt
./tp1 -I 10 -i 2> error.txt
diff error.txt res.txt
./tp1 -I 10 -O 10 -i 2> error.txt
diff error.txt res.txt
./tp1 -o salida.txt -i 2> error.txt
diff error.txt res.txt

# Prueba error: no se ingresa archivo de salida
echo "Debe indicar un archivo de salida luego de -o" > res.txt
./tp1 -o 2> error.txt
diff error.txt res.txt
./tp1 -i entrada.txt -o 2> error.txt
diff error.txt res.txt
./tp1 -I 10 -o 2> error.txt
diff error.txt res.txt
./tp1 -I 10 -O 10 -o 2> error.txt
diff error.txt res.txt

# Prueba error: no se ingresa tamaño del buffer de entrada
echo "Debe indicar un numero luego de -I" > res.txt       
./tp1 -I 2> error.txt
diff error.txt res.txt
./tp1 -i entrada.txt -I 2> error.txt
diff error.txt res.txt
./tp1 -O 10 -I 2> error.txt
diff error.txt res.txt
./tp1 -i entrada.txt -O 10 -I 2> error.txt
diff error.txt res.txt

# Prueba error: no se ingresa tamaño del buffer de salida
echo "Debe indicar un numero luego de -O" > res.txt     
./tp1 -O 2> error.txt
diff error.txt res.txt
./tp1 -i entrada.txt -O 2> error.txt
diff error.txt res.txt
./tp1 -I 10 -O 2> error.txt
diff error.txt res.txt
./tp1 -i entrada.txt -I 10 -O 2> error.txt
diff error.txt res.txt


# Prueba error: no se puede abrir el archivo de entrada
echo "El archivo de entrada no pudo abrirse" > res.txt
./tp1 -i inexistente.txt 2> error.txt
diff error.txt res.txt
./tp1 -o salida.txt -i inexistente.txt 2> error.txt
diff error.txt res.txt
./tp1 -I 10 -i inexistente.txt 2> error.txt
diff error.txt res.txt
./tp1 -i inexistente.txt -I 10 2> error.txt
diff error.txt res.txt

# Prueba error: el tamaño del buffer de entrada no es un numero
echo "El parametro de -I debe ser un numero" > res.txt			
./tp1 -I abc 2> error.txt
diff error.txt res.txt
./tp1 -i entrada.txt -I numero 2> error.txt
diff error.txt res.txt
./tp1 -O 10 -I nueve 2> error.txt
diff error.txt res.txt
./tp1 -i entrada.txt -O 10 -I abc123 2> error.txt
diff error.txt res.txt

# Prueba error: el tamaño del buffer de salida no es un numero
echo "El parametro de -O debe ser un numero" > res.txt			
./tp1 -O abc 2> error.txt
diff error.txt res.txt
./tp1 -i entrada.txt -O numero 2> error.txt
diff error.txt res.txt
./tp1 -I 10 -O nueve 2> error.txt
diff error.txt res.txt
./tp1 -i entrada.txt -I 10 -O abc123 2> error.txt
diff error.txt res.txt

#Pruebas con stdin (sin poner '-i' o poniendo '-i -')
./tp1 -o salida.txt -I 1 -O 1  < entrada.txt
diff salida.txt resultado.txt
./tp1 -o salida.txt -I 20 -O 20  < entrada.txt
diff salida.txt resultado.txt
./tp1 -o salida.txt -I 100 -O 100  < entrada.txt
diff salida.txt resultado.txt
./tp1 -o salida.txt -I 1000 -O 1000  < entrada.txt
diff salida.txt resultado.txt
./tp1 -o salida.txt -I 20 -O 100  < entrada.txt
diff salida.txt resultado.txt
./tp1 -o salida.txt -I 100 -O 20  < entrada.txt
diff salida.txt resultado.txt
./tp1 -i - -o salida.txt -I 1 -O 100  < entrada.txt
diff salida.txt resultado.txt
./tp1 -i - -o salida.txt -I 100 -O 1  < entrada.txt
diff salida.txt resultado.txt
./tp1 -i - -o salida.txt -I 20 -O 1000  < entrada.txt
diff salida.txt resultado.txt
./tp1 -i - -o salida.txt -I 1000 -O 20  < entrada.txt
diff salida.txt resultado.txt


#Prueba con stdout (sin poner '-o' o poniendo '-o -')
./tp1 -i entrada.txt -I 1 -O 1 > salida.txt
diff salida.txt resultado.txt
./tp1 -i entrada.txt -I 20 -O 20 > salida.txt
diff salida.txt resultado.txt
./tp1 -i entrada.txt -I 100 -O 100 > salida.txt
diff salida.txt resultado.txt
./tp1 -i entrada.txt -I 1000 -O 1000 > salida.txt
diff salida.txt resultado.txt
./tp1 -i entrada.txt -I 20 -O 100 > salida.txt
diff salida.txt resultado.txt
./tp1 -i entrada.txt -I 100 -O 20 > salida.txt
diff salida.txt resultado.txt
./tp1 -i entrada.txt -I 1 -O 100 > salida.txt
diff salida.txt resultado.txt
./tp1 -i entrada.txt -I 100 -O 1 > salida.txt
diff salida.txt resultado.txt
./tp1 -i entrada.txt -I 20 -O 1000 > salida.txt
diff salida.txt resultado.txt
./tp1 -i entrada.txt -I 1000 -O 20 > salida.txt
diff salida.txt resultado.txt


#Borramos archivos sobrantes
rm vacio.txt
rm resultado_vacio.txt
rm salida.txt
rm ent.txt
rm error.txt
rm res.txt
