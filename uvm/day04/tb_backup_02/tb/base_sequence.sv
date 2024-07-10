`ifndef BSEQ
`define BSEQ
class base_sequence extends uvm_sequence#(reset_pkt);
   `uvm_object_utils(base_sequence)

// reset_pkt instantiation
   reset_pkt rst_pkt;


////////////////////////////////////////
// NEW
////////////////////////////////////////
   function new(string name = "base_sequence");
	   super.new(name);
   endfunction : new


////////////////////////////////////////
// BODY
////////////////////////////////////////
   task body();
	   `uvm_info(get_full_name(), "Body of base sequence...", UVM_HIGH)

	   rst_pkt = reset_pkt::type_id::create("rst_pkt");

	   `uvm_do_with(rst_pkt, {rst_pkt.reset_n == 1;})
   endtask : body


endclass : base_sequence


`endif
