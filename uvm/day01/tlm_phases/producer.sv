`ifndef PRODUCER
`define PRODUCER
class producer extends  uvm_component;
   `uvm_component_utils(producer)

   uvm_blocking_get_imp #(packet, producer) port1; //handler of tlm imp port

   packet pkt_handler;

   function new(string name = "producer", uvm_component parent);
     super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   port1 = new("port1", this);
   endfunction: build_phase

   task get(output packet pkt_handler);
	   pkt_handler = packet::type_id::create("pkt");
	   assert(pkt_handler.randomize());
	   pkt_handler.print();
   endtask: get

//   task run_phase(uvm_phase phase);
//	   super.run_phase(phase);
//	   phase.raise_object(this);
//	     repeat(10)
//	     begin
//		     port1.get(pkt);
//	     end
//           phase.drop_objection(this);
//   endtask: run_phase

  function void final_phase(uvm_phase phase);
	  super.final_phase(phase);
	  `uvm_info(get_full_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
	  `uvm_info(get_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
	  `uvm_info(get_type_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
  endfunction

   endclass: producer

`endif   
