class apb_test extends uvm_test;
  `uvm_component_utils(apb_test);
  function new(string name = "apb_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  apb_env e;
  virtual ab_i vif;
  apb_seq s;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    e = apb_env::type_id::create("e",this);
    if(!(uvm_config_db #(virtual ab_i)::get(this,"","ab_i",vif)))
    `uvm_fatal("[test]",$sformatf("didnot set vif"))
      uvm_config_db #(virtual ab_i)::set(this,"*","vif1",vif);   
      s= apb_seq::type_id::create("s");
    
   endfunction
   virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
     s.start(e.ag.sequencer);
    phase.drop_objection(this);
  endtask

endclass
