`include "uvm_macros.svh"
import uvm_pkg::*;
`include "pkt.sv"
`include "producer.sv"
`include "consumer.sv"
`include "test.sv"

module tb_top();
initial
 begin
 run_test("test");
 end
 
 endmodule
