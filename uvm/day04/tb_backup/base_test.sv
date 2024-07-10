`ifndef BASE_TEST
`define BASE_TEST
class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  driver rst_drv;


/////////////////////////////////////////
// NEW
/////////////////////////////////////////
  function new(string name = "base_test", uvm_component parent = null);
	  super.new(name, parent);
	`uvm_info(get_full_name(), "FROM TEST IN NEW", UVM_NONE)
  endfunction: new
 


/////////////////////////////////////////
// BUILD_PHASE
/////////////////////////////////////////
  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);

	 rst_drv = driver::type_id::create("rst_drv", this);
	`uvm_info(get_full_name(), "FROM TEST NEW", UVM_NONE)

  endfunction: build_phase

/////////////////////////////////////////
// RUN_PHASE 
/////////////////////////////////////////
  task run_phase(uvm_phase phase);
	  super.run_phase(phase);
	  
	  `uvm_info(get_full_name(), "PHASE DROPPED", UVM_LOW)

  endtask: run_phase
  

endclass: base_test
`endif
