
PROJECT=conxt

all:
	clang src/*.m -F /Library/Frameworks -framework Foundation -o $(PROJECT)

clean:
	rm -f $(PROJECT)

install: all
	cp $(PROJECT) /usr/local/bin