`timescale 1ns / 1ps
module vending_machine(
input clk,rst,coin_5,coin_10,
input [2:0]sel,
output reg dispense,change_5);
localparam s0=3'b000,
           s5=3'b001,
           s10=3'b010,
           s15=3'b011,
           s20=3'b100,
           s25=3'b101;
reg [2:0]state,next_state;
always @(posedge clk or posedge rst)
begin
if(rst)
   state<=s0;
else
   state<=next_state;
end
reg [15:0]amount;
always @(*)
begin
case(sel)
    3'b000:amount=16'd10;
    3'b001:amount=16'd15;
    3'b010:amount=16'd20;
    default:amount=16'd0;
endcase
end 
always @(posedge clk or posedge rst)
begin
if(rst)
   begin
   dispense<=1'b0;
   change_5<=1'b0;
   end
else
begin
dispense<=1'b0;
change_5<=1'b0;
case(state)
     s0:begin
        if(coin_5)
           next_state<=s5;
        else if(coin_10)
           next_state<=s10;
        end
     s5:begin
        if(coin_5)
           next_state<=s10;
        else if(coin_10)
           next_state<=s15;
        end
    s10:begin
        if(amount==16'd10)
           begin
           dispense<=1'b1;
           next_state<=s0;
           end
        else if(amount==16'd15 || amount==16'd20)
                begin
                if(coin_5)
                   next_state<=s15;
                else if(coin_10)
                   next_state<=s20;
                end 
         end
     s15:begin
         if(amount==16'd10)
            begin
            dispense<=1'b1;
            change_5<=1'b1;
            next_state<=s0;
            end
         else if(amount==16'd15)
                 begin
                 dispense<=1'b1;
                 next_state<=s0;
                 end
         else if(amount==16'd20)
                 begin
                 if(coin_5)
                    next_state<=s20;
                 else if(coin_10)
                    next_state<=s25;
                 end 
          end 
      s20:begin
          if(amount==16'd20)
             begin
             dispense<=1'b1;
             next_state<=s0;
             end
         else if(amount==16'd15)
                 begin
                 dispense<=1'b1;
                 change_5<=1'b1;
                 next_state<=s0;
                 end 
          end
      s25:begin
          if(amount==16'd20)
             begin
             dispense<=1'b1;
             change_5<=1'b1;
             next_state<=s0;
             end
           end
       default:next_state=s0;
endcase
end
end
endmodule
