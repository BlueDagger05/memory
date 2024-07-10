`ifndef WR_TEST
`define WR_TEST
class write_test extends base_test;
  `uvm_component_utils(write_test)

/////////////////////////////////////////
// NEW
/////////////////////////////////////////

  function new(string name = "write_test", uvm_component parent = null);
	  super.new(name, parent);
	`uvm_info(get_full_name(), "FROM WRITE TEST IN NEW", UVM_NONE)
  endfunction: new
 
/////////////////////////////////////////
// BUILD_PHASE
/////////////////////////////////////////

  function void build_phase(uvm_phase phase);

	 set_type_override_by_type(base_sequence::get_type(), write_sequence::get_type());
	 super.build_phase(phase);

	`uvm_info(get_full_name(), "FROM WRITE TEST NEW", UVM_NONE)

  endfunction: build_phase


endclass: write_test
`endif
