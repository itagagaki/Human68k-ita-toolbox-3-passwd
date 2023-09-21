#! A:/bin/MAKE.X -f
# Makefile for PASSWD

AS	= \usr\pds\HAS.X -l -i $(INCLUDE)
LK	= \usr\pds\hlk.x -x
CV      = -\bin\CV.X -r
INSTALL = copy
BACKUP  = A:\bin\COPYALL.X -t
CP      = copy
RM      = -\usr\local\bin\rm -f

INCLUDE = ../fish/include

DESTDIR   = A:\bin
BACKUPDIR = B:\passwd\0.1

EXTLIB = $(HOME)/fish/lib/ita.l

###

PROGRAMS = passwd.att passwd.ucb

###

.PHONY: all clean clobber install backup

.TERMINAL: *.h *.s

%.r : %.x	; $(CV) $<
%.x : %.o	; $(LK) $< $(EXTLIB)
%.o : %.s	; $(AS) $<

###

all:: $(PROGRAMS)

clean::

clobber:: clean
	$(RM) *.bak *.$$* *.o *.x

###

$(PROGRAMS) : $(INCLUDE)/doscall.h $(INCLUDE)/chrcode.h $(EXTLIB)

install::
	$(INSTALL) passwd.att $(DESTDIR)\passwd.x

backup::
	$(BACKUP) *.* $(BACKUPDIR)

clean::
	$(RM) passwd.o

###

passwd.att : passwd.s
	$(AS) -s SYSV=1 -s BSD=0 passwd.s
	$(LK) -o passwd.att passwd.o $(EXTLIB)
	$(RM) passwd.o

clean::
	$(RM) passwd.att

###

passwd.ucb : passwd.s
	$(AS) -s SYSV=0 -s BSD=1 passwd.s
	$(LK) -o passwd.ucb passwd.o $(EXTLIB)
	$(RM) passwd.o

clean::
	$(RM) passwd.ucb

###
