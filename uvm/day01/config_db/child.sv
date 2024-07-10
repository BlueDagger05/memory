`ifndef CHILD
`define CHILD
class child extends uvm_component;
`uvm_component_utils(child)
//////////////////////////////////
// CTOR
//////////////////////////////////
  int data = 0;

    function new(string name = "child", uvm_component parent);
        super.new(name, parent);
    endfunction : new

//////////////////////////////////
// BUILD_PHASE
//////////////////////////////////
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
	if(!uvm_config_db #(int)::get(this, "", "ANY_KEY", data))
		`uvm_info(get_name(),$sformatf("DATA not found in config db setting default value to 0x%0h", data), UVM_LOW)
	else
		`uvm_info(get_name(),$sformatf("DATA found in config db setting default value to 0x%0h", data), UVM_LOW)
    endfunction : build_phase

	
  function void end_of_elaboration_phase(uvm_phase phase);
	  super.end_of_elaboration_phase(phase);
	  `uvm_error("FROM CHILD", "this is a error statemant");
  endfunction: end_of_elaboration_phase

endclass: child	
`endif
