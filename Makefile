




#	Help myself remember not to mess with the default target,
#	by using a target named 'default'.
#	Use dependency to control what target actually gets called.
default:	help


#
help:
	@echo
	@echo "***** Lab Demos - Help Menu *****"
	@echo
	@echo "make help       ==> This menu"
	@echo "make push       ==> Push to git using the correct SSH key (my personal one will be denied)"
	@echo


#
push:
	GIT_SSH_COMMAND="ssh -i $$HOME/.ssh/lectures_id_ed25519" git push


