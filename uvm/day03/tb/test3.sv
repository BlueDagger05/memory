`ifndef test3
`define test3
class test3 extends uvm_test;
  `uvm_component_utils(test3)

  environment    env;
  base_sequence  seq;

  function new(string name = "test3", uvm_component parent = null);
	  super.new(name, parent);
	`uvm_info(get_full_name(), "FROM test3 IN NEW", UVM_NONE)
  endfunction: new
 
/////////////////////////////////////////
// BUILD_PHASE
/////////////////////////////////////////
  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);

	  env = environment::type_id::create("env", this);
	`uvm_info(get_full_name(), "FROM TEST NEW", UVM_NONE)

  endfunction: build_phase

  task run_phase(uvm_phase phase);
	  super.run_phase(phase);
	  
	  seq = base_sequence::type_id::create("seq");
	  phase.raise_objection(this);

	  repeat(10)
	  begin
		  seq.start(env.agent_handler.sqr);
          end

	  #10;

	  `uvm_info(get_full_name(), "PHASE DROPPED", UVM_LOW)
	  phase.drop_objection(this);

  endtask: run_phase
  

endclass: test3
`endif
