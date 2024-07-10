`ifndef MONITOR
`define MONITOR

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

  pkt pkt_mon;

function new(string name= "monitor", uvm_component parent= null );
	super.new(name, parent);
endfunction : new

///////////////////////////////////////////////

virtual mem_ifc vif;

uvm_analysis_port #(pkt) port;

///////////////////////////////////////
// BUILD_PHASE
//////////////////////////////////////
 
 function void build_phase(uvm_phase phase);
	  super.build_phase(phase);

	  port     = new("port", this);

	  if(! uvm_config_db #(virtual mem_ifc):: get(this,"","ANY_KEY", vif)) 
		  `uvm_fatal(get_type_name(), "Dut interface not found")

	  else
		  `uvm_info(get_type_name(), "CONFIG DB DATA FOUND IN MONITOR", UVM_HIGH)

 endfunction: build_phase

 extern task only_wr;
 extern task only_rd;

 task run_phase(uvm_phase phase);
	 super.run_phase(phase);
	 forever
	 begin
		 @(posedge vif.clk);
		 pkt_mon = pkt::type_id::create("pkt");

		 fork
			 only_wr();
			 only_rd();
		 join_any
	 end


 endtask: run_phase

endclass: monitor

task monitor:: only_wr();
	@(posedge vif.clk);

	if(vif.reset_n)
	begin // {
		if(vif.wr_en && ~vif.op_en && vif.cs)
		begin // {
		     pkt_mon.addr_in  = vif.addr_in;
		     pkt_mon.data_in  = vif.data_in;
		     pkt_mon.data_out = vif.data_out;
		     pkt_mon.cs       = vif.cs;
		     pkt_mon.wr_en    = vif.wr_en;
		     pkt_mon.op_en    = vif.op_en;

		     port.write(pkt_mon);
		     // pkt_mon.print();
		end   // }
	end //}
	else
		`uvm_info(get_full_name(), "INSIDE RESET STATE IN ONLY_WR", UVM_HIGH)
endtask: only_wr


task monitor:: only_rd();
	@(posedge vif.clk);

	if(vif.reset_n)
	begin // {
		if(~vif.wr_en && vif.op_en && vif.cs)
		begin // {
		     pkt_mon.addr_in  = vif.addr_in;
		     pkt_mon.data_in  = vif.data_in;
		     pkt_mon.data_out = vif.data_out;
		     pkt_mon.cs       = vif.cs;
		     pkt_mon.wr_en    = vif.wr_en;
		     pkt_mon.op_en    = vif.op_en;

		     port.write(pkt_mon);

		     // pkt_mon.print();
		end   // }
	end //}
	else
		`uvm_info(get_full_name(), "INSIDE RESET STATE IN ONLY_RD", UVM_HIGH)
endtask : only_rd
`endif
