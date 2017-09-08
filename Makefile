.SUFFIXES: 	.erl .beam
.erl.beam:
	erlc -W $<

ERL  = erl -boot start_clean
SRCS = $(wildcard *.erl)
MODS = $(patsubst %.erl,%,$(SRCS))

all:compile

compile: ${MODS:%=%.beam}



.PHONY:clean show
show:
	@echo ${MODS}

clean:
	@rm -rf *.beam *.dump convert
