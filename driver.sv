class apb_dri extends uvm_driver #(item);
  `uvm_component_utils(apb_dri)
  function new(string name = "apb_dri", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  item item1;
  virtual ab_i vif;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db #(virtual ab_i)::get(this,"","vif1",vif)))
      `uvm_fatal("[DRI]",$sformatf("not get config db"))
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
    reset();
    get_drive();
    end
  endtask
    
    task reset();
        if((vif.prstn)) begin
          vif.penable = 1'b0;
          vif.pwrite = 1'b0;
          vif.pselx = 1'b0;
          vif.paddr = 32'h0;
          vif.pwdata = 32'h0;
        end
    endtask
    
    task get_drive();
      seq_item_port.get_next_item(item1);
      drive(item1);
      seq_item_port.item_done();
    endtask
    
    task drive(item item1);
      @(posedge vif.pclk)
      if(!(vif.prstn))begin
              if(item1.pwrite)
           		 begin 
                  
                   vif.pwrite = item1.pwrite;
              		vif.pselx   = 1'b1 ;
              		vif.paddr   = item1.paddr;
              		vif.pwdata  = item1.pwdata;
                   
                   @(posedge vif.pclk)
                   vif.penable = 1'b1;
            end
      		else begin
              @(posedge vif.pclk)
                vif.pselx = 1'b1;
      			vif.paddr = item1.paddr;
      			vif.pwrite = item1.pwrite;
              @(posedge vif.pclk)
              vif.penable = 1'b1;
            end
      end
    endtask
        
                     endclass
        
