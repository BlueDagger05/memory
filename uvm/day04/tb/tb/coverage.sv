`ifndef COVG
`define COVG
class coverage extends uvm_subscriber#(pkt);
   `uvm_component_utils(coverage)


   uvm_analysis_imp #(pkt, coverage) cov_export;
   pkt pkt_handler;
 

///////////////////////////////////////
// COVERGROUP
//////////////////////////////////////
   covergroup covgp1;
	   addr:  coverpoint pkt_handler.addr_in
	   {
		   bins addr1 = {8'hA};
		   bins addr2 = {8'hB};
		   bins addr3 = {8'hC};
                   }

	   data:  coverpoint pkt_handler.data_in
	   {
		   bins data1 = {8'hA};
		   bins data2 = {8'hB};
		   bins data3 = {8'hC};
		   }

	   op_en: coverpoint pkt_handler.op_en
	   {
		   bins in  = {1'b1};
		   bins out = {1'b0};
		   }

	   wr_en: coverpoint pkt_handler.wr_en
	   {
		   bins is_wr = {1'b1};
		   bins is_rd = {1'b0};
		   }
   endgroup


///////////////////////////////////////
// NEW
//////////////////////////////////////

   function new(string name = "coverage", uvm_component parent = null);
	   super.new(name, parent);
	   covgp1 = new();
   endfunction



///////////////////////////////////////
// BUILD_PHASE
//////////////////////////////////////

   function void build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   cov_export = new("cov_export", this);
	   // $display("Inside coverage bp");

   endfunction: build_phase



///////////////////////////////////////
// WRITE
//////////////////////////////////////

   function void write(pkt t);
	   pkt_handler = t;
	   covgp1.sample();
	   // pkt_handler.print();
   endfunction: write



///////////////////////////////////////
// EXTRACT_PHASE
//////////////////////////////////////

   function void extract_phase(uvm_phase phase);
	   super.extract_phase(phase);
	    // $display("Inside coverage bp");
	    `uvm_info(get_type_name, $sformatf(" COVERAGE REPORT :: %.2f", covgp1.get_coverage() ), UVM_LOW)

   endfunction: extract_phase



///////////////////////////////////////
// CHECK_PHASE
//////////////////////////////////////

  function void check_phase(uvm_phase phase);
	  super.check_phase(phase);
          // $display("cov check function call");
  endfunction : check_phase 

endclass: coverage


   
`endif
