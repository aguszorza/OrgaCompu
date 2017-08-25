#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>
#define TAM 10


char * leer_palabra(FILE* archivo, int* longitud){
	char* palabra = realloc(NULL,TAM);
	int len = 0;
	while(true){
		int c = fgetc(archivo);
		if((c>=48 && c<=57) ||(c>=65 && c<=90) || (c>=97 && c<=122) || (c == 95) || (c == 45)){
			palabra[len] = c;
			len ++;
			if (len % TAM == 0){
				palabra = realloc(palabra, TAM + len);
			}
		}
		else{
			palabra[len] = '\0';
			*longitud = len;
			return palabra;
		}
	}
}

bool es_capicua(char* palabra, int len){
	if (len == 0){
		return false;
	}
	int inicio = 0;
	int final = len - 1;
	while(inicio < final){
		if (tolower((unsigned char)palabra[inicio]) != tolower((unsigned char)palabra[final])){
			return false;
		}
		inicio++;
		final--;
	}
	return true;
}

int main(int argc, char* argv[]){
	FILE* entrada = stdin;
	FILE* salida = stdout;
	for (int i = 1; i < argc; i += 2){
		if (strcmp(argv[i],"-i") == 0){
			entrada = fopen(argv[i + 1], "r");
		}
		else if (strcmp(argv[i],"-o") == 0){
			salida = fopen(argv[i + 1], "w");
		}
	}
	
	char* palabra;
	int len;
	while(!feof(entrada)){
		palabra = leer_palabra(entrada, &len);
		if (es_capicua(palabra, len)){
			fprintf(salida, "%s\n", palabra);
		}
		free (palabra);
	}
	fclose(entrada);
	fclose(salida);
	return 0;
}
