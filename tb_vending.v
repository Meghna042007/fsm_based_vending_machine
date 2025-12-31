`timescale 1ns / 1ps
module tb_vending( );
reg clk,rst,coin_5,coin_10;
reg [2:0]sel;
wire dispense,change_5;
vending_machine dut(.clk(clk),.rst(rst),.coin_5(coin_5),.coin_10(coin_10),.sel(sel),.dispense(dispense),.change_5(change_5));
always #5 clk=~clk;
initial 
begin
$monitor($time," sel=%d coin_5=%b coin_10=%b dispense=%b change_5=%b",sel,coin_5,coin_10,dispense,change_5);
clk=0;rst=1;coin_5=0;coin_10=0;sel=3'b000;
#12 rst=0;
#10;
//amount=10,pay=10
sel=3'b000;#20;
coin_10=1;#10;
coin_10=0;
#40;
//amount=15,pay=15
sel=3'b001;#10;
coin_10=1;#10;
coin_10=0;#10;
coin_5=1;#10;
coin_5=0;
#40;
//amount=10,pay=15(change expected)
sel=3'b000;#10;
coin_5=1;#10;
coin_5=0;#10;
coin_10=1;#10;
coin_10=0;
#40;
//amount=20,pay=25(change expected)
sel=3'b010;#10;
coin_10=1;#10;
coin_10=0;#10;
coin_5=1;#10;
coin_5=0;#10;
coin_10=1;#10
coin_10=0;
#50
$finish;
end
endmodule
