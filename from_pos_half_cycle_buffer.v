module from_pos_half_cycle_buffer(din, clk, dout);
input [2:0] din;
input clk;
output [2:0] dout;

reg [2:0] dout;



always@(negedge clk)
begin
	dout = din;
end
endmodule