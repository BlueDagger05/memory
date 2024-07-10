`ifndef BASE_TEST
`define BASE_TEST
class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  environment    env;
  base_sequence  seq;

  function new(string name = "base_test", uvm_component parent = null);
	  super.new(name, parent);
	`uvm_info(get_full_name(), "FROM TEST IN NEW", UVM_NONE)
  endfunction: new
 
  int scb_en = 1;
/////////////////////////////////////////
// BUILD_PHASE
/////////////////////////////////////////
  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);

	  env = environment::type_id::create("env", this);
	`uvm_info(get_full_name(), "FROM TEST NEW", UVM_NONE)

	uvm_config_db #(int) ::set(null,"*", "SCB_ENABLE", scb_en);

  endfunction: build_phase

/////////////////////////////////////////
// RUN_PHASE
/////////////////////////////////////////
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
  

endclass: base_test
`endif
