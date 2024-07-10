// in the command line
// vlog top.sv
// vsim top +TEST=<testname>

`include "uvm_macros.svh"
 import uvm_pkg ::*;

 `include "../hdl/interface.sv"
 `include "../hdl/memory.sv"
 `include "pkt.sv"
 `include "sequencer.sv"
 `include "driver.sv"
 `include "monitor.sv"
 `include "agent.sv"
 `include "scoreboard.sv"
 `include "coverage.sv"
 `include "environment.sv"
 `include "base_sequence.sv"
 `include "write_sequence.sv"
 `include "write_test.sv"
 `include "wr_rd_test.sv"
 `include "base_test.sv"
 `include "test1.sv"
 `include "test2.sv"
 `include "test3.sv"
 `include "test4.sv"

 module top();

 // local clk and reset
 bit clk;
 bit reset_n;
 int numofPackets = 10;


 initial begin
         string TESTNAME;

	 if($value$plusargs("TEST=%s", TESTNAME))
	 begin
		 $display("Runnning test %s .....", TESTNAME);
		 run_test(TESTNAME);
	 end
	 else
	 begin
        	 `ifdef ABC
	        	 $display("ifdef is passing ------");
		 `endif
		 $display("Running base_test ....");
		 run_test("base_test");
	 end

 end


/*
 initial begin
 	string TEST1 = "base_test";
 	string TEST2 = "write_read_test";
 	string TEST3 = "write_test";

 	if($test$plusargs("TEST1"))
 	begin
 	    run_test(TEST1);
 	    $display("Running test %s ...", TEST1);
 		
 	end

 	if($test$plusargs("TEST2"))
 	begin
 		run_test(TEST2);
 		$display("Running test %s ...", TEST2);
 	end

 	else 
 	begin
 		$display("Running test %s ...", TEST3);
 		run_test(TEST3);
 	end
 end
 */
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

	 uvm_config_db #(int)::set(null, "*", "PKT", numofPackets );
 end
 
 // 
 initial
 begin
         // run_test("write_read_test");
 end

 // final
// initial #2000 $finish;

endmodule : top
