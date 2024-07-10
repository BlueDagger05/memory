`ifndef DRIVER
`define DRIVER
class driver extends uvm_driver#(reset_pkt);
  `uvm_component_utils(driver)

  // reset_pkt class handle
  reset_pkt rst_pkt;
  
  // virual interface
  virtual reset_interface vif;

  // uvm analysis port
  uvm_analysis_port #(reset_pkt) port;
  
  // variable to assert reset after rstRepeat time
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

	  // building analysis port -> port
	  port = new("port", this);



	  // config db for fetching virtual interface
	  if(~uvm_config_db #(virtual reset_interface)::get(this, "", "ANY_KEY", vif ))
		  `uvm_error(get_type_name(), "FAILED TO GET CONFIG_DB")
	  else
		  `uvm_info(get_type_name(), "SUCCESS WHILE FETCHING CONFIG_DB", UVM_LOW)


          // config db for fetching number of rstRepeat
	  if(~uvm_config_db #(int)::get(this, "", "PKT", rstRepeat))
		  `uvm_warning(get_type_name, "Default Transaction set to 1")
	  else
		  `uvm_info(get_type_name(), $sformatf("Total Reset Repeat Count %0d", rstRepeat), UVM_LOW)

  endfunction: build_phase





/////////////////////////////////////////
// CONNECT_PHASE
/////////////////////////////////////////
   function void connect_phase(uvm_phase phase);
	   super.connect_phase(phase);
   endfunction: connect_phase




/////////////////////////////////////////
// RESET_PHASE
/////////////////////////////////////////
  task run_phase(uvm_phase phase);
	  super.run_phase(phase);
	  // $display("inside run_phase....");

	  // getting pkt from sequence item	
	  seq_item_port.get_next_item(rst_pkt);

	  // $display("2 inside run_phase....");
	  // repeating for rstRepeat times
	  repeat(rstRepeat)
	  begin
		  // $display("1 clk %0d", vif.clk);
		  @(posedge vif.clk)
		  // $display("2 clk %0d", vif.clk);
	  // $display("3 inside run_phase....");
	  end
	  	  // driving reset_n
		  vif.reset_n <= rst_pkt.reset_n;

		  $display("[DRV] :: value of reset_n %0d", rst_pkt.reset_n);

          seq_item_port.item_done(); 
	

  endtask: run_phase


/////////////////////////////////////////
// REPORT_PHASE
/////////////////////////////////////////
   function void report_phase(uvm_phase phase);
	   super.report_phase(phase);
	   `uvm_info(get_full_name(), $sformatf("RST Driven after %0d cycles.....", rstRepeat), UVM_HIGH)

   endfunction : report_phase
endclass : driver

`endif 
