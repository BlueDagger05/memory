class packet extends uvm_sequence_item;
 randc bit [31:0] addr;
 randc bit [63:0] data;

 `uvm_object_utils_begin(packet)
 `uvm_field_int(addr, UVM_ALL_ON | UVM_DEFAULT)
// `uvm_field_int(data,UVM_ALL_ON | UVM_DEFAULT)
 `uvm_object_utils_end

 function new(string name = "packet");
	 super.new(name);
 endfunction : new

 function void display();
	 $display("addr = 0x%0h, data = 0x%0h", addr, data);
 endfunction: display


endclass: packet
