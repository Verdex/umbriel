
all: 
	erlc main.erl
	erlc lexer.erl	

run:
	erl -s main start

test:
	erl -s test start

clean:
	rm -rf *.beam
	rm -rf *.dump

