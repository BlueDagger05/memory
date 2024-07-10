`ifndef ENV
`define ENV
class environment extends uvm_env;
   `uvm_component_utils(environment)

   // class instances
   agent      agent_handler;
   scoreboard scoreboard_handler;
   coverage   coverage_handler;


   function new(string name = "environment", uvm_component parent = null);
	   super.new(name, parent);
   endfunction: new

///////////////////////////////////////
// BUILD_PHASE
//////////////////////////////////////
   function void build_phase(uvm_phase phase);
	   super.build_phase(phase);

	   // creating class object using create method
	   agent_handler      = agent     ::type_id::create("agent_handler", this);
	   scoreboard_handler = scoreboard::type_id::create("scoreboard_handler", this);
	   // $display("BUILD PHS Inside environment");
	   coverage_handler   = coverage  ::type_id::create("coverage_handler", this);

   endfunction: build_phase




///////////////////////////////////////
// CONNECT_PHASE
//////////////////////////////////////
   function void connect_phase(uvm_phase phase);
	   super.connect_phase(phase);

	   // connecting monitor_collect_port to scb item_collected_export_mon
	   agent_handler.mon.port.connect(
           scoreboard_handler.item_collected_export_mon);

	   // connecting monitor_collect_port to coverage cov_export
 	   // $display("PHS Inside environment");
	   agent_handler.mon.port.connect(
	   coverage_handler.cov_export);
   endfunction: connect_phase

endclass: environment
`endif
