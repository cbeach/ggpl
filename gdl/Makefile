CC=g++
IDIR =./include
CFLAGS=-I$(IDIR)
OUT_NAME=main

ODIR=obj
#LDIR =../lib

_DEPS=parser.h
DEPS=$(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ=gdl_main.o parser.o 
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

all: $(OBJ)
	$(CC) -o $(OUT_NAME) $^ $(CFLAGS)
	
#obj/gdl_main.o: gdl_main.cpp ./include/parser.h
#	$(info $@)
#	g++ -c -o obj/gdl_main.o gdl_main.cpp $(CFLAGS)
#
#obj/parser.o: parser.cpp ./include/parser.h 
#	g++ -c -o obj/parser.o parser.cpp $(CFLAGS)
		
obj/%.o: %.cpp $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ 
