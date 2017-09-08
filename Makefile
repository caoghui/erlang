.SUFFIXES: 	.erl .beam
.erl.beam:
	erlc -W $<

#module want to be build
SDIRS=tcp_rpc event

RECURSIVE_MAKE= [ -n "$(DIRS)" ] && for i in $(SDIRS); do \
                (cd $$i && $(MAKE) SDIR=$$i --no-print-directory) || exit 1; \
                done;

all: desc $(RECURSIVE_MAKE)

compile: ${MODS:%=%.beam}



.PHONY:clean show
show:
	@echo ${DIRS}

desc:
	@echo $(DIRS)

clean:
	@rm -rf *.beam *.dump convert
	@for d in $(DIRS) ; do make clean -C $$d OUTPUT_DIR=.. TARGET_DIR=$$d/ --no-print-directory ; done
