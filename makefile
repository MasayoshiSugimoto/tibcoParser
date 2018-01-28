#--------------------------------------------------------------------
# Macros
#--------------------------------------------------------------------

#Compiler
CXX         = g++
#Compilation flags
INCLUDE     =
CXXFLAGS    = -Wall -std=c++11 -g $(INCLUDE)
CPPFLAGS    =
#Libraries
LDLIBS_TEST =
LDLIBS      =
LDFLAGS     =

OBJECT_DIR = build/objects
DEPENDENCY_DIR = build/dependencies
SOURCE_DIR = src

vpath %.h $(SOURCE_DIR)
vpath %.cpp $(SOURCE_DIR)
vpath %.o $(OBJECT_DIR)
vpath %.d $(DEPENDENCY_DIR)

#Executable generated
EXE = tibcoParser

SOURCES = logger.cpp\
					main.cpp\
					tibcoParser.cpp\

OBJECTS = $(addprefix $(OBJECT_DIR)/,$(SOURCES:.cpp=.o))
DEPENDENCIES = $(addprefix $(DEPENDENCY_DIR)/,$(SOURCES:.cpp=.d))

#--------------------------------------------------------------------
# Pattern rules
#--------------------------------------------------------------------

$(OBJECT_DIR)/%.o: $(SOURCE_DIR)/%.cpp $(DEPENDENCY_DIR)/%.d | buildDir
	@echo $^
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(DEPENDENCY_DIR)/%.d: %.cpp | buildDir
	@set -e;\
	rm -f $@;\
	$(CXX) -MM $(CXXFLAGS) $< > $@.$$$$;\
	sed 's,\($*\)\.o[ :]*,$(OBJECT_DIR)/\1.o $@ : ,g' < $@.$$$$ > $@;\
	rm -f $@.$$$$;\

#--------------------------------------------------------------------
# Rules
#--------------------------------------------------------------------

#Default rule (Must always be defined first in the file)
$(EXE): $(OBJECTS)
	$(CXX) $^ $(LDLIBS) -o $@

buildDir:
	mkdir -p $(OBJECT_DIR)
	mkdir -p $(DEPENDENCY_DIR)

objects: $(OBJECTS)

dependencies: $(DEPENDENCIES)

-include $(DEPENDENCIES)

#--------------------------------------------------------------------
# Phony rules
#--------------------------------------------------------------------

.PHONY: clean printVars

clean:
	rm -rf $(EXE) build

printVars:
	@echo "OBJECTS="
	@echo $(OBJECTS)
	@echo "DEPENDENCIES="
	@echo $(DEPENDENCIES)
