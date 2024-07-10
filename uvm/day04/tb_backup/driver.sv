`ifndef DRIVER
`define DRIVER
class driver extends uvm_driver#(reset_pkt);
  `uvm_component_utils(driver)

  // reset_pkt class handle
  reset_pkt rst_pkt;
  
  // virual interface
  virtual reset_interface vif;


  int rstRepeat= 1;

/////////////////////////////////////////
// NEW
/////////////////////////////////////////
  function new(string name ="driver", uvm_component parent = null);
	  super.new(name, parent);
  endfunction : new


/////////////////////////////////////////
// BUILD_PHASE
/////////////////////////////////////////
  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);

	  if(~uvm_config_db #(virtual reset_interface)::get(this, "", "ANY_KEY", vif ))
		  `uvm_error(get_type_name(), "FAILED TO GET CONFIG_DB")
	  else
		  `uvm_info(get_type_name(), "SUCCESS WHILE FETCHING CONFIG_DB", UVM_LOW)


	  if(~uvm_config_db #(int)::get(this, "", "PKT", rstRepeat))
		  `uvm_warning(get_type_name, "Default Transaction set to 1")
	  else
		  `uvm_info(get_type_name(), $sformatf("Total Reset Repeat Count %0d", rstRepeat), UVM_LOW)

  endfunction: build_phase


/////////////////////////////////////////
// RUN_PHASE
/////////////////////////////////////////
  task run_phase(uvm_phase phase);
	  super.run_phase(phase);

	  phase.raise_objection(this);
	  repeat(rstRepeat)
	  begin
		  @(posedge vif.clk);
	  end
		  vif.reset_n <= 1'b1;

		  $display("[DRV] :: value of reset_n %0d", vif.reset_n);

		  `uvm_info(get_full_name(), "PHASE DROPPED", UVM_LOW)
	  phase.drop_objection(this);

  endtask: run_phase


endclass : driver

`endif 
