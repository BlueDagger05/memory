`ifndef TEST
`define TEST
class test extends uvm_test;
  `uvm_component_utils(test)

  producer pd;
  consumer cr;

  function new(string name = "test", uvm_component parent);
	  super.new(name, parent);
  endfunction: new
 
  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	  pd = producer::type_id::create("pd", this);
	  cr = consumer::type_id::create("cr", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
	  cr.port1.connect(pd.port1);
  endfunction : connect_phase

  function void final_phase(uvm_phase phase);
	  super.final_phase(phase);
	  `uvm_info(get_full_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
	  `uvm_info(get_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
	  `uvm_info(get_type_name(),"CHECK UVM INFO LEVEL", UVM_LOW)
  endfunction


endclass: test

`endif
