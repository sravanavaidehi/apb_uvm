class apb_coverage extends uvm_subscriber#(item);
   `uvm_component_utils(apb_coverage)
  item i;
    virtual ab_i inf;
  covergroup cg;
    cp_clk: coverpoint i.pselx;
  //  cp_startofaccess:coverpoint i.pready iff(i.psel && i.penable);
  endgroup
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
    cg= new();
  endfunction
  
  virtual function void buil_phase(uvm_phase phase);
    super.build_phase(phase);
        
    if(!(uvm_config_db #(virtual ab_i)::get(this,"","inf",inf)))
         `uvm_fatal("cov",$sformatf("NOT GET CONFIG"))
    i=new();
  endfunction
  
  virtual function void write(item i);
    this.i=i;
    cg.sample();
  endfunction
  
endclass

    
    
