`ifndef WR_RD_TEST
`define WR_RD_TEST

class write_read_test extends base_test;
  `uvm_component_utils(write_read_test)

  wr_rd_sequence wr_rd_seq;

/////////////////////////////////////////
// NEW
/////////////////////////////////////////
  function new(string name = "write_read_test", uvm_component parent = null);
	  super.new(name, parent);
	`uvm_info(get_full_name(), "FROM TEST IN NEW", UVM_NONE)
  endfunction: new
 



/////////////////////////////////////////
// BUILD_PHASE
/////////////////////////////////////////
  function void build_phase(uvm_phase phase);

	  set_type_override_by_type(base_sequence::get_type(), wr_rd_sequence::get_type());
	  super.build_phase(phase);

	`uvm_info(get_full_name(), "FROM WR_RD TEST NEW", UVM_NONE)

  endfunction: build_phase




/////////////////////////////////////////
// RUN_PHASE
/////////////////////////////////////////

endclass: write_read_test

`endif
