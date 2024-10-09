class apb_sc extends uvm_scoreboard;
  
  
  function new(string name = "apb_sc", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  uvm_analysis_imp#(item,apb_sc) sc_ana;
  bit [31:0]check;
  int ass[int];
  item item1;
  `uvm_component_utils_begin(apb_sc)
  `uvm_field_int(check,UVM_ALL_ON)
  `uvm_field_object(item1,UVM_ALL_ON)
  `uvm_component_utils_end
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sc_ana=new("sc_ana",this);
  endfunction
  
  virtual function void write(item item1);
    if(item1.pwrite) 
      begin
      ass[item1.paddr] = item1.pwdata;
    end
    
    else
      begin
        if(!item1.pwrite) begin
          check = ass[item1.paddr];
          if(!( item1.prdata == check))
             `uvm_info("[SC]",$sformatf("FAIL DIFFERENT prdata =%h check =%h",item1.prdata,check),UVM_LOW)
            else
              `uvm_info("[SC]",$sformatf("SUCCESS IN GETTING SAME prdata = %h check=%d",item1.prdata,check),UVM_LOW)
             
              end
              end
              endfunction 
 endclass
