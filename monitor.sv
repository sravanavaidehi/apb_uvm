class apb_mon extends uvm_monitor;
  `uvm_component_utils(apb_mon)
  function new(string name = "apb_mon", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  item item1;
  virtual ab_i vif;
  uvm_analysis_port#(item) mon_ana;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!(uvm_config_db #(virtual ab_i):: get(this,"","vif1",vif)))
      `uvm_fatal("[MON]",$sformatf("NOT GET VIF"))
     item1  = item::type_id::create("item1");
      mon_ana=new("mon_ana",this);
   endfunction
      
   virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
     
     forever begin
       @(posedge vif.pclk);
         begin
          item1.pselx = vif.pselx;
           item1.penable = vif.penable;
           item1.paddr = vif.paddr;
           item1.pwrite = vif.pwrite;
           
           if(vif.pwrite)
             item1.pwdata = vif.pwdata;
           else 
             item1.prdata = vif.prdata;
              
      mon_ana.write(item1);
     end
     end
       
    endtask
endclass
