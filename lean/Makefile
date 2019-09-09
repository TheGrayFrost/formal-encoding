LEANC=leanc
LEAN=lean

COMMON_SRCS = background/default.lean background/util.lean background/number.lean background/set.lean background/vec.lean background/witness.lean problems/default.lean problems/algebra/imo_2018_sl.lean
SRCS = $(COMMON_SRCS) main.lean
OLEANS = $(SRCS:.lean=.olean)
CPPS = $(SRCS:.lean=.cpp)
COMMON_OBJS = $(COMMON_SRCS:.lean=.o)
DEPS = $(SRCS:.lean=.depend)
CPPFLAGS = -O3

.PHONY: all clean

all: main $(OLEANS)

depends: $(DEPS)

%.depend: %.lean
	@echo $(<:.lean=.olean): `$(LEAN) --deps $< | python relative.py` > $@

%.olean: %.lean %.depend
	$(LEAN) --make --cpp="$*.cpp.tmp" $<
	mv "$*.cpp.tmp" "$*.cpp"
	@touch $*.olean

%.cpp: %.olean
	@

%.o: %.cpp
	$(LEANC) -c $(CPPFLAGS) -o $@ $<

main: main.o $(COMMON_OBJS)
	$(LEANC) -o $@ $^

clean:
	rm -f *~ *#
	rm -f *.olean
	rm -f *.cpp
	rm -f *.o
	rm -f *.depend
	rm -f main

.PRECIOUS: %.depend %.cpp

include $(DEPS)
