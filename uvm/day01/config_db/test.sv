`ifndef TEST
`define TEST
class test extends uvm_test;
  `uvm_component_utils(test)

  child ch;
  int data = 0;

  function new(string name = "test", uvm_component parent);
	  super.new(name, parent);
  endfunction: new
 
  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	  ch = child::type_id::create("ch", this);

	if(!uvm_config_db #(int)::get(this, "", "ANY_KEY", data))
		`uvm_info(get_name(),$sformatf("DATA not found in config db setting default value to 0x%0h", data), UVM_LOW)
	else
		`uvm_info(get_name(),$sformatf("DATA found in config db setting default value to 0x%0h", data), UVM_LOW)

	 ch.set_report_severity_override(UVM_ERROR, UVM_WARNING);
  endfunction: build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
	  super.end_of_elaboration_phase(phase);
	//  `uvm_error("FROM TEST", "this is a error statemant");
  endfunction: end_of_elaboration_phase

  function void final_phase(uvm_phase phase);
	  super.final_phase(phase);
  endfunction

endclass: test

`endif
