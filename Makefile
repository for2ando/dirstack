## Makefile for shell-sessions

CMDS = help install
.PHONY: $(CMDS)
MKDIR = install -d
INSTALL = install -pCSv
LIBFILES = dirstack.sh
LIBDIR = $(HOME)/lib
INITFILES = dirstack.login dirstack.logout
INITDIR = $(HOME)/lib/init.d
BASHLOGINDIR = $(HOME)/.bash_profile.d
BASHLOGOUTDIR = $(HOME)/.bash_logout.d
RCFILES = dirstack.aliases
RCDIR = $(HOME)/.bashrc.d

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
