.PHONY: sim all

all: sim

sim: clean
	iverilog -o  FIFO_tb.vvp  FIFO_tb.v
	/usr/bin/vvp  FIFO_tb.vvp
	gtkwave dump.vcd


clean:
	rm -rf *.vvp dump.vcd