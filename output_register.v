module output_register(din1, din2, input_sel1, input_sel2, mac_sel, reg_out_sel, output_rdy, clk, aclr, dout, b13);
input [15:0] din1, din2;	// Inputs from MACs
input [2:0] input_sel1, input_sel2;	// Lines for selecting registers for din1 and din2
input [1:0] mac_sel;	// 2-bit line indicating which MAC(s) to get input from
input clk, aclr;	// Clock and asynchronous clear
input output_rdy;	// High if an output is ready
input [3:0] reg_out_sel;	// Line for selecting register for dout.

output [15:0] dout;	// Output
output [15:0] b13;

// Registers for outputs from MACs
reg [15:0] b11, b12, b13, b14, b21, b22, b23, b24, b31, b32, b33, b34, b41, b42, b43, b44;

// Some registers are used to hold two outputs since they will always be identical.
// List of twin outputs:
// b12 = b21
// b13 = b31
// b14 = b41
// b23 = b32
// b34 = b43

// Register for output
reg [15:0] dout;

always @(posedge clk or posedge aclr)
begin

	// Reset
	if(aclr == 1'b1)
	begin
		b11 <= 8'b00000000;
		b12 <= 8'b00000000;
		b13 <= 8'b00000000;
		b14 <= 8'b00000000;
		b21 <= 8'b00000000;
		b22 <= 8'b00000000;
		b23 <= 8'b00000000;
		b24 <= 8'b00000000;
		b31 <= 8'b00000000;
		b32 <= 8'b00000000;
		b33 <= 8'b00000000;
		b34 <= 8'b00000000;
		b41 <= 8'b00000000;
		b42 <= 8'b00000000;
		b43 <= 8'b00000000;
		b44 <= 8'b00000000;
		dout <= 8'b00000000;
	end
	else
	begin
	
		// If an output from MAC1 is ready, load it.
		case(input_sel1)
			3'b000: 
				begin
					b12 <= din1;
					b21 <= din1;
				end
			3'b001:
				begin
					b13 <= din1;
					b31 <= din1;
				end
			3'b010:
				begin
					b14 <= din1;
					b41 <= din1;
				end
			3'b011:
				begin
					b23 <= din1;
					b32 <= din1;
				end
			3'b100:
				begin
					b34 <= din1;
					b43 <= din1;
				end
		endcase
		
		// If an output from MAC2 is ready, load it.
		case(input_sel2)
			3'b000: 
				begin
					b11 <= din2;
				end
			3'b001:
				begin
					b22 <= din2;
				end
			3'b010:
				begin
					b33 <= din2;
				end
			3'b011:
				begin
					b44 <= din2;
				end
			3'b100:
				begin
					b24 <= din2;
					b42 <= din2;
				end
		endcase
		
		// If an output is ready, select an output.
		if(output_rdy == 1'b1)
		begin
		
			// Select an output
			case(reg_out_sel)
				4'b0000:dout <= b11;
				4'b0001:dout <= b12;
				4'b0010:dout <= b13;
				4'b0011:dout <= b14;
				4'b0100:dout <= b21;
				4'b0101:dout <= b22;
				4'b0110:dout <= b23;
				4'b0111:dout <= b24;
				4'b1000:dout <= b31;
				4'b1001:dout <= b32;
				4'b1010:dout <= b33;
				4'b1011:dout <= b34;
				4'b1100:dout <= b41;
				4'b1101:dout <= b42;
				4'b1110:dout <= b43;
				4'b1111:dout <= b44;
			endcase
		end
		else if(output_rdy == 1'b0)
			dout <= 4'b0000;
			
	end
	
	
end

endmodule