class reset_pkt extends uvm_sequence_item;
 
////////////////////////////////
// data fields
////////////////////////////////

  randc bit reset_n;
  
////////////////////////////////
// CTOR and registering 
// it to the factory
////////////////////////////////

 `uvm_object_utils_begin(reset_pkt)
 `uvm_field_int(reset_n, | UVM_ALL_ON | UVM_DEFAULT)
 `uvm_object_utils_end

  function new (string name = "reset_pkt");
	  super.new(name);
  endfunction : new


endclass: reset_pkt
