## Makefile for shell-sessions

CMDS = help install
.PHONY: $(CMDS)
INSTALL = install -pCSv
LIBFILES = dirstack.sh
LIBDIR = $(HOME)/lib
INITFILES = dirstack.login dirstack.logout
INITDIR = $(HOME)/lib/init.d
RCFILES = dirstack.aliases
RCDIR = $(HOME)/.bashrc.d

help:
	@echo "usage:"
	@$(foreach i,$(CMDS),echo "  make $i";)

install:
	install -d $(LIBDIR) && $(INSTALL) $(LIBFILES) $(LIBDIR)
	install -d $(RCDIR) && $(INSTALL) $(RCFILES) $(RCDIR)
	install -d $(INITDIR) && $(INSTALL) $(INITFILES) $(INITDIR)
	ln -sf $(INITDIR)/dirstack.login $(HOME)/.bash_profile.d/90dirstack.login
	ln -sf $(INITDIR)/dirstack.logout $(HOME)/.bash_logout.d/10dirstack.logout
