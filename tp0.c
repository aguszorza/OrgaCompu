#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#DEFINE TAM 10


char * leer_palabra(FILE* archivo){
	char* palabra = realloc(NULL,TAM);
	int i = 0;
	while(true){
		int caracter = fgetc(archivo);
		if(){// agregar la comparacion
			palabra[i] = caracter;
			i++;
			if (i%TAM == 0){
				realloc(palabra, TAM + i);
			}
		}
		else{
			palabra[i] = '\0';
			return palabra;
		}
	}
}

bool es_capicua(char* palabra){
	int inicio = 0;
	int final = strlen(palabra) - 1;
	while(inicio < final){
		if (tolower(palabra[inicio]) != tolower(palabra[final])){
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
			entrada = fopen(argv[i + 1], 'r');
		}
		else if (strcmp(argv[i],"-o") == 0){
			salida = fopen(argv[i + 1], 'w');
		}
	}
	while(EOF(entrada)){// buscar la funcion
		char* palabra = leer_palabra(entrada);
		if (es_capicua(palabra)){
			fprintf(salida, '%s\n', palabra);
		}
		free (palabra);
	}
	fclose(entrada);
	fclose(salida);
	return 0;
}
