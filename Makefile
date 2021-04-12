AS = ca65
LD = ld65
IPS = flips

%.o: source/%.s
	$(AS) -g --create-dep "$@.dep" --debug-info $< -o $@

main.sfc: layout entry.o
	$(LD) --dbgfile $@.dbg -C $^ -o $@

integritycheck: main.sfc
	radiff2 -x main.sfc "original.sfc" | head -n 100

include $(wildcard *.dep)
