## Makefile for shell-sessions
OS := $(shell { uname -o 2>/dev/null || uname -s; } | tr A-Z a-z)
XPAGER := $(shell which pageless || echo $${PAGER:-less})
lowercase = $(subst A,a,$(subst B,b,$(subst C,c,$(subst D,d,$(subst E,e,$(subst F,f,$(subst G,g,$(subst H,h,$(subst I,i,$(subst J,j,$(subst K,k,$(subst L,l,$(subst M,m,$(subst N,n,$(subst O,o,$(subst P,p,$(subst Q,q,$(subst R,r,$(subst S,s,$(subst T,t,$(subst U,u,$(subst V,v,$(subst W,w,$(subst X,x,$(subst Y,y,$(subst Z,z,$(1)))))))))))))))))))))))))))
uppercase = $(subst a,A,$(subst b,B,$(subst c,C,$(subst d,D,$(subst e,E,$(subst f,F,$(subst g,G,$(subst h,H,$(subst i,I,$(subst j,J,$(subst k,K,$(subst l,L,$(subst m,M,$(subst n,N,$(subst o,O,$(subst p,P,$(subst q,Q,$(subst r,R,$(subst s,S,$(subst t,T,$(subst u,U,$(subst v,V,$(subst w,W,$(subst x,X,$(subst y,Y,$(subst z,Z,$(1)))))))))))))))))))))))))))
MKDIR = install -d
ifneq (, $(filter darwin% %bsd,$(OS)))
  INSTALL = install -pCSv
else
  INSTALL = install -Cv
endif
DIFF = diff -u
LIBFILES = dirstack.sh
LIBDIR = $(HOME)/lib
INITFILES = dirstack.login dirstack.logout
INITDIR = $(HOME)/lib/init.d
BASHLOGINDIR = $(HOME)/.bash_profile.d
BASHLOGOUTDIR = $(HOME)/.bash_logout.d
RCFILES = dirstack.aliases
RCDIR = $(HOME)/.bashrc.d
MAKECMDS = help install diff

.PHONY: $(CMDS)

help:
	@$(MAKE) --no-print-directory _$@ | $(XPAGER)

_help:
	@echo usage:
	@$(foreach i,$(MAKECMDS),echo "  make $i";)
	@echo "See Makefile about functions of each commands."

install: install-lib install-rc install-init install-bashlogin install-bashlogout

install-lib install-rc install-init::
	$(eval dest := $(call uppercase,$(patsubst install-%,%,$@)))
	$(eval dir := $$($(dest)DIR))
	$(eval files := $$($(dest)FILES))
	@$(MKDIR) $(dir) && $(INSTALL) $(files) $(dir)

install-bashlogin::
	@$(MKDIR) $(BASHLOGINDIR) && \
	  ln -sfv $(INITDIR)/dirstack.login $(BASHLOGINDIR)/90dirstack.login

install-bashlogout::
	@$(MKDIR) $(BASHLOGOUTDIR) && \
	  ln -sfv $(INITDIR)/dirstack.logout $(BASHLOGOUTDIR)/10dirstack.logout

diff diff-lib diff-rc diff-init diff-bashlogin diff-bashlogout:
	@$(MAKE) --no-print-directory _$@ | $(XPAGER)

_diff: _diff-lib _diff-rc _diff-init _diff-bashlogin _diff-bashlogout

_diff-lib _diff-rc _diff-init _diff-bashlogin _diff-bashlogout:
	$(eval dest := $(call uppercase,$(patsubst _diff-%,%,$@)))
	$(eval dir := $$($(dest)DIR))
	$(eval files := $$($(dest)FILES))
	@$(foreach f,$(files), \
	  echo -------$(DIFF) $(dir)/$f $f; \
	  $(DIFF) $(dir)/$f $f || true; \
	)

