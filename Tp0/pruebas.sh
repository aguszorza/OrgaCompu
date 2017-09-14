#/bin/bash

gcc -Wall -o tp0 tp0.c


# Prueba con archivo de pruebas
./tp0 -i entrada.txt -o salida.txt
diff salida.txt resultado.txt

# Prueba con archivo vacio
touch vacio.txt
touch resultado_vacio.txt
./tp0 -i vacio.txt -o salida.txt
diff salida.txt resultado_vacio.txt

# Prueba con una sola letra mayúscula
echo M | ./tp0 -o salida.txt
echo M > res.txt
diff salida.txt res.txt

# Prueba con una sola letra minúscula
echo m | ./tp0 -o salida.txt
echo m > res.txt
diff salida.txt res.txt

# Prueba con un número
echo 3 | ./tp0 -o salida.txt
echo 3 > res.txt
diff salida.txt res.txt

# Prueba con un guion
echo - | ./tp0 -o salida.txt
echo - > res.txt
diff salida.txt res.txt

# Prueba con un guion bajo
echo _ | ./tp0 -o salida.txt
echo _ > res.txt
diff salida.txt res.txt

# Prueba con un simbolo
echo @ | ./tp0 -o salida.txt
diff salida.txt vacio.txt

# Prueba con espacios
echo "                    " > ent.txt 
./tp0 -i ent.txt -o salida.txt
diff salida.txt vacio.txt

# Prueba con simbolos
echo "@#$%^*()!{}[],./?<>;:*+\|=+" > ent.txt 
./tp0 -i ent.txt -o salida.txt
diff salida.txt vacio.txt

# Prueba error: no se ingresa archivo de entrada
echo "Debe indicar un archivo de entrada luego de -i" > res.txt
./tp0 -i 2> error.txt
diff error.txt res.txt

# Prueba error: no se ingresa archivo de entrada
echo "Debe indicar un archivo de entrada luego de -i" > res.txt
./tp0 -o salida.txt -i 2> error.txt
diff error.txt res.txt

# Prueba error: no se ingresa archivo de salida
echo "Debe indicar un archivo de salida luego de -o" > res.txt
./tp0 -o 2> error.txt
diff error.txt res.txt

# Prueba error: no se ingresa archivo de salida
echo "Debe indicar un archivo de salida luego de -o" > res.txt
./tp0 -i entrada.txt -o 2> error.txt
diff error.txt res.txt

# Prueba error: no se puede abrir el archivo de entrada
echo "El archivo de entrada no pudo abrirse" > res.txt
./tp0 -i inexistente.txt 2> error.txt
diff error.txt res.txt

#Prueba con stdin
./tp0 -o salida.txt  < entrada.txt
diff salida.txt resultado.txt

#Prueba con stdin
./tp0 -i - -o salida.txt < entrada.txt
diff salida.txt resultado.txt

#Prueba con stdout
./tp0 -i entrada.txt > salida.txt
diff salida.txt resultado.txt

#Prueba con stdout
./tp0 -i entrada.txt -o - > salida.txt
diff salida.txt resultado.txt

#Borramos archivos sobrantes
rm vacio.txt
rm resultado_vacio.txt
rm salida.txt
rm ent.txt
rm error.txt
rm res.txt
