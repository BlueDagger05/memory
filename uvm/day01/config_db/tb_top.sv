`include "uvm_macros.svh"
import uvm_pkg::*;

`include "child.sv"
`include "test.sv"
module tb_top();
initial
 begin
	 uvm_config_db #(int)::set(null, "uvm_test_top.ch", "ANY_KEY", 11);
	 run_test("test");
 end
 
 endmodule
