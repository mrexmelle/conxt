
[![Build Status](https://travis-ci.org/mrexmelle/conxt.svg?branch=master)](https://travis-ci.org/mrexmelle/conxt)

# Description
Conxt is a mini-tool to generate a list of constants from an XML file.

# Installation
Download the source code:

	git clone https://github.com/mrexmelle/conxt

Enter conxt directory

	cd conxt

Compile and install it:
	
	make install
	
This will install the conxt binary into `/usr/local/bin` directory.

# Usage
Conxt converts an xml **filename** containing a list of constants into an expected **target_language**. The command should be composed to be like this:

	conxt <filename> --target-lang=<target_language>
	
Currently conxt only supports three **target_language**, which are *java*, *python*, and *c++*.

# Example
You can run the example by typing the following command from the project root directory:
	
	conxt data/test.xml --target-lang=c++
	
