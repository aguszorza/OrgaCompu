#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int palindrome (int ifd, size_t ibytes, int ofd, size_t obytes);

int main(int argc, char* argv[]){
	FILE* entrada = stdin;
	FILE* salida = stdout;
	int tam_buffer_entrada = 1;
	int tam_buffer_salida = 1;
	char* parametro;
	
	int i;
	for (i = 1; i < argc; i += 2){
		if (strcmp(argv[i],"-i") == 0){
			if (i + 1 >= argc){
				fputs("Debe indicar un archivo de entrada luego de -i\n", stderr);
				return 3;
			}
			parametro = argv[i + 1];
			if (strcmp(parametro,"-") != 0){
				entrada = fopen(argv[i + 1], "r");
				if (!entrada){
					fputs("El archivo de entrada no pudo abrirse\n", stderr);
					return 4;
				}
			}
		}
		else if (strcmp(argv[i],"-o") == 0){
			if (i + 1 >= argc){
				fputs("Debe indicar un archivo de salida luego de -o\n", stderr);
				return 3;
			}
			parametro = argv[i + 1];
			if (strcmp(parametro,"-") != 0){
				salida = fopen(argv[i + 1], "w");
				if (!salida){
					fputs("El archivo de salida no pudo abrirse\n", stderr);
					return 4;
				}
			}
		}
		else if (strcmp(argv[i],"-I") == 0){
			if (i + 1 >= argc){
				fputs("Debe indicar un numero luego de -I\n", stderr);
				return 3;
			}
			parametro = argv[i + 1];
			if (strcmp(parametro,"-") != 0){
				tam_buffer_entrada = atoi(parametro);
				if (tam_buffer_entrada == 0){
					fputs("El parametro de -I debe ser un numero\n", stderr);
					return 4;
				}
			}
		}
		else if (strcmp(argv[i],"-O") == 0){
			if (i + 1 >= argc){
				fputs("Debe indicar un numero luego de -O\n", stderr);
				return 3;
			}
			parametro = argv[i + 1];
			if (strcmp(parametro,"-") != 0){
				tam_buffer_salida = atoi(parametro);
				if (tam_buffer_salida == 0){
					fputs("El parametro de -O debe ser un numero\n", stderr);
					return 4;
				}
			}
		}
		else if (strcmp(argv[i],"-V") == 0){
			fprintf(stdout, "TP1 version 1.0001\n");
			return 0;
		}
		else if (strcmp(argv[i],"-h") == 0){
			fprintf(stdout, "Usage:\n\ntp1 -h\ntp1 -V\ntp1 [options]\n\nOptions:\n-V, --version  Print version and quit.\n-h, --help   Print this information.\n-i, --input   Location of the input file.\n-o, --output   Location of the output file.\n-I, --ibuf-bytes Byte-count of the input buffer.\n-O, --obuf-bytes Byte-count of the output buffer.\n\nExample:\ntp0 -i ~/input -o ~/output\n");
			return 0;
		}
	}
	
	int resultado = palindrome(fileno(entrada), tam_buffer_entrada, fileno(salida), tam_buffer_salida);
	
	if (resultado != 0){
		fputs("Ocurrio un error\n", stderr);
	}
	
	fclose(entrada);
	fclose(salida);
	
	return resultado;
}