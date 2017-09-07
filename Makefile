.SUFFIXES: 	.erl .beam
.erl.beam:
	erlc -W $<

ERL  = erl -boot start_clean
SRCS = $(wildcard *.erl)
MODS = $(patsubst %.erl,%,$(SRCS))
all:compile
#	${ERL} -s hello start

compile: ${MODS:%=%.beam}

cpp:
	g++ -g -o convert convert.cpp

.PHONY:clean show
show:
	@echo ${MODS}

clean:
	@rm -rf *.beam *.dump convert