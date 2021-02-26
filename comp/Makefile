CFLAGS += -Wall -g3 -Os

compiler: compiler.o
	${CC} $^ -o $@

compiler.o: compiler.c

clean:
	rm -f compiler compiler.o
