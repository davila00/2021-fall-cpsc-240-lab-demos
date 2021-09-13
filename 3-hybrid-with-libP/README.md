
# Lab Demo - Hybrid with libPuhfessorP

This lab demo was used to show how to add the *libPuhfessorP* shared object file to your program, and some of its functionality.

## Agenda

Stuff left to demo.

### Makefile Stuffs

Our Makefile thus far isn't very good. The build targets won't rebuild the executable if a source is changed, and we haven't explained variables yet!

* Add proper dependencies to the $(BIN) target, so it knows when to rebuild the executable.

    * Show why the current $(BIN) target didn't rebuild the program when appropriate

* Make: clean

* Make: variables

* Make: PHONY targets

### Assembly Stuffs

* Add in a CRLF function and use it to format output a little better

* Print user input prompt messages, before taking input

* Print confirmation after user input that contains the inputted value

* Show the .bss section and how it can be used to create an input buffer

    * Reference: Section 4.5 in the book

    * Idea: Show how to ask libP to input a user string as text to a byte buffer in the .bss section

    * Reminder: Future assignments may require a stack-based buffer, rather than a global .bss based buffer

        * Talk about the difference between the data contained in the .bss and .data sections

* Probably want to demonstrate math related to Assignment 1 at this point, so they can get a solid start

    * Talk about the concept in general (multiply input by pi-numerator, then divide result by pi-denominator)

    * Multiplication/division instructions as well

### For Next Demo

Stuff for the next Demo (probably)

* Hybrid where ```main()``` is inside the C program, and calls on an assembly function.

* Multiple targets that properly utilize dependencies.







