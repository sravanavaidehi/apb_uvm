class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)
  function new(string name = "apb_agent", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
apb_dri dri;
apb_mon mon;
apb_sequencer sequencer;

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  sequencer = apb_sequencer::type_id::create("sequencer",this);
  dri = apb_dri::type_id::create("dri",this);
  mon = apb_mon::type_id::create("mon",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  dri.seq_item_port.connect(sequencer.seq_item_export);
endfunction
  
endclass
