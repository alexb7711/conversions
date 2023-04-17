##===============================================================================
# Configuration
# https://peon-developments.blogspot.com/2011/07/creating-and-using-c-shared-libraries.html

# Directories
BIN = bin
SRC = src
TST = test
OBJ = .obj

# Virtual paths
vpath %.cpp $(SRC)
vpath %.cpp $(TST)

# Compiler
CC     = gcc
CFLAGS = -fPIC -c -Wall -g -Os

# Linking
LD           = $(CC)
LDFLAGS      = -lstdc++ -lm
LDTESTFLAGS += $(LDFLAGS) -lgtest

# Source files
SRC_TARGET    = $(BIN)/libconversions.so
SRC_FILES     = $(shell find ./src -name "*.cpp")
SRC_OBJECTS  := $(patsubst %.cpp, $(OBJ)/%.o, $(notdir $(SRC_FILES)))

# Test files
TEST_TARGET   = $(BIN)/conversion_test
TEST_FILES    = $(shell find . ! -wholename "src/main.cpp" -name "*.cpp")
TEST_OBJECTS := $(patsubst %.cpp, $(OBJ)/%.o, $(notdir $(TEST_FILES)))

##===============================================================================
# Recipes

##-------------------------------------------------------------------------------
# Library

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
all: $(BIN) $(OBJ) $(SRC_TARGET)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
$(SRC_TARGET): $(SRC_OBJECTS)
	$(LD) -shared  -o $@ $^ $(LDFLAGS)

##-------------------------------------------------------------------------------
# Test

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
test: $(BIN) $(OBJ) $(TEST_TARGET)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
$(TEST_TARGET): $(TEST_OBJECTS)
	$(LD) -o $@ $^ $(LDTESTFLAGS)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
run_test:
	./bin/conversion_test --report_level=detailed

##-------------------------------------------------------------------------------
# Global

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
$(OBJ)/%.o: %.cpp
	$(CC) $(CFLAGS) $^ -o $@

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
$(OBJ):
	@mkdir -p $(OBJ)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
$(BIN):
	@mkdir -p $(BIN)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
clean:
	@rm -fv $(SRC_TARGET)
	@rm -fv $(TEST_TARGET)
	@rm -fv $(SRC_OBJECTS)
