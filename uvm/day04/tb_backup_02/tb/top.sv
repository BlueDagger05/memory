`include "uvm_macros.svh"
 import uvm_pkg ::*;

 `include "interface.sv"
 `include "inclusion_pkg.sv"
 import inclusion_pkg::*;
 `include "environment.sv"
 `include "base_test.sv"
 module top();

 // local clk and reset
 bit clk;
 bit reset_n;
 int numofPackets = 10;


 initial
 begin
	 run_test("base_test");

 end
 // interface instantiation
 reset_interface ifc(clk, reset_n);
 

 // reset and clk initialization	     
// initial 
// begin
//	 clk     = 0;
// end
 

 // clock generation
 always #10 clk = ~clk;


  // setting uvm_config_db to every class present in the environment
 initial
 begin
	 uvm_config_db #(virtual reset_interface)::set(null, "*", "ANY_KEY", ifc);

	 uvm_config_db #(int)::set(null, "*", "PKT", numofPackets );
 end
 
endmodule : top
