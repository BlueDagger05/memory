module memory #(parameter DATA_WIDTH = 8,
                parameter ADDR_WIDTH  = 4)
  (
	  input wire                   clk,
       	  input wire                   reset_n,
       	  input wire [ADDR_WIDTH -1:0] addr_in,
	  input wire [DATA_WIDTH -1:0] data_in,
	  input wire                   wr_en,
	  input	wire                   op_en,
	  input wire                   cs,
	  output logic [DATA_WIDTH -1:0] data_out
	  );

	  // temporary memory register
	  reg [ADDR_WIDTH -1:0] mem [2*DATA_WIDTH-1:0];

  always_ff@(posedge clk or negedge reset_n)	  
	  begin : write_proc
		  if(~reset_n)
			  mem[addr_in] <= 8'b0000_0000;
		  else if(wr_en && cs && ~op_en)
			  mem[addr_in] <= data_in;
	  end : write_proc

  always_ff@(posedge clk or negedge reset_n)
         begin: read_proc
		 if(~reset_n)
			 data_out <= 8'b0000_0000;
		 else if(~wr_en && cs && op_en)
			 data_out <= mem[addr_in];
         end: read_proc

endmodule:memory


