module FIFO(
    input      [7:0]     BUFFER_IN, 
    input                WR_EN, 
    input                RD_EN, 
    input                CLK, 
    input                RST,

    output reg [7:0]     BUFFER_OUT, 
    output reg           EMPTY, 
    output reg           FULL, 
    output reg [3:0]     COUNT
);
   
   reg[2:0] RD_PTR, WR_PTR;           
   reg[7:0] MEMORY[7:0];   

   always @(COUNT) begin
      EMPTY = (COUNT == 0);
      FULL  = (COUNT == 8);
   end

   always @(posedge CLK or posedge RST)
   begin
      if( RST )
         COUNT <= 0;

      else if( (!FULL && WR_EN) && ( !EMPTY && RD_EN ) )
         COUNT <= COUNT;

      else if( !FULL && WR_EN )
         COUNT <= COUNT + 1;

      else if( !EMPTY && RD_EN )
         COUNT <= COUNT - 1;
      else
         COUNT <= COUNT;
   end

   always @( posedge CLK or posedge RST)
   begin
      if( RST )
         BUFFER_OUT <= 0;
      else
      begin
         if( RD_EN && !EMPTY )
            BUFFER_OUT <= MEMORY[RD_PTR];

         else
            BUFFER_OUT <= BUFFER_OUT;

      end
   end

   always @(posedge CLK)
   begin

      if( WR_EN && !FULL )
         MEMORY[WR_PTR] <= BUFFER_IN;

      else
         MEMORY[WR_PTR] <= MEMORY[WR_PTR];
   end

   always@(posedge CLK or posedge RST)
   begin
      if( RST )
      begin
         WR_PTR <= 0;
         RD_PTR <= 0;
      end
      else
      begin
         if( !FULL && WR_EN )    WR_PTR <= WR_PTR + 1;
            else  WR_PTR <= WR_PTR;

         if( !EMPTY && RD_EN )   RD_PTR <= RD_PTR + 1;
         else RD_PTR <= RD_PTR;
      end

   end
endmodule