module from_pos_half_cycle_buffer(din, clk, dout);
input [2:0] din;
input clk;

reg [2:0] dout;

output dout;

always@(negedge clk)
begin
	dout = din;
end
endmodule