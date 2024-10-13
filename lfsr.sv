module lfsr (input logic clk, output logic [3:0] lfsr);
	wire feedback = lfsr[0] ^ lfsr[3];
	reg [3:0] val = 4'b0001;
	assign lfsr = val;

	always_ff @(posedge clk) begin
		val <= {feedback, val[3:1]};
	end
endmodule