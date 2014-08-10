include mk/parsers.mk
include mk/emptyvars.mk
include mk/predefined.mk
include mk/flags.mk

TARGET := program

DEBUG_DIR := debug/
RELEASE_DIR := release/
OBJ_DIR := obj/
DEBUG_OBJECTS_DIR := $(OBJ_DIR)$(DEBUG_DIR)
RELEASE_OBJECTS_DIR := $(OBJ_DIR)$(RELEASE_DIR)

RELEASETARGET := $(RELEASE_DIR)$(TARGET)
DEBUGTARGET := $(DEBUG_DIR)$(TARGET)
TARGETRECEIPE = $(CC) $(LDFLAGS) -o $@ $^ $(LIB)

DEBUGDIRS += $(DEBUG_DIR)
RELEASEDIRS += $(RELEASE_DIR)

DIRS := $(shell ls -d */)
DIRS := $(DIRS:=rules.mk)
TOP := ./

.PHONY: echo all debug prebuild

all: CFLAGS += -O2
all: prebuild
all: $(RELEASETARGET)

debug: CFLAGS += -DDEBUG -g
debug: prebuild
debug: $(DEBUGTARGET)

-include $(DIRS)

INC := $(addprefix -I,$(INCDIRS))
LIBDIR := $(addprefix -L,$(LIBDIRS))
LIB := $(addprefix -l,$(LIBS))

clean:
	@-rm $(OFILES) 
	@-rm $(DOFILES)

distclean:
	@rm -rf $(DEBUGDIRS)
	@rm -rf $(RELEASEDIRS)

echo:
	@echo "dirs:" $(DIRS)
	@echo "incdirs:" $(INCDIRS)
	@echo "debugdirs:" $(DEBUGDIRS)
	@echo "releasedirs:" $(RELEASEDIRS)
	@echo "libdirs:" $(LIBDIRS)
	@echo "libs:" $(LIBS) 
	@echo "ofiles:" $(OFILES)
	@echo "dofiles:" $(DOFILES)
	@echo "DEBUGDIRS" $(DEBUGDIRS)
	@echo "releasedirs" $(RELEASEDIRS)
	@echo "ANIMALSRELEASEDIR" $(ANIMALSRELEASEDIR)
	@echo "ANIMALSCFILES" $(ANIMALSCFILES)

prebuild:
	@mkdir -p $(DEBUGDIRS)
	@mkdir -p $(RELEASEDIRS)

$(RELEASETARGET) : $(OFILES)
	$(TARGETRECEIPE)

$(DEBUGTARGET): $(DOFILES)
	$(TARGETRECEIPE)

