module bench();

reg  [7:0]  a;
reg  [7:0]  b;
reg         start;
wire [7:0]  result;

reg clk;
reg reset;

wire done;

gcd dut(
   .a(a),
   .b(b),
   .start(start),
   .result(result),
   .clk(clk),
   .reset(reset),
   .done(done)
);


task clk_tick;
begin
   clk = 1'b1;
   #10;
   clk = 1'b0;
   #10;
end
endtask

task run_gcd(
   input [7:0] a_,
   input [7:0] b_,
   input [7:0] expect
);
begin
   a = a_;
   b = b_;
 
   start = 1'b1;
   clk_tick;

   start = 1'b0;
   repeat (3) clk_tick;

   while (done != 1'b0) begin
      clk_tick;
      //$display("a=%d b=%d, result=%d", a, b, result);
      //$display("a=%d b=%d, result=%d", dut.a_, dut.b_, result);
   end

   if (result == expect) begin
      $display("Pass");
   end
   else begin
      $display("Fail");
   end
end
endtask


initial begin 
   $dumpfile("waves.vcd");
   $dumpvars(0, bench);

   a = 8'b0;
   b = 8'b0;
   start = 1'b0;
   clk = 1'b0;
   reset = 1'b0;
   #10;
   reset = 1'b1;

   $display("The end of the beginning.");

   run_gcd(8'd15, 8'd5, 'd5);
   run_gcd(8'd15, 8'd6, 'd3);
   run_gcd(8'd123, 8'd33, 'd3);
   run_gcd(8'd124, 8'd33, 'd1);
end


endmodule
