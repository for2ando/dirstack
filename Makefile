## Makefile for shell-sessions
OS := $(shell { uname -o 2>/dev/null || uname -s; } | tr A-Z a-z)
MKDIR = install -d
ifneq (, $(filter darwin% %bsd,$(OS)))
  INSTALL = install -pCSv
else
  INSTALL = install -Cv
endif
LIBFILES = dirstack.sh
LIBDIR = $(HOME)/lib
INITFILES = dirstack.login dirstack.logout
INITDIR = $(HOME)/lib/init.d
BASHLOGINDIR = $(HOME)/.bash_profile.d
BASHLOGOUTDIR = $(HOME)/.bash_logout.d
RCFILES = dirstack.aliases
RCDIR = $(HOME)/.bashrc.d

CMDS = help install
.PHONY: $(CMDS)

help:
	@echo "usage:"
	@$(foreach i,$(CMDS),echo "  make $i";)
	@echo See Makefile for what each commands do.

install:
	@$(MKDIR) $(LIBDIR) && $(INSTALL) $(LIBFILES) $(LIBDIR)
	@$(MKDIR) $(RCDIR) && $(INSTALL) $(RCFILES) $(RCDIR)
	@$(MKDIR) $(INITDIR) && $(INSTALL) $(INITFILES) $(INITDIR)
	@$(MKDIR) $(BASHLOGINDIR) && \
	  ln -sfv $(INITDIR)/dirstack.login $(BASHLOGINDIR)/90dirstack.login
	@$(MKDIR) $(BASHLOGOUTDIR) && \
	  ln -sfv $(INITDIR)/dirstack.logout $(BASHLOGOUTDIR)/10dirstack.logout
