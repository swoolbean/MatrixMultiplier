module feedback_gate(din, clk, aclr, feedback, dout);
input [15:0] din;
input clk, aclr;

output [15:0] feedback, dout;

reg [15:0] dout;
reg [15:0] feedback;
reg [1:0] counter;

always @(negedge clk or posedge aclr)
begin
		
	if(aclr == 1'b1)
	begin
		feedback <= 16'b0000000000000000;
		dout <= 16'b0000000000000000;
		counter <= 2'b00;
	end
	

	else if(din === 16'bXXXXXXXXXXXXXXXX)
	begin
		feedback <= 16'b0000000000000000;
		dout <= 16'b0000000000000000;
		counter <= 2'b00;
	end
	
	// If the output is ready to be reset.
	else if(counter == 2'b10)
	begin
		feedback <= 16'b0000000000000000;
		dout <= din;
		counter <= 2'b00;
	end
	else if(din != 8'b00000000)
	begin
		feedback <= din;
		dout <= din;
		counter <= counter + 2'b01;
	end
	else
	begin
		feedback <= din;
		dout <= din;
		counter <= 2'b00;
	end
end

endmodule