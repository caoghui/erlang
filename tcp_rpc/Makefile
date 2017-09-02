.SUFFIXES: 	.erl .beam
.erl.beam:
	erlc -W $<

#命令定义
ERL   = erl -boot start_clean
MKDIR = @mkdir -p
RM    = @rm -rf 
ECHO  = @echo 

#变量定义
SRCS = $(wildcard *.erl)
MODS = $(patsubst %.erl, %, $(SRCS))
TARS = $(patsubst %.erl, %.beam, $(SRCS))

# 应用目录结构
DOC_DIR = doc
BIN_DIR = ebin
INC_DIR = include
PRI_DIR = priv
SRC_DIR = src
APP_DIR = $(DOC_DIR) $(BIN_DIR) $(INC_DIR) $(PRI_DIR) $(SRC_DIR)


all:compile
#	${ERL} -s hello start

compile: ${MODS:%=%.beam}

init:
	${MKDIR} ${DOC_DIR}
	${MKDIR} ${BIN_DIR}
	${MKDIR} ${INC_DIR}
	${MKDIR} ${PRI_DIR}
	${MKDIR} ${SRC_DIR}

.PHONY:clean cleanall show
show:
	${ECHO} ${MODS}
	${ECHO} ${TARS}
	${ECHO} ${APP_DIR}

clean:
	${RM} ${TARS} *.dump

cleanall:
	${RM} ${TARS} *.dump
	${RM} ${APP_DIR}