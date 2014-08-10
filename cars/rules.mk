CARDIR := $(TOP)$(notdir $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))/
INCDIRS += $(CARDIR)$(INCDIR)
LIBS += car
LIBDIRS += $(CARDIR)
