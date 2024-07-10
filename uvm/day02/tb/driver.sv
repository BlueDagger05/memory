`ifndef DRIVER
`define DRIVER
class driver extends uvm_driver#(pkt);
  `uvm_component_utils(driver)

  // pkt class handle
  pkt packet_data;
  
  // virual interface
  virtual mem_ifc vif;

  function new(string name ="driver", uvm_component parent = null);
	  super.new(name, parent);
  endfunction : new


/////////////////////////////////////////
// BUILD_PHASE
/////////////////////////////////////////
  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);

	  if(~uvm_config_db #(virtual mem_ifc)::get(this, "", "ANY_KEY", vif ))
		  `uvm_error(get_type_name(), "FAILED TO GET CONFIG_DB")
	  else
		  `uvm_info(get_type_name(), "SUCCESS WHILE FETCHING CONFIG_DB", UVM_LOW)

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
		  // if randomization success
		  // drive the data
		  // assert(packet_data.randomize());
		  // if( packet_data.randomize() )
		  begin: driving_proc  // {
		  repeat(10) only_wr();

		  @(posedge vif.clk)
		  repeat(10) only_rd();
//			  // write transaction
//			  if(packet_data.wr_en && packet.cs && ~packet.op_en)
//			  begin: write_proc
//
//			      vif.data_in <= packet_data.data_in;
//			      vif.addr_in <= packet_data.addr_in;
//			      vif.wr_en   <= packet_data.wr_en;
//			      vif.cs      <= packet_data.cs;
//			      vif.op_en   <= packet_data.op_en;
//		  	      packet_data.print();
//
//			  end: write_proc
//
//			  // read transaction
//			  else if(~packet_data.wr_en && packet.cs && packet.op_en)
//			  begin: read_proc
//
//			      vif.addr_in <= packet_data.addr_in;
//			      vif.wr_en   <= packet_data.wr_en;
//			      vif.cs      <= packet_data.cs;
//			      vif.op_en   <= packet_data.op_en;
//		  	      packet_data.print();
//
//			  end: read_proc
//
		  seq_item_port.item_done();
		  end: driving_proc // }

		 // else 
		 // begin
		 //         `uvm_error(get_type_name(), "FAILED TO RANDOMIZE")
		 // end


		  // printing the packet_data via UVM print function
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
		// packet_data.print();
	end
endtask
`endif 
