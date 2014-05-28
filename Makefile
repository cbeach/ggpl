CC=g++
IDIR =./
CFLAGS=-I$(IDIR)
OUT_NAME=main
OUT_DIR=./bin
OUT_PATH=$(OUT_DIR)/$(OUT_NAME)
GDL_SRC=./src/gdl

ODIR=obj

_DEPS=parser.h
DEPS=$(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ=gdl_main.o parser.o 
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

all: $(OBJ)
	$(CC) -o $(OUT_PATH) $^ $(CFLAGS)

obj/%.o: $(GDL_SRC)/%.cpp $(DEPS)
	$(CC) -c -o $@ ./scr/gdl/$< $(CFLAGS)

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ 
