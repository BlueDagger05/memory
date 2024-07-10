`ifndef MONITOR
`define MONITOR
class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  // reset_pkt object instance
  reset_pkt rst_pkt;

  // virtual reset interface
  virtual reset_interface vif;

  // analysis port
  uvm_analysis_port #(reset_pkt) port;


///////////////////////////////////////
// NEW
//////////////////////////////////////
function new(string name= "monitor", uvm_component parent= null );
	super.new(name, parent);
endfunction : new




///////////////////////////////////////
// BUILD_PHASE
//////////////////////////////////////
 function void build_phase(uvm_phase phase);
	  super.build_phase(phase);


	  // building analysis port
	  port     = new("port", this);


	  // config db for reset interface
	  if(! uvm_config_db #(virtual reset_interface):: get(this,"","ANY_KEY", vif)) 
		  `uvm_fatal(get_type_name(), "RESET interface not found........")

	  else
		  `uvm_info(get_type_name(), "RESET interface found in monitor.....", UVM_HIGH)
 endfunction: build_phase


///////////////////////////////////////
// RUN_PHASE
//////////////////////////////////////
 task run_phase(uvm_phase phase);
	 super.run_phase(phase);
	 `uvm_info(get_type_name(), "Running monitor.....", UVM_HIGH)

 endtask: run_phase


endclass: monitor

`endif
