#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

int main () {

	char input[8192];
	double d;
	int returnValue;

	/*
		Simulate Input
		This section skips the step of grabbing input from the user.
		We simulate user input by copying a string directly into the input buffer,
			in order to quickly show how sscanf would behave.
	*/
	
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
	
    /*
    	Actually get input from the user.
    	This shows a complete example of what you'd do in your program.
    */
    printf("Please enter a float: ");
    if (fgets(input, LINE_MAX, stdin) == NULL) {
    	printf("You entered no line!\n");
	}
	else {
		// Will return 0 for invalid, -1 for blank input
		returnValue = sscanf( input, "%lf", &d );
		if ( returnValue < 0 ) {
			printf("Your input was blank!\n");
		}
		else if ( returnValue == 0 ) {
			printf("You entered nonsense!\n");
		}
		else{
			printf("You entered a valid float: %lf (returnValue = %d)\n", d, returnValue);
		}
	}
	
    return(0);
}

