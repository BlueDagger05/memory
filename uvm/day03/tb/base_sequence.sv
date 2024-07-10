`ifndef BSEQ
`define BSEQ	
class base_sequence extends uvm_sequence#(pkt);


  `uvm_object_utils(base_sequence)

  function new(string name = "base_sequence");
	  super.new(name);
  endfunction

  task body();
	  `uvm_info(get_full_name(), "Body of sequence", UVM_HIGH)


	  //    only_wr();
	  // pkt_handler = pkt::type_id::create("pkt_handler");
	  //`uvm_do(pkt_handler)
	  // start_item(pkt_handler);
	  //       assert(pkt_handler.randomize() );
	  // finish_item(pkt_handler);
  endtask: body

 // task only_rd;

 //         `uvm_info(get_full_name(), "ONLY READ", UVM_HIGH)

 //          pkt_handler = pkt::type_id::create("pkt_handler");

 //          `uvm_do_with(pkt_handler, {pkt_handler.wr_en == 0;})

 // endtask : only_rd


endclass: base_sequence
`endif
