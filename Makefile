## Makefile for shell-sessions
OS := $(shell { uname -o 2>/dev/null || uname -s; } | tr A-Z a-z)
KERNELVER := $(shell { uname -v 2>/dev/null; } | tr A-Z a-z)
XPAGER := $(shell which pageless || echo $${PAGER:-less})
INSTALL_OPTION_p := $(shell touch t1; if install -p t1 t2 >/dev/null 2>&1; then echo p; fi; rm t[12])
INSTALL_OPTION_C := $(shell touch t1; if install -C t1 t2 >/dev/null 2>&1; then echo C; fi; rm t[12])
INSTALL_OPTION_S := $(shell touch t1; if install -S t1 t2 >/dev/null 2>&1; then echo S; fi; rm t[12])
INSTALL_OPTION_v := $(shell touch t1; if install -v t1 t2 >/dev/null 2>&1; then echo v; fi; rm t[12])
lowercase = $(subst A,a,$(subst B,b,$(subst C,c,$(subst D,d,$(subst E,e,$(subst F,f,$(subst G,g,$(subst H,h,$(subst I,i,$(subst J,j,$(subst K,k,$(subst L,l,$(subst M,m,$(subst N,n,$(subst O,o,$(subst P,p,$(subst Q,q,$(subst R,r,$(subst S,s,$(subst T,t,$(subst U,u,$(subst V,v,$(subst W,w,$(subst X,x,$(subst Y,y,$(subst Z,z,$(1)))))))))))))))))))))))))))
uppercase = $(subst a,A,$(subst b,B,$(subst c,C,$(subst d,D,$(subst e,E,$(subst f,F,$(subst g,G,$(subst h,H,$(subst i,I,$(subst j,J,$(subst k,K,$(subst l,L,$(subst m,M,$(subst n,N,$(subst o,O,$(subst p,P,$(subst q,Q,$(subst r,R,$(subst s,S,$(subst t,T,$(subst u,U,$(subst v,V,$(subst w,W,$(subst x,X,$(subst y,Y,$(subst z,Z,$(1)))))))))))))))))))))))))))
MKDIR = install -d
ifneq (, $(filter ish%,$(KERNELVER)))
  INSTALL = function installv() { install -p $$1 $$2 && echo install -p $$1 $$2;}; installv
else
ifneq (, $(filter darwin% %bsd,$(OS)))
  INSTALL = install -pCSv
else
  INSTALL = install -$(INSTALL_OPTION_p)$(INSTALL_OPTION_S)$(INSTALL_OPTION_V)$(INSTALL_OPTION_v)
endif
endif
DIFF = diff -u
LIBFILES = dirstack.sh
LIBDIR = $(HOME)/lib
INITFILES = dirstack.login dirstack.logout
INITDIR = $(HOME)/lib/init.d
LOGIN_PRIOLITY = 90
LOGIN_PRIOLITY_LEGACY = 90
LOGOUT_PRIOLITY = 10
LOGOUT_PRIOLITY_LEGACY = 10
BASHLOGINDIR = $(HOME)/.bash_profile.d
BASHLOGOUTDIR = $(HOME)/.bash_logout.d
BASHRCFILES = dirstack.aliases
BASHRCDIR = $(HOME)/.bashrc.d
BASHEXITRCDIR = $(HOME)/.bashexitrc.d
MAKECMDS = help install diff

.PHONY: $(CMDS)

help:
	@$(MAKE) --no-print-directory _$@ | $(XPAGER)

_help:
	@echo usage:
	@$(foreach i,$(MAKECMDS),echo "  make $i";)
	@echo "See Makefile about functions of each commands."

install: install-lib install-init remove-bashlogin install-bashrc remove-bashlogout install-bashexitrc

install-lib install-init::
	$(eval dest := $(call uppercase,$(patsubst install-%,%,$@)))
	$(eval dir := $$($(dest)DIR))
	$(eval files := $$($(dest)FILES))
	@$(MKDIR) $(dir) && $(INSTALL) $(files) $(dir)

remove-bashlogin::
	rm -f $(addprefix $(BASHLOGINDIR)/,$(addsuffix dirstack.login,$(LOGIN_PRIOLITY_LEGACY)))

install-bashrc::
	@$(MKDIR) $(BASHRCDIR) && { \
	  ln -sfv $(INITDIR)/dirstack.login $(BASHRCDIR)/$(LOGIN_PRIOLITY)dirstack.login; \
	  $(INSTALL) $(BASHRCFILES) $(BASHRCDIR); \
	}

remove-bashlogout::
	rm -f $(addprefix $(BASHLOGOUTDIR)/,$(addsuffix dirstack.logout,$(LOGOUT_PRIOLITY_LEGACY)))

install-bashexitrc::
	@$(MKDIR) $(BASHEXITRCDIR) && \
	  ln -sfv $(INITDIR)/dirstack.logout $(BASHEXITRCDIR)/$(LOGOUT_PRIOLITY)dirstack.logout

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

