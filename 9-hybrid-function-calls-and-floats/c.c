//
#include <stdio.h>

//
void my_c_function_by_value(long int a, long int b)
{
	//
	printf("Hello from my_c_function_by_value()\n");
	printf("> Size of int: %ld\n", sizeof(int));
	printf("> Size of long int: %ld\n", sizeof(long int));
	printf("> The value of a is: %ld\n", a);
	printf("> The value of b is: %ld\n", b);
	
	//
	a = a + 1;
	b = b + 1;
	
	//
	printf("> The modified value of a is: %ld\n", a);
	printf("> The modified value of b is: %ld\n", b);
	
	return;
}

//
long int my_c_function_with_pointers(long int* a, long int* b)
{
	//
	printf("Hello from my_c_function_with_pointers()\n");
	printf("> The value of a is: %ld\n", *a);
	printf("> The value of b is: %ld\n", *b);
	
	//
	(*a) = (*a) + 1;
	(*b) = (*b) + 1;
	
	//
	printf("> The modified value of a is: %ld\n", *a);
	printf("> The modified value of b is: %ld\n", *b);
	
	return (*a) + (*b);
}

//
void my_c_function_with_floats(long int a, long int b, double c, double d)
{
	//
	printf("Hello from my_c_function_with_floats()\n");
	printf("> The value of a is: %ld\n", a);
	printf("> The value of b is: %ld\n", b);
	printf("> The value of c is: %lf\n", c);
	printf("> The value of d is: %lf\n", d);
	
	//
	a = a + 1;
	b = b + 1;
	c = c + 1.0;
	d = d + 1.0;
	
	//
	printf("> The modified value of a is: %ld\n", a);
	printf("> The modified value of b is: %ld\n", b);
	printf("> The modified value of c is: %lf\n", c);
	printf("> The modified value of d is: %lf\n", d);
}






