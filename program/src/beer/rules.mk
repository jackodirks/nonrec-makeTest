CURDIRNAME := $(notdir $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))/
BEERDIR := $(PROGRAMDIR)$(SRCDIR)$(notdir $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))/
BEERSRC := $(BEERDIR)
BEERCFILES := $(wildcard $(BEERSRC)*.c)
BEER_OFILES := $(patsubst %.c,%.o,$(BEERCFILES))

#Debug part
BEERDEBUGDIR := $(PROGRAMDIR)$(DEBUG_OBJECTS_DIR)$(CURDIRNAME)
BEERDOFILES := $(patsubst $(BEERDIR)%,$(BEERDEBUGDIR)%,$(BEER_OFILES))
DOFILES += $(BEERDOFILES)

#Release part
BEERRELEASEDIR := $(PROGRAMDIR)$(RELEASE_OBJECTS_DIR)$(CURDIRNAME)
BEERROFILES := $(patsubst $(BEERDIR)%,$(BEERRELEASEDIR)%,$(BEER_OFILES))
OFILES += $(BEERROFILES)

#Make sure the output paths are created
DEBUGDIRS += $(BEERDEBUGDIR)
RELEASEDIRS += $(BEERRELEASEDIR)

#DEP files
-include $(BEERDOFILES:%.o=%.d)
-include $(BEERROFILES:%.o=%.d)

#rule
$(BEERDEBUGDIR)%.o $(BEERRELEASEDIR)%.o: $(BEERSRC)%.c 
	$(CC) $(CFLAGS) -c $< -o $@
