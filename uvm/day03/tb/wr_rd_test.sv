`ifndef WR_RD_TEST
`define ABC
`define WR_RD_TEST

class write_read_test extends uvm_test;
  `uvm_component_utils(write_read_test)

  environment    env;
  wr_rd_sequence wr_rd_seq;

/////////////////////////////////////////
// NEW
/////////////////////////////////////////
  function new(string name = "write_read_test", uvm_component parent = null);
	  super.new(name, parent);
	`uvm_info(get_full_name(), "FROM WRITE READ TEST...", UVM_NONE)
  endfunction: new
 



/////////////////////////////////////////
// BUILD_PHASE
/////////////////////////////////////////
  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);

	  env = environment::type_id::create("env", this);
	`uvm_info(get_full_name(), "FROM TEST NEW", UVM_NONE)

  endfunction: build_phase




/////////////////////////////////////////
// RUN_PHASE
/////////////////////////////////////////
  task run_phase(uvm_phase phase);
	  super.run_phase(phase);
	  
	  wr_rd_seq = wr_rd_sequence::type_id::create("wr_rd_seq");
	  phase.raise_objection(this);

	  repeat(10)
	  begin
		  wr_rd_seq.start(env.agent_handler.sqr);
          end

	  #10;

	  `uvm_info(get_full_name(), "PHASE DROPPED", UVM_LOW)
	  phase.drop_objection(this);

  endtask: run_phase
  

endclass: write_read_test

`endif
