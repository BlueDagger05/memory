`ifndef ENV
`define ENV
class environment extends uvm_env;
   `uvm_component_utils(environment)

   // class instances
   agent      		     agent_handler;
   inclusion_pkg::agent_rst  agent_rst_handler;

   scoreboard scoreboard_handler;
   coverage   coverage_handler;

   int scb_enable = 0;

   function new(string name = "environment", uvm_component parent = null);
	   super.new(name, parent);
   endfunction: new

///////////////////////////////////////
// BUILD_PHASE
//////////////////////////////////////
   function void build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   

	   if(~uvm_config_db #(int) ::get(this, "", "SCB_ENABLE", scb_enable))
		   `uvm_error(get_full_name(), "FAILED TO GET SCB ENABLE IN ENV")
	   else
		   `uvm_info(get_type_name(), $sformatf("SUCCESSFULLY RECEIVED SCB ENABLE = %0d", scb_enable), UVM_HIGH)


	   // creating class object using create method
	   agent_handler      = agent        ::type_id   ::create("agent_handler", this);
	   agent_rst_handler  = inclusion_pkg::agent_rst ::type_id::create("agent_rst_handler", this);

	   if(scb_enable)
		   scoreboard_handler = scoreboard::type_id::create("scoreboard_handler", this);
	   else
		   `uvm_info(get_full_name(), "SCB DEVELOPMENT DISABLED...", UVM_NONE)
		   
	   // $display("BUILD PHS Inside environment");
	   coverage_handler   = coverage::type_id::create("coverage_handler", this);

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
