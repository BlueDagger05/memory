  `include "../hdl/interface.sv"
  `include "../hdl/memory.sv"
  `include "interface_rst.sv"
  `include "uvm_macros.svh"
  import uvm_pkg ::*;
  `include "inclusion_pkg.sv"
  `include "memory_pkg.sv"
  import memory_pkg::*;
  `include "environment.sv"
  `include "base_test.sv"
  `include "write_test.sv"
  `include "wr_rd_test.sv"

 module top();

 // local clk and reset
 bit clk;
 bit reset_n;
 int numofPackets = 10;

 string TESTNAME = "";

 initial begin
	 if($value$plusargs ("testname=%s", TESTNAME))
	 begin
		 $display("%s", TESTNAME);
		 run_test(TESTNAME);
	 end
	 else
	 begin
		 `ifdef ABC
			 $display("ifdef is passing ------");
		 `endif

		 $display("----------------%s---------------", TESTNAME);
		 run_test("write_read_test");
	 end

 end
 // 
 reset_interface rst_ifc(clk, reset_n);
 // interface instantiation
 mem_ifc ifc(clk, reset_n);
 
 
 // DUT instantiation
 memory DUT (
	     .clk(ifc.clk),
	     .reset_n(rst_ifc.reset_n),
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

	 uvm_config_db #(virtual reset_interface)::set(null, "*", "RST_KEY", rst_ifc);

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
