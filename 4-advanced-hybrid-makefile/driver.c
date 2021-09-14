
//
#include <stdio.h>


//
extern long cool_assembly_function();


//
int main()
{
	//
	printf("Hello from driver.c main()!\n");
	
	//
	long returnValue;
	returnValue = cool_assembly_function();
	
	//
	printf("Received the following value from cool_assembly_function(): %ld\n", returnValue);
	
	return 0;
}


