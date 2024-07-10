`include "uvm_macros.svh"
 import uvm_pkg ::*;

 `include "../hdl/interface.sv"
 `include "../hdl/memory.sv"
 `include "pkt.sv"
 `include "sequencer.sv"
 `include "driver.sv"
 `include "monitor.sv"
 `include "agent.sv"
 `include "environment.sv"
 `include "base_sequence.sv"
 `include "base_test.sv"

 module top();

 // local clk and reset
 bit clk;
 bit reset_n;

 // interface instantiation
 mem_ifc ifc(clk, reset_n);

 // DUT instantiation
 memory DUT (
	     .clk(ifc.clk),
	     .reset_n(ifc.reset_n),
	     .addr_in(ifc.addr_in),
	     .data_in(ifc.data_in),
	     .wr_en(ifc.wr_en),
	     .op_en(ifc.op_en),
	     .cs(ifc.cs),
	     .data_out(ifc.data_out)
	     );

 // reset and clk initialization	     
 initial 
 begin
	 reset_n = 0;
	 clk     = 0;
 #50	 reset_n = 1;
 end
 

 // clock generation
 always #10 clk = ~clk;


  // setting uvm_config_db to every class present in the environment
 initial
 begin
	 uvm_config_db #(virtual mem_ifc)::set(null, "*", "ANY_KEY", ifc);

 end
 
 // 
 initial
 begin
         run_test("base_test");
 end

 // final
 initial #1000 $finish;

endmodule : top
