module rr_arbiter(
input clk,rst, input [1:0]req, output reg [1:0] grant
);
   reg [0:0] last;
   reg [1:0] cp;
  integer i,j;
   
   parameter nreq = 2;
   always@(posedge clk or posedge rst)begin
   if(rst)begin
   last <= 0;
   end
   else if(|req)begin
//   integer i;
   for (i=0;i<nreq;i=i+1)begin
   if (grant[i])begin
   last <= i;
   end
   end
   end
   end
   
   always@(*)begin
   grant = 0;
//   integer j;
   for (j=0;j<nreq;j=j+1)begin
   cp = (last+1+j)%nreq;
   if(req[cp])begin
   grant[cp] = 1;
   end
   end
   end
endmodule
