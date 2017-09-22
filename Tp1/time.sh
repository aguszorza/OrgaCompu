#/bin/bash

bash compilar.sh

#Crea el archivo vacio
cat /dev/null > time.txt


echo -e "PRUEBAS CON ARCHIVO DE PRUEBAS ENTRADA.TXT Y RESULTADO.TXT\n" >> time.txt

echo -e "Resultado con 1 byte entrada y 1 byte salida:" >> time.txt
(time ./tp1 -i entrada.txt -o salida.txt -I 1 -O 1)2>>time.txt

echo -e "\nResultado con 20 bytes entrada y 20 bytes salida:" >> time.txt
(time ./tp1 -i entrada.txt -o salida.txt -I 20 -O 20)2>>time.txt

echo -e "\nResultado con 50 bytes entrada y 50 bytes salida:" >> time.txt
(time ./tp1 -i entrada.txt -o salida.txt -I 50 -O 50)2>>time.txt

echo -e "\nResultado con 100 bytes entrada y 100 bytes salida:" >> time.txt
(time ./tp1 -i entrada.txt -o salida.txt -I 100 -O 100)2>>time.txt

echo -e "\nResultado con 250 bytes entrada y 250 bytes salida:" >> time.txt
(time ./tp1 -i entrada.txt -o salida.txt -I 250 -O 250)2>>time.txt

echo -e "\nResultado con 500 bytes entrada y 500 bytes salida:" >> time.txt
(time ./tp1 -i entrada.txt -o salida.txt -I 500 -O 500)2>>time.txt

echo -e "\nResultado con 1000 bytes entrada y 1000 bytes salida:" >> time.txt
(time ./tp1 -i entrada.txt -o salida.txt -I 1000 -O 1000)2>>time.txt


echo -e "\nPRUEBAS CON ARCHIVO CON 30 LINEAS DE 5000 CARACTERES CADA UNA (TODAS SON PALINDROMO)\n" >> time.txt

echo -e "\nResultado con 1 byte entrada y 1 byte salida:" >> time.txt
(time ./tp1 -i archivo_largo.txt -o salida.txt -I 1 -O 1)2>>time.txt

echo -e "\nResultado con 20 bytes entrada y 20 bytes salida:" >> time.txt
(time ./tp1 -i archivo_largo.txt -o salida.txt -I 20 -O 20)2>>time.txt

echo -e "\nResultado con 50 bytes entrada y 50 bytes salida:" >> time.txt
(time ./tp1 -i archivo_largo.txt -o salida.txt -I 50 -O 50)2>>time.txt

echo -e "\nResultado con 100 bytes entrada y 100 bytes salida:" >> time.txt
(time ./tp1 -i archivo_largo.txt -o salida.txt -I 100 -O 100)2>>time.txt

echo -e "\nResultado con 250 bytes entrada y 250 bytes salida:" >> time.txt
(time ./tp1 -i archivo_largo.txt -o salida.txt -I 250 -O 250)2>>time.txt

echo -e "\nResultado con 500 bytes entrada y 500 bytes salida:" >> time.txt
(time ./tp1 -i archivo_largo.txt -o salida.txt -I 500 -O 500)2>>time.txt

echo -e "\nResultado con 1000 bytes entrada y 1000 bytes salida:" >> time.txt
(time ./tp1 -i archivo_largo.txt -o salida.txt -I 1000 -O 1000)2>>time.txt
