`ifndef WSEQ
`define WSEQ	
/////////////////////////////////////////
// WR_CLASS
/////////////////////////////////////////
class write_sequence extends base_sequence;

 `uvm_object_utils(write_sequence)

  pkt pkt_handler;

  function new(string name = "write_sequence");
	  super.new(name);
  endfunction

  task body();
	  super.body();
	  `uvm_info(get_full_name(), "ONLY WRITE", UVM_HIGH)

	   pkt_handler = pkt::type_id::create("pkt_handler");

	   `uvm_do_with(pkt_handler, {pkt_handler.wr_en == 1;})

  endtask : body

endclass: write_sequence


/////////////////////////////////////////
// RD_CLASS
/////////////////////////////////////////
class read_sequence extends base_sequence;

  `uvm_object_utils(read_sequence)

  pkt pkt_handler;

  function new(string name = "read_sequence");
	  super.new(name);
  endfunction

  task body();
	  super.body();
	  `uvm_info(get_full_name(), "ONLY READ", UVM_HIGH)

	   pkt_handler = pkt::type_id::create("pkt_handler");

	   `uvm_do_with(pkt_handler, {pkt_handler.wr_en == 0;})

  endtask : body

endclass: read_sequence



/////////////////////////////////////////
// WR_RD_CLASS
/////////////////////////////////////////
class wr_rd_sequence extends base_sequence;

  `uvm_object_utils(wr_rd_sequence) 

  read_sequence  rseq;
  write_sequence wseq;

  function new(string name = "wr_rd_sequence");
	  super.new(name);
  endfunction

  task body();
	  super.body();
	  `uvm_info(get_full_name(), "ONLY WRITE READ", UVM_HIGH)

	   `uvm_do(wseq)
	   `uvm_do(rseq)
  endtask : body

endclass: wr_rd_sequence

`endif
