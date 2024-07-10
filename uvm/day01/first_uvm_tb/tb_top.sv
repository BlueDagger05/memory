`include "uvm_macros.svh"
import uvm_pkg::*;

`include "test.sv"

module tb_top();
initial
 begin
 run_test("Test");
 end
 
 endmodule
