class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)
  function new(string name = "apb_env", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  apb_agent ag;
  apb_sc sc;
  apb_coverage cov;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    ag = apb_agent::type_id::create("ag",this);
    sc = apb_sc::type_id::create("sc",this);
    cov=apb_coverage::type_id::create("cov",this); 
    
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     ag.mon.mon_ana.connect(cov.analysis_export);
    ag.mon.mon_ana.connect(sc.sc_ana);
   
  endfunction
endclass
