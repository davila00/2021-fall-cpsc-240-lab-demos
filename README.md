
# Lab Demos

This repository is just a collection of the demonstrations presented in lab, where applicable and/or useful.

Copyright Puh P

## TODO:

Demonstration stuffs that are still pending:

### BSS Section for Input Buffer

* Show the .bss section and how it can be used to create an input buffer

    * Reference: Section 4.5 in the book

    * Idea: Show how to ask libP to input a user string as text to a byte buffer in the .bss section

    * Reminder: Future assignments may require a stack-based buffer, rather than a global .bss based buffer

        * Talk about the difference between the data contained in the .bss and .data sections


## Sub-Directories

Each subdirectory is its own demonstration and should contain all files needed for that demo. Use the Makefile inside to run building commands.

Students won't need to use the Makefile at the root of this repository. It's just for me. Feel free to study it for your own learning.

## Git Tags

You may notice this repository also contains "git tags". You can view them with the following command:

```git tag```

Git tags allow you to assign human-readable labels to specific commits in the repository. Usually, a tag might look like *v1.12.6*. In this class, we'll use git tags that correspond to the date we did something in lab, so you can better see the power of git with respect to looking back on the state of your repository at a previous point in time.

For example, you can see what this repo looked like after the first day we began our assembly demonstrations with the following command:

```git checkout 2021-09-02```

When you are finished, get back to the current state by checking out the master branch with:

```git checkout master```

