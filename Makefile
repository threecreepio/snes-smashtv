%.o: source/%.s
	(cd source && ../bin/wla-65816 -o $@ ../$<)
	(cd source && ../bin/wla-65816 -M ../$< > $@.dep)

main.sfc: wla.link entry.o
	./bin/wlalink wla.link $@

integritycheck: main.sfc
	radiff2 -x main.sfc "original.sfc" | head -n 100

include $(wildcard *.dep source/*.dep)
