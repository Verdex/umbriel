
all: 
	erlc main.erl

run:
	erl -s main start

clean:
	rm -rf *.beam
	rm -rf *.dump

