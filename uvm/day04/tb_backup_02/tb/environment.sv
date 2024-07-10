`ifndef ENV
`define ENV
class environment extends uvm_env;
   `uvm_component_utils(environment)

   // class instances
   agent      agent_handler;

///////////////////////////////////////
// NEW
//////////////////////////////////////
   function new(string name = "environment", uvm_component parent = null);
	   super.new(name, parent);
   endfunction: new




///////////////////////////////////////
// BUILD_PHASE
//////////////////////////////////////
   function void build_phase(uvm_phase phase);
	   super.build_phase(phase);

	   // creating class object using create method
	   agent_handler = agent::type_id::create("agent_handler", this);
	   `uvm_info(get_full_name(), "Inside environment build_phase......", UVM_HIGH)

   endfunction: build_phase


endclass: environment
`endif
