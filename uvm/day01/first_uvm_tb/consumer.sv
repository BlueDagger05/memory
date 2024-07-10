class consumer extends  uvm_component;
   `uvm_component_utils(consumer)

   uvm_blocking_get_port #(txn) port1

   packet pkt;

   function new(string name = "consumer", uvm_component parent);
     super.new(name, parent);
   endfunction: new

   function void build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   port1 = new("port1", this);
	   pkt = packet::type_id::create("pkt");
   endfunction: build_phase

   task run_phase(uvm_phase phase);
	   super.run_phase(phase);
	   phase.raise_object(this);
	     repeat(10)
	     begin
		     port1.get(pkt);
	     end
           phase.drop_objection(this);
   endtask: run_phase

   endclass: consumer
