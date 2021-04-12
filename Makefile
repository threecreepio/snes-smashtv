AS = ca65
LD = ld65
IPS = flips

%.o: source/%.s
	$(AS) -g --create-dep "$@.dep" --debug-info $< -o $@

main.sfc: layout entry.o
	$(LD) --dbgfile $@.dbg -C $^ -o $@

include $(wildcard *.dep)
