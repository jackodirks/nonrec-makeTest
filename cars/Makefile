CC=gcc
AR=ar
RANLIB=ranlib
SRCDIR=src/
CFILES=$(wildcard $(SRCDIR)*.c)
_OFILES=$(patsubst %.c,%.o,$(CFILES))
INC= -I inc/
LIB=
LIBDIR= -L lib/
#LDFLAGS=-s $(LIB)
LDFLAGS=
CFLAGS=-Wall -std=c99 $(INC)
ODIR=obj/
OFILES = $(patsubst src/%,$(ODIR)%,$(_OFILES))
TARGET=libcar.a
ARFLAGS=rcs

.PHONY: all clean debug

all: pre-build $(TARGET)
all: CFLAGS += -O2 
all: LDFLAGS += -fopenmp

debug: CFLAGS +=-DDEBUG -g -pg -fopenmp
debug: LDFLAGS +=-g -pg -fopenmp
debug: pre-build $(TARGET)

profile: CFLAGS +=-DPROFILE -g -pg -fopenmp
profile: LDFLAGS +=-g -pg -fopenmp
profile: pre-build $(TARGET)


pre-build:
	@mkdir -p $(ODIR)
	 
$(ODIR)%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@ 

$(TARGET): $(OFILES) 
	$(AR) $(ARFLAGS) $@ $^
    

clean:
	@rm -rf $(ODIR)
	@rm $(TARGET)
