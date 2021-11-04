#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main () {

    char input[8192];
    double d;
    int returnValue;

    // Simulate a valid input
    strcpy( input, "71.82348" );
    returnValue = sscanf( input, "%lf", &d );
    printf("%d ==> %lf\n", returnValue, d);
    
    // Simulate another valid input
    strcpy( input, "-73278923651.8235587652348" );
    returnValue = sscanf( input, "%lf", &d );
    printf("%d ==> %lf\n", returnValue, d);
    
    // Simulate an invalid input
    strcpy( input, "q123.376" );
    returnValue = sscanf( input, "%lf", &d );
    printf("%d ==> %lf\n", returnValue, d);

    // Simulate another invalid input
    strcpy( input, "1287634.2876q" );
    returnValue = sscanf( input, "%lf", &d );
    printf("%d ==> %lf\n", returnValue, d);

    // Simulate another invalid input
    strcpy( input, "q" );
    returnValue = sscanf( input, "%lf", &d );
    printf("%d ==> %lf\n", returnValue, d);
    
    return(0);
}

