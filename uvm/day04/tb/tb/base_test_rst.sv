`ifndef BASE_TEST
`define BASE_TEST
class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  // environment class instance
  environment env;

  // base sequence class instance
  base_sequence_rst seq;


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

	 env = environment::type_id::create("rst_drv", this);
	`uvm_info(get_full_name(), "FROM TEST NEW", UVM_NONE)

  endfunction: build_phase






/////////////////////////////////////////
// RUN_PHASE 
/////////////////////////////////////////
  task run_phase(uvm_phase phase);
	  super.run_phase(phase);
	  
	  seq = base_sequence::type_id::create("seq");

	  // raising objection
	  phase.raise_objection(this);

	  seq.start(env.agent_handler.sqr);

	  #20;

	  // dropping objection
	  `uvm_info(get_full_name(), "PHASE DROPPED", UVM_LOW)

	  phase.drop_objection(this);

  endtask: run_phase
  

endclass: base_test
`endif
