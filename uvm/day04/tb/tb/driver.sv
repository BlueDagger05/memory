`ifndef DRIVER
`define DRIVER
class driver extends uvm_driver#(pkt);
  `uvm_component_utils(driver)

  // pkt class handle
  pkt packet_data;
  
  // applicable for IP level reset
  // reset virual interface
  // virtual reset_interface rst_vif;

  // virual interface
  virtual mem_ifc vif;

  uvm_analysis_port #(pkt) port;

  int numofPackets = 1;


  function new(string name ="driver", uvm_component parent = null);
	  super.new(name, parent);
  endfunction : new


/////////////////////////////////////////
// BUILD_PHASE
/////////////////////////////////////////
  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);

	  port = new("port", this);

	  // config db for memory interface
	  if(~uvm_config_db #(virtual mem_ifc)::get(this, "", "ANY_KEY", vif ))
		  `uvm_error(get_type_name(), "FAILED TO GET CONFIG_DB")
	  else
		  `uvm_info(get_type_name(), "SUCCESS WHILE FETCHING CONFIG_DB", UVM_LOW)

//***********************************************************************
//***********************************************************************
	  // applicable for IP-level reset
	  // config db for reset interface 
// 	  if(~uvm_config_db #(virtual reset_interface)::get(this, "", "RST_KEY", rst_vif))
// 		  `uvm_error(get_type_name(), "FAILED TO GET CONFIG_DB OF RESET INTERFACE....")
// 	  else
// 		  `uvm_info(get_type_name(), "SUCCESS WHILE FETCHING CONFIG_DB OF RESET INTERFACE...", UVM_LOW)
// 
//***********************************************************************
//***********************************************************************


	  // config db for receving numberofPackets 
	  if(~uvm_config_db #(int)::get(this, "", "PKT", numofPackets ))
		  `uvm_warning(get_type_name, "Default Transaction set to 1")
	  else
		  `uvm_info(get_type_name(), $sformatf("Total Pkt Count %0d", numofPackets), UVM_LOW)

  endfunction: build_phase


/////////////////////////////////////////
// CONNECT_PHASE
/////////////////////////////////////////
  function void connect_phase(uvm_phase phase);
	  super.connect_phase(phase);
  endfunction: connect_phase


/////////////////////////////////////////
// tasks and functions
/////////////////////////////////////////
extern task only_wr();
extern task only_rd();

/////////////////////////////////////////
// RUN_PHASE
/////////////////////////////////////////
  task run_phase(uvm_phase phase);
	  super.run_phase(phase);

	  // phase.raise_objection(this);
	  // packet_data = pkt::type_id::create("packet", this);


	  @(posedge vif.clk)
	  wait(vif.reset_n);
	  forever
	  begin   // {
	  	seq_item_port.get_next_item(packet_data);

		if(packet_data.wr_en)
		begin : write_proc
			repeat(numofPackets)
			begin
				@(posedge vif.clk)
				only_wr();
			end 

		end: write_proc

		else 
		begin : read_proc 
			repeat(numofPackets) 
			begin
				@(posedge vif.clk)
			        only_rd();
			end

		end : read_proc

      	        seq_item_port.item_done();

	       @(posedge vif.clk);
	  end // }

	  phase.drop_objection(this);

  endtask: run_phase


endclass : driver

task driver::only_wr();
	@(posedge vif.clk);
	begin
		vif.wr_en <= 1'b1;
		vif.op_en <= 1'b0;
		vif.cs	  <= 1'b1;
		vif.data_in <= packet_data.data_in;
		vif.addr_in <= packet_data.addr_in;
		port.write(packet_data);
		// packet_data.print();
	end

endtask

task driver:: only_rd();
// right now empty
	@(posedge vif.clk);
	begin
		vif.wr_en <= 1'b0;
		vif.op_en <= 1'b1;
		vif.cs	  <= 1'b1;
		vif.addr_in <= packet_data.addr_in;
		port.write(packet_data);
		// packet_data.print();
	end
endtask
`endif 
