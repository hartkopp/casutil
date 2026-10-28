#
# Make Casio utilities
#
CC=gcc
CCOPTS=-o $@ -Wno-format
CCOPTS+=-Wno-parentheses -Wno-pointer-sign -Wno-switch \
        -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast

SRC=src
MD100=md100
OWNER=root:root
DIST=/usr/local/bin

programs:=	wav2raw wav2wav			\
		wave730 wave850 waveX07		\
		list702 list730 list850 list8000	\
		listX07 list74 list602		\
		wave602 bas702 bas730 bas850 basX07
src_files:=	$(addprefix $(SRC)/,$(programs))
files:=		$(src_files) $(MD100)/md100
scripts:=	$(wildcard $(MD100)/*.sh)
dist_files:=	$(foreach f,$(files) $(scripts),$(DIST)/$(notdir $f))

all:	$(files)

clean:
	rm -f $(SRC)/*.o

distclean: clean
	rm -f $(files) casutil.zip

install: $(files) $(scripts)
	cp $(files) $(scripts) $(DIST)
	chmod 755 $(dist_files)
	chown $(OWNER) $(dist_files)

zip:
	rm -f casutil.zip
	zip casutil.zip -r COPYING INSTALL README.md Makefile		\
		$(SRC)/*.c $(SRC)/*.h					\
		$(MD100)/*.c $(MD100)/*.sh $(MD100)/*.txt		\
		doc pb-dump -x */.* doc/tmp/ doc/tmp/*

$(SRC)/wave.o:	$(SRC)/wave.c $(SRC)/wave.h
	$(CC) $(CCOPTS)	-c $<

$(src_files): $(SRC)/%: $(SRC)/%.c $(SRC)/wave.o $(SRC)/wave.h
	$(CC) $(CCOPTS)	$< $(SRC)/wave.o

$(SRC)/list602: $(SRC)/fx602.h

$(MD100)/md100:	$(MD100)/md100.c
	$(CC) $(CCOPTS)	$<

.PHONY:	all clean distclean install zip
