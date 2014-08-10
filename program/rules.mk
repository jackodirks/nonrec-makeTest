PROGRAMDIR := $(TOP)$(notdir $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))/
INCDIRS += $(shell find $(PROGRAMDIR)$(INCDIR) -type d)
PROGRAMSRC := $(PROGRAMDIR)$(SRCDIR)
PROGRAMCFILES := $(wildcard $(PROGRAMSRC)*.c) 
PROGRAM_OFILES := $(patsubst %.c,%.o,$(PROGRAMCFILES)) 

#Debug part
PROGRAMDEBUGDIR := $(PROGRAMDIR)$(DEBUG_OBJECTS_DIR)
PROGRAMDOFILES := $(patsubst $(PROGRAMDIR)$(SRCDIR)%,$(PROGRAMDEBUGDIR)%,$(PROGRAM_OFILES))
DOFILES += $(PROGRAMDOFILES)

#Release part
PROGRAMRELEASEDIR := $(PROGRAMDIR)$(RELEASE_OBJECTS_DIR)
PROGRAMROFILES := $(patsubst $(PROGRAMDIR)$(SRCDIR)%,$(PROGRAMRELEASEDIR)%,$(PROGRAM_OFILES))
OFILES += $(PROGRAMROFILES)

#Make sure the output paths are created
DEBUGDIRS += $(PROGRAMDEBUGDIR)
RELEASEDIRS += $(PROGRAMRELEASEDIR)

#Include the rules about the dependency files
-include $(PROGRAMDOFILES:%.o=%.d)
-include $(PROGRAMROFILES:%.o=%.d)

#include subdir
include $(PROGRAMDIR)src/beer/rules.mk

$(PROGRAMDEBUGDIR)%.o $(PROGRAMRELEASEDIR)%.o: $(PROGRAMSRC)%.c 
	$(CC) $(CFLAGS) -c $< -o $@
