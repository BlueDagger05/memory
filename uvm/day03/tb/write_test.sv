`ifndef WR_TEST
`define WR_TEST
class write_test extends uvm_test;
  `uvm_component_utils(write_test)

  environment    env;
  write_sequence  seq;

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
	 super.build_phase(phase);

	 env = environment::type_id::create("env", this);

	`uvm_info(get_full_name(), "FROM WRITE TEST NEW", UVM_NONE)

  endfunction: build_phase

/////////////////////////////////////////
// RUN_PHASE
/////////////////////////////////////////
  task run_phase(uvm_phase phase);
	  super.run_phase(phase);
	  
	  seq = write_sequence::type_id::create("seq");
	  phase.raise_objection(this);

	  repeat(10)
	  begin
		 seq.start(env.agent_handler.sqr);
          end

	  #10;

	  `uvm_info(get_full_name(), "PHASE DROPPED", UVM_LOW)
	  phase.drop_objection(this);

  endtask: run_phase
  

endclass: write_test
`endif
