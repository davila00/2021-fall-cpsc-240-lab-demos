

# TODO:
#	Variables
#	.PHONY targets
# 	Separate targets for each object file and executable
#	Clean target


# Notice we have a dependency here.
# The "build" target is a dependency of the "run" target.
# We denote this by adding the build target's name
#	to the right of the run target's colon
# This means that whenever we execute the "run" target,
#	the "build" target gets ran first.
# This makes sense because we would want to be sure
#	our executable is built before trying to launch
#	the program.
run:	build
	@echo "Running program!"
	./my-program


#
build:
	yasm -f elf64 -gdwarf2 my-assembly-main.asm -o my-assembly-main.o
	gcc -Wall -m64 -gdwarf-2 -c my-c-stuff.c -o my-c-stuff.o
	gcc -Wall -m64 -gdwarf-2 -no-pie *.o -o my-program
	@echo "Done"







