.SUFFIXES: 	.erl .beam
.erl.beam:
	erlc -W -o ebin $<

#命令定义
ERL   = erl -boot start_clean
MKDIR = @mkdir -p
RM    = @rm -rf 
ECHO  = @echo 

# 应用目录结构
DOC_DIR = doc
BIN_DIR = ebin
INC_DIR = include
PRI_DIR = priv
SRC_DIR = src
APP_DIR = $(DOC_DIR) $(BIN_DIR) $(INC_DIR) $(PRI_DIR) $(SRC_DIR)

#变量定义
SRCS = $(wildcard $(SRC_DIR)/*.erl)
MODS = $(patsubst %.erl, %, $(notdir $(SRCS)))
TARS = $(patsubst %, ${BIN_DIR}/%.beam, $(MODS))

#all:${TARS}
all:compile
#	${ERL} -s hello start

#compile: ${MODS:%=%.beam}
compile:
	erlc -o ${BIN_DIR} ${SRCS}

#compile: ${TARS}

${TARS}:${SRC_DIR}/*.erl
	erlc -o ${BIN_DIR} $<

init:
	${MKDIR} ${DOC_DIR}
	${MKDIR} ${BIN_DIR}
	${MKDIR} ${INC_DIR}
	${MKDIR} ${PRI_DIR}
	${MKDIR} ${SRC_DIR}

.PHONY:clean cleanall show
show:
	${ECHO} ${SRCS}
	${ECHO} ${MODS}
	${ECHO} ${TARS}
	${ECHO} ${APP_DIR}

clean:
	${RM} ${TARS} *.dump

cleanall:
	${RM} ${TARS} *.dump
#	${RM} ${APP_DIR}


