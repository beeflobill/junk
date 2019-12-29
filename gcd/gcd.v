module gcd(
   input  [7:0] a,
   input  [7:0] b,
   input        start,
   output reg [7:0] result,
   input clk,
   input reset,
   output reg done
);

reg [7:0] a_;
reg [7:0] b_;

always @(posedge clk or negedge reset) begin
   if (~reset) begin
      a_ <= 8'b0;
      b_ <= 8'b0;
      result <= 1'b0;
      done <= 1'b0;
   end
   else begin
      if (start==1'b1) begin
         a_ <= a;
         b_ <= b;
         done <= 1'b1;
      end
      else if (a_== 8'b0) begin
         result <= b_;
         done <= 1'b0;
      end
      else if (b_ == 8'b0) begin
         result <= a_;
         done <= 1'b0;
      end
      else begin
         a_ <= b_;
         b_ <= a_ % b_;
      end
   end
end


endmodule
