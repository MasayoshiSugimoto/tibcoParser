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

#Source directory
vpath %.h src
vpath %.cpp src
vpath %.h tests
vpath %.cpp tests
#Program created
EXE = tibcoParser
OBJECTS = tibcoParser.o\
					logger.o

#--------------------------------------------------------------------
# Pattern rules
#--------------------------------------------------------------------

%.o: %.cpp
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@

#--------------------------------------------------------------------
# Rules
#--------------------------------------------------------------------

#Main
$(EXE): main.o $(OBJECTS)
	$(CXX) $^ $(LDLIBS) -o $@

main.o: tibcoParser.h

#--------------------------------------------------------------------
# Phony rules
#--------------------------------------------------------------------

.PHONY: clean

clean:
	rm -rf $(EXE) *.o
