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
	char* parametro;
	
	int i;
	for (i = 1; i < argc; i += 2){
		if (strcmp(argv[i],"-i") == 0){
			if (i + 1 >= argc){
				fputs("Debe indicar un archivo de entrada luego de -i\n", stderr);
				return 2;
			}
			parametro = argv[i + 1];
			if (strcmp(parametro,"-") != 0){
				entrada = fopen(argv[i + 1], "r");
				if (!entrada){
					fputs("El archivo de entrada no pudo abrirse\n", stderr);
					return 1;
				}
			}
		}
		else if (strcmp(argv[i],"-o") == 0){
			if (i + 1 >= argc){
				fputs("Debe indicar un archivo de salida luego de -o\n", stderr);
				return 2;
			}
			parametro = argv[i + 1];
			if (strcmp(parametro,"-") != 0){
				salida = fopen(argv[i + 1], "w");
				if (!salida){
					fputs("El archivo de salida no pudo abrirse\n", stderr);
					return 1;
				}
			}
		}
		else if (strcmp(argv[i],"-V") == 0){
			fprintf(stdout, "TP0 version 1.0001\n");
			return 0;
		}
		else if (strcmp(argv[i],"-h") == 0){
			fprintf(stdout, "Usage:\n\ntp0 -h\ntp0 -V\ntp0 [options]\n\nOptions:\n-V, --version  Print version and quit.\n-h, --help   Print this information.\n-i, --input   Location of the input file.\n-o, --output   Location of the output file.\n\nExample:\ntp0 -i ~/input -o ~/output\n");
			return 0;
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
