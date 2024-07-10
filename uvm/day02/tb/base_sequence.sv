class base_sequence extends uvm_sequence#(pkt);
  pkt pkt_handler;

  `uvm_object_utils(base_sequence)

  function new(string name = "base_sequence");
	  super.new(name);
  endfunction

  task body();
	  `uvm_info(get_full_name(), "Body of sequence", UVM_HIGH)

	   pkt_handler = pkt::type_id::create("pkt_handler");
	  //`uvm_do(pkt_handler)
	  start_item(pkt_handler);
		assert(pkt_handler.randomize() );
	  finish_item(pkt_handler);
  endtask: body


endclass: base_sequence
