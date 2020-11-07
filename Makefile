CC        := clang
CFLAGS    := -Wall -Werror
EXEC      := main
DIR_SRC   := source
DIR_BUILD := build

FILES_C   := $(foreach dir,$(DIR_SRC),$(wildcard $(dir)/*.c))
FILES_O   := $(addprefix $(DIR_BUILD)/,$(patsubst $(DIR_SRC)/%.c,%.o,$(FILES_C)))

.PRECIOUS: $(DIR_BUILD)/%.o

all: $(addprefix $(DIR_BUILD)/,$(EXEC))
	
	@echo "Build successful"

clean:
	
	@echo "Removing build files"
	@rm -rf $(DIR_BUILD)/*

test: all
	
	@./$(DIR_BUILD)/$(EXEC)

build/%.o: $(DIR_SRC)/%.c
	
	@echo "Compiling $*.c"
	@$(CC) $(CFLAGS) -c $< -o $@

build/%: $(FILES_O)
	
	@echo "Linking executable"
	@$(CC) $(CFLAGS) $^ -o $@
