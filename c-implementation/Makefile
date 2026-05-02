EXENAME = main
OBJS = main.o

CXX = g++
CXXFLAGS = -std=c++14 -Wall
LDFLAGS = -lssl -lcrypto -lboost_system

all: $(EXENAME)

$(EXENAME): $(OBJS)
	$(CXX) $(OBJS) $(LDFLAGS) -o $(EXENAME)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	-rm -f *.o $(EXENAME)

