#include <stdio.h>

extern double sindg ( double x );

int main() {
	double x;
	double y;

	x = 30.0;
	y = sindg( 30.0 );

	printf( "sin( %lf ) = %lf", x, y );
	printf( "\n" );
}
