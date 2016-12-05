module reg_dff (D, Q, clk, aclr, load);
input [7:0] D, Q;
input clk, aclr;

reg [7:0] Q;

always @(posedge clk or aclr)
begin
	if(aclr == 1'b1)
		Q 
end

endmodule