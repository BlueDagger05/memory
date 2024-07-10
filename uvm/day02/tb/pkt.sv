`define ADDR_WIDTH 4
`define DATA_WIDTH 8

class pkt extends uvm_sequence_item;
 
////////////////////////////////
// data fields
////////////////////////////////

  randc bit [`ADDR_WIDTH -1:0] addr_in;
  randc bit [`DATA_WIDTH -1:0] data_in;
  randc bit                    wr_en;
  randc bit                    op_en;
  randc bit                    cs;
        bit [`DATA_WIDTH -1:0] data_out;

////////////////////////////////
// CTOR and registering 
// it to the factory
////////////////////////////////

 `uvm_object_utils_begin(pkt)
 `uvm_field_int(addr_in, | UVM_ALL_ON | UVM_DEFAULT)
 `uvm_field_int(data_in, | UVM_ALL_ON | UVM_DEFAULT)
 `uvm_field_int(wr_en,   | UVM_ALL_ON | UVM_DEFAULT)
 `uvm_field_int(op_en,   | UVM_ALL_ON | UVM_DEFAULT)
 `uvm_field_int(cs,      | UVM_ALL_ON | UVM_DEFAULT)
 `uvm_object_utils_end

  function new (string name = "pkt");
	  super.new(name);
  endfunction : new

endclass: pkt
