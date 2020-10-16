## Makefile for shell-sessions

CMDS = help install
.PHONY: $(CMDS)
INSTALL = install -pCSv
LIBFILES = dirstack.sh
LIBDIR = $(HOME)/lib
LOGINFILES = dirstack.login
LOGINDIR = $(HOME)/.bash_profile.d
LOGOUTFILES = dirstack.logout
LOGOUTDIR = $(HOME)/.bash_logout.d
RCFILES = dirstack.aliases
RCDIR = $(HOME)/.bashrc.d

help:
	@echo "usage:"
	@$(foreach i,$(CMDS),echo "  make $i";)

install:
	install -d $(LIBDIR) && $(INSTALL) $(LIBFILES) $(LIBDIR)
	install -d $(LOGINDIR) && $(INSTALL) $(LOGINFILES) $(LOGINDIR)
	install -d $(LOGOUTDIR) && $(INSTALL) $(LOGOUTFILES) $(LOGOUTDIR)
	install -d $(RCDIR) && $(INSTALL) $(RCFILES) $(RCDIR)
