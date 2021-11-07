


# TODOs:
# - Link all object files with *.o
# - Start using variables



# We're going to keep things simple and only use a single target
#	to compile our program.
# With GNU Make, the first target is always
#	considered the default target.
# Thus, the build-and-run target will be run by default when you
#	execute "make" on the command line.
#
# Notice the target name appears on the left, then with a colon.
# Notice then, each line underneath is indented with a tab and is
#	actually a shell command, which GNU Make will run for the target.
# You may prepend a "@" character before a shell command to suppress
#	the printing of the command (it will merely execute the command).
#
# You should visit the following links to learn more about GNU Make:
#	https://www.gnu.org/software/make/manual/make.html
#	https://www.opensourceforu.com/2012/06/gnu-make-in-detail-for-beginners/
#	(you should also search the web and follow many tutorials until you're more comfortable)
build-and-run:
	yasm -f elf64 -gdwarf2 my-uhm-source-file.asm -o my-uhm-source-file.o
	ld my-uhm-source-file.o -o my-program
	@echo "Done"


