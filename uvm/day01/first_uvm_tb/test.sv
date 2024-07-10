`include "child.sv"

class Test extends uvm_test;
    `uvm_component_utils(Test)

	child ch;
//////////////////////////////////
// CTOR
//////////////////////////////////
    function new(string name = "Test", uvm_component parent);
        super.new(name, parent);
    endfunction : new

//////////////////////////////////
// BUILD_PHASE
//////////////////////////////////
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("Inside build_phase");
		ch = child::type_id::create("ch", this);
    endfunction : build_phase


//////////////////////////////////
// CONNECT_PHASE
//////////////////////////////////
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

//////////////////////////////////
// END_OF_ELABORATION_PHASE
//////////////////////////////////
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
    endfunction : end_of_elaboration_phase


//////////////////////////////////
// START_OF_SIMULATION_PHASE
//////////////////////////////////
    function void start_of_simulation_phase (uvm_phase phase);
        super.start_of_simulation_phase(phase);
    endfunction : start_of_simulation_phase


//////////////////////////////////
// RUN_PHASE
//////////////////////////////////
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask: run_phase


//////////////////////////////////
// EXTRACT_PHASE
//////////////////////////////////
    function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
    endfunction : extract_phase


//////////////////////////////////
// CHECK_PHASE
//////////////////////////////////
    function void check_phase(uvm_phase phase);
        super.check_phase(phase);
    endfunction: check_phase


//////////////////////////////////
// REPORT_PHASE
//////////////////////////////////
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction: report_phase

endclass : Test
