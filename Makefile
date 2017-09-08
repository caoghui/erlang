.SUFFIXES: 	.erl .beam
.erl.beam:
	erlc -W $<

#module want to be build
DIRS=tcp_rpc event

RECURSIVE_MAKE= [ -n "$(DIRS)" ] && for i in $(DIRS); do \
                (cd $$i && $(MAKE) SDIR=$$i --no-print-directory) || exit 1; \
                done;

all: desc clean
	@$(RECURSIVE_MAKE)
	
compile: ${MODS:%=%.beam}



.PHONY:clean show
show:
	@echo ${DIRS}

desc:
	@echo "module : [$(DIRS)]"

clean:
	@rm -rf *.beam *.dump convert
	@for d in $(DIRS) ; do make clean -C $$d OUTPUT_DIR=.. TARGET_DIR=$$d/ --no-print-directory ; done
