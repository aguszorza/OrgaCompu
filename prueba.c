#include <stdio.h>
extern int palindrome (int ifd, size_t ibytes, int ofd, size_t obytes);

int main(int argc, char* argv[]){
	FILE* entrada = fopen("entrada.txt","r");
	FILE* salida = fopen("salida.txt","w");
	
	int res = palindrome(fileno(entrada),5,fileno(salida),5);
	fputs("abc\n\n",stdout);
	return res;
}
