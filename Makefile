LIB_NAME= lua-discount
VERSION= 2.1.8

# change these to reflect your Lua installation
LUA= /usr
LUAINC= $(LUA)/include/lua5.1
LUALIB= $(LUA)/lib
LUABIN= $(LUA)/bin

# probably no need to change anything below here
CC= gcc
CFLAGS= $(INCS) $(WARN) -O2 -fPIC ${DEFS}
WARN= -Wall
INCS= -I$(LUAINC)
DEFS = 

DISCOUNT_OBJS = basename.o \
  Csio.o \
	css.o \
	docheader.o \
	dumptree.o \
	emmatch.o \
	generate.o \
	markdown.o \
	mkdio.o \
	resource.o \
	toc.o \
	xml.o
OBJS=  $(DISCOUNT_OBJS) ldiscount.o
SOS= discount.so

all: $(SOS)

$(SOS): $(OBJS)
	$(CC) -o $@ -shared $(OBJS) $(LIBS)

.PHONY: clean tar
clean:
	rm -f $(OBJS) $(SOS) core core.* a.out

tar: clean
	git archive --format=tar --prefix=$(LIB_NAME)-$(VERSION)/ $(VERSION) | gzip > $(LIB_NAME)-$(VERSION).tar.gz

