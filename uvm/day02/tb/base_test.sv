`ifndef BASE_TEST
`define BASE_TEST
class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  environment   env;
  base_sequence seq;


  function new(string name = "base_test", uvm_component parent = null);
	  super.new(name, parent);
	`uvm_info(get_full_name(), "FROM TEST IN NEW", UVM_NONE)
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
		  seq.start(env.agt.sqr);
          end

	  #10;

	  `uvm_info(get_full_name(), "PHASE DROPPED", UVM_LOW)
	  phase.drop_objection(this);
  endtask: run_phase
  
 // function void connect_phase(uvm_phase phase);
 //         cr.port1.connect(pd.port1);
 // endfunction : connect_phase

  
 // function void final_phase(uvm_phase phase);
 //         super.final_phase(phase);
 //         `uvm_info(get_full_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
 //         `uvm_info(get_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
 //         `uvm_info(get_type_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
 // endfunction

endclass: base_test
`endif
