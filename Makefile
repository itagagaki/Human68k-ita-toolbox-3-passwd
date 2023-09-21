# Makefile for ITA TOOLBOX #3 PASSWD

AS	= HAS.X -i $(INCLUDE)
LK	= hlk.x -x
CV      = -CV.X -r
CP      = cp
RM      = -rm -f

INCLUDE = $(HOME)/fish/include

DESTDIR   = A:/bin
BACKUPDIR = B:/passwd/0.3
RELEASE_ARCHIVE = PASSWD03
RELEASE_FILES = MANIFEST README ../NOTICE CHANGES passwd.att passwd.ucb passwd.1 passwd.5

EXTLIB = $(HOME)/fish/lib/ita.l

###

PROGRAM = passwd.att passwd.ucb

###

.PHONY: all clean clobber install release backup

.TERMINAL: *.h *.s

%.r : %.x	; $(CV) $<
%.x : %.o	; $(LK) $< $(EXTLIB)
%.o : %.s	; $(AS) $<

###

all:: $(PROGRAM)

clean::

clobber:: clean
	$(RM) *.bak *.$$* *.o *.x

###

$(PROGRAM) : $(INCLUDE)/doscall.h $(INCLUDE)/chrcode.h $(EXTLIB)

include ../Makefile.sub

###

passwd.att : passwd.s
	$(AS) -s SYSV=1 -s BSD=0 passwd.s
	$(LK) -o passwd.att passwd.o $(EXTLIB)
	$(RM) passwd.o

###

passwd.ucb : passwd.s
	$(AS) -s SYSV=0 -s BSD=1 passwd.s
	$(LK) -o passwd.ucb passwd.o $(EXTLIB)
	$(RM) passwd.o

###
