class seqr extends uvm_sequencer#(reset_pkt);
	
  `uvm_component_utils(seqr)

////////////////////////////////////////
// NEW
////////////////////////////////////////
  function new(string name =  "seqr", uvm_component parent = null);
	  super.new(name, parent);
	  // $display("inside sequencer");
  endfunction: new


////////////////////////////////////////
// BUILD_PHASE 
////////////////////////////////////////
  function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_full_name(), "FROM SEQUENCER", UVM_HIGH)
  endfunction


endclass: seqr
