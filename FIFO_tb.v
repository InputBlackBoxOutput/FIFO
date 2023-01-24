`timescale 1ns/10ps
`include "FIFO.v"

module FIFO_tb;
    reg  [7:0]     BUFFER_IN; 
    reg            WR_EN; 
    reg            RD_EN; 
    reg            CLK = 1; 
    reg            RST = 0;

    wire [7:0]     BUFFER_OUT; 
    wire           EMPTY; 
    wire           FULL;
    wire [3:0]     COUNT;

    FIFO fifo(
        BUFFER_IN, 
        WR_EN, 
        RD_EN, 
        CLK, 
        RST,

        BUFFER_OUT, 
        EMPTY, 
        FULL, 
        COUNT
    );

    // Setup simulation dump file
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, fifo);
    end

    // Setup clock
    always #1 CLK = ~CLK;

    initial begin
        RST = 1; #1 RST = 0;

        
        #1 WR_EN = 1;
        BUFFER_IN = 8'hF0;
        #1 WR_EN = 0;

        #1 WR_EN = 1;
        BUFFER_IN = 8'hF1;
        #1 WR_EN = 0;

        #1 WR_EN = 1;
        BUFFER_IN = 8'hF2;
        #1 WR_EN = 0;

        #1 WR_EN = 1;
        BUFFER_IN = 8'hF3;
        #1 WR_EN = 0;

        #1 WR_EN = 1;
        BUFFER_IN = 8'hF4;
        #1 WR_EN = 0;


        #1 WR_EN = 1;
        BUFFER_IN = 8'hF5;
        #1 WR_EN = 0;

        #1 WR_EN = 1;
        BUFFER_IN = 8'hF6;
        #1 WR_EN = 0;

        #1 WR_EN = 1;
        BUFFER_IN = 8'hF7;
        #1 WR_EN = 0;

        #1 RD_EN = 1;
        #1 RD_EN = 0;

        #1 RD_EN = 1;
        #1 RD_EN = 0;

        #2 $finish();
    end
endmodule