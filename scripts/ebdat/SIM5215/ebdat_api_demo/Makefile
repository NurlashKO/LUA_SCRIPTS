
EBDAT_ROOT_DIR = .
EBDAT_TARGET_DIR=$(EBDAT_ROOT_DIR)/target

#source code
EBDAT_SRCS = ebdat_entry.c ebdat_func_ary.c

#object file
EBDAT_OBJS :=  $(addprefix $(EBDAT_TARGET_DIR)/, $(EBDAT_SRCS:%.c=%.o))

#target file
EBDAT_IMG = ebdat_cust_entry

#scatter load file
SCLFILE = scatter

#target file type
EXETYPE = elf

#compiler and linker
CC = armcc
LD = armlink

OUT=
OBJ_CMD    = -o
CPU = -cpu ARM926EJ-S
STACKCHK = noswst
INTRWORK = interwork
END = -littleend
CODE = $(END)
CHK = -fa
MSG = -Wb
OPT = -Ospace -O2
FNN=
EBDCLNT_OP = -DFEATURE_EBDAT_CLIENT

APCS = -apcs /$(STACKCHK)/$(INTRWORK)

CFLAGS0 = $(OUT) $(CPU) $(APCS) $(CODE) $(CHK) $(DBG) $(MSG) $(EBDCLNT_OP)
CFLAGS  = $(CFLAGS0) $(OPT) $(FNN)

MAP     = -map
INFO    = -info sizes,totals
LIST    = -list $(EBDAT_IMG).map
SYM     = -symbols -symdefs $(EBDAT_IMG).sym
SCATTER = -scatter $(SCLFILE)
ENTRY = -entry ebdat_customer_entry

LFLAGS   := $(MAP) $(INFO) $(LIST) $(SYM) $(SCATTER) $(ENTRY) -remove -nodebug

CLIB    = "$(ARMHOME)"/lib/armlib/c_t__un.l# # ARM embedded ANSI C library
FLIB    = "$(ARMHOME)"/lib/armlib/g_t_p.l#   # ARM embedded software floating 
                                                 # point library
MLIB    = "$(ARMHOME)"/lib/armlib/m_t_pu.l#  # ARM embedded software math 

ARMLIBS = $(CLIB) $(FLIB) $(MLIB)

#AMSS_ELF_SYMB= KPUBL.sym

all: $(EBDAT_IMG)

$(EBDAT_IMG): $(EBDAT_OBJS)
	@echo -------------------------------------------------------------------------
	@echo Start generate ELF image :$(EBDAT_IMG)
	$(LD) -$(EXETYPE) $(LFLAGS) $(OBJ_CMD) $(EBDAT_TARGET_DIR)/$(EBDAT_IMG).$(EXETYPE) $(ARMLIBS) $+ $(AMSS_ELF_SYMB)
	@echo -------------------------------------------------------------------------
	
clean:
	@echo Removing object files :$(EBDAT_TARGET_DIR)
	@rm -fr $(EBDAT_TARGET_DIR)/*
	
#-------------------------------------------------------------------------------
# C code inference rules
#-------------------------------------------------------------------------------
$(EBDAT_TARGET_DIR)/%.o: %.c
	@echo ------------------------------------------------------------------------
	@echo Build OBJECT $@ from SOURCE $<
	@$(CC) $(CFLAGS)   -c $(OBJ_CMD) $@ $<
	@echo ------------------------------------------------------------------------

