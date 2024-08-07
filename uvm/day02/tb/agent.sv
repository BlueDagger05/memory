`ifndef AGENT
`define AGENT	
class agent extends uvm_agent;
  `uvm_component_utils(agent)


  driver drv;
  seqr   sqr;
  monitor mon;

  function new(string name = "agent", uvm_component parent = null);
	  super.new(name, parent);
  endfunction: new


  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(get_is_active == UVM_ACTIVE)
	begin
		 drv = driver::type_id::create("drv",this);
		 sqr = seqr  ::type_id::create("sqr",this);
	         mon = monitor ::type_id::create("mon",this);
	end
	
	`uvm_info(get_full_name(), "FROM AGENT", UVM_NONE)
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
	  super.connect_phase(phase);
	  // seq_item_port is defined in driver class
	  // seq_item_export is defined in monitor class
	  if(get_is_active == UVM_ACTIVE)
	  begin
		   drv.seq_item_port.connect(sqr.seq_item_export);
	  end

  endfunction: connect_phase

endclass: agent
`endif
