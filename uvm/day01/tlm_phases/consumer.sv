`ifndef CONSUMER
`define CONSUMER
class consumer extends  uvm_component;
   `uvm_component_utils(consumer)

   uvm_blocking_get_port #(packet) port1;

   packet pkt_handler;

   function new(string name = "consumer", uvm_component parent);
     super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   port1 = new("port1", this);
   endfunction: build_phase

   task run_phase(uvm_phase phase);
	   super.run_phase(phase);
	   phase.raise_objection(this);
	   pkt_handler = packet::type_id::create("pkt_handler");
	     repeat(10)
	     begin
		     port1.get(pkt_handler);
	     end
           phase.drop_objection(this);
   endtask: run_phase

  function void final_phase(uvm_phase phase);
	  super.final_phase(phase);
	  `uvm_info(get_full_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
	  `uvm_info(get_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
	  `uvm_info(get_type_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
  endfunction

   endclass: consumer
`endif
