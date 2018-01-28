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

vpath %h src
vpath %cpp src
vpath %o $(OBJECT_DIR)

#Executable generated
EXE = tibcoParser

SOURCES = logger.cpp\
					main.cpp\
					tibcoParser.cpp\
#OBJECTS = $(addprefix $(OBJECT_DIR), $(SOURCES:.cpp=.o))
OBJECTS = $(addprefix $(OBJECT_DIR)/,$(SOURCES:.cpp=.o))
DEPENDENCIES = $(addprefix $(DEPENDENCY_DIR)/,$(SOURCES:.cpp=.d))

#--------------------------------------------------------------------
# Pattern rules
#--------------------------------------------------------------------

%.o: %.cpp %.d | $(OBJECT_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $(OBJECT_DIR)/$@

%.d: %.cpp
	@set -e;\
	rm -f $@;\
	$(CXX) -MM $(CXXFLAGS) $< > $@.$$$$;\
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@;\
	rm -f $@.$$$$;\

#--------------------------------------------------------------------
# Rules
#--------------------------------------------------------------------

#Default rule (Must always be defined first in the file)
$(EXE): $(OBJECTS)
	$(CXX) $^ $(LDLIBS) -o $@

#include $(OBJECTS:.o=.d)

#--------------------------------------------------------------------
# Phony rules
#--------------------------------------------------------------------

.PHONY: clean $(OBJECT_DIR) printVars

clean:
	rm -rf $(EXE) *.o *.d *.d.*

$(OBJECT_DIR):
	mkdir -p $(OBJECT_DIR)

printVars:
	@echo "OBJECTS="
	@echo $(OBJECTS)
	@echo "DEPENDENCIES="
	@echo $(DEPENDENCIES)
