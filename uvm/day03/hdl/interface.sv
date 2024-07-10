`define ADDR_WIDTH 4
`define DATA_WIDTH 8
interface mem_ifc (input bit clk, reset_n);

  logic [`ADDR_WIDTH -1:0] addr_in;
  logic [`DATA_WIDTH -1:0] data_in;
  logic                    wr_en;
  logic                    op_en;
  logic                    cs;
  logic [`DATA_WIDTH -1:0] data_out;

 modport DUT (output data_out, input clk, reset_n, addr_in, data_in, wr_en, op_en, cs);
 
endinterface: mem_ifc
