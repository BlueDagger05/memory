class child extends uvm_component;
`uvm_component_utils(child)
//////////////////////////////////
// CTOR
//////////////////////////////////

    function new(string name = "child", uvm_component parent);
        super.new(name, parent);
    endfunction : new

//////////////////////////////////
// BUILD_PHASE
//////////////////////////////////
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("Inside build_phase");
    endfunction : build_phase


//////////////////////////////////
// CONNECT_PHASE
//////////////////////////////////
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
		$display("Inside CONNECT_PHASE");
    endfunction : connect_phase

//////////////////////////////////
// END_OF_ELABORATION_PHASE
//////////////////////////////////
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
		$display("Inside END_OF_ELABORATION_PHASE");
    endfunction : end_of_elaboration_phase


//////////////////////////////////
// START_OF_SIMULATION_PHASE
//////////////////////////////////
    function void start_of_simulation_phase (uvm_phase phase);
        super.start_of_simulation_phase(phase);
		$display("Inside START_OF_SIMULATION_PHASE");
    endfunction : start_of_simulation_phase


//////////////////////////////////
// RUN_PHASE
//////////////////////////////////
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
		$display("Inside RUN_PHASE");
    endtask: run_phase


//////////////////////////////////
// EXTRACT_PHASE
//////////////////////////////////
    function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
		$display("Inside EXTRACT_PHASE");
    endfunction : extract_phase


//////////////////////////////////
// CHECK_PHASE
//////////////////////////////////
    function void check_phase(uvm_phase phase);
        super.check_phase(phase);
		$display("Inside CHECK_PHASE");
    endfunction: check_phase


//////////////////////////////////
// REPORT_PHASE
//////////////////////////////////
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
		$display("Inside REPORT_PHASE");
    endfunction: report_phase
	
	
endclass: child	

