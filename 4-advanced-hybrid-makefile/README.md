
# Lab Demo - Advanced Hybrid Makefile with Driver in C

After this demo, students should have enough to finish their first programming assignment.

## Calling Assembly from C

Our first assignment requires that ```main()``` reside inside a C driver and that assembly functions are called from there.

* Setup basic C driver with ```main()```

    * Uses ```extern``` keyword to identify the function which would reside inside the assembly program

    * Prints a welcome message to the user

    * Calls on the assembly function

    * Prints a goodbye message to the user

* Setup basic assembly program to print a message to the user

    * Callable function that C can see

    * Just use a syscall to print some message, and return to the caller

    * Return a value to the caller with $rax

## More Advanced Makefile

An advanced Makefile with a dedicated target for each source file and corresponding object file won't be required until Programming Assignment 2:

* One target for each source-to-object compilation

* Additional target for linking

* Additional target for building (calls on the $BIN, probably)

* Variables

* Additional target for cleaning


