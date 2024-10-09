class item extends uvm_sequence_item;
  
  rand bit  pwrite;
 rand bit pselx, penable;
  rand bit [31:0]paddr,pwdata;
  bit [31:0]prdata;
  rand bit pready;
  
  `uvm_object_utils_begin(item)
  	`uvm_field_int(pwrite,UVM_ALL_ON)
  	`uvm_field_int(pselx,UVM_ALL_ON)
  	`uvm_field_int(penable,UVM_ALL_ON)
  	`uvm_field_int(paddr,UVM_ALL_ON)
  	`uvm_field_int(pwdata,UVM_ALL_ON)
  	`uvm_field_int(prdata,UVM_ALL_ON)
  	`uvm_field_int(pready,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "item");
    super.new(name);
  endfunction
  
  constraint k{pwdata inside{[20:100]};}
 /* constraint k{paddr inside{[0:6]};}
 constraint h{pselx == 1'b1;}
  constraint f{pready dist{0:/20 , 1:/80};}
  constraint l{penable ==1'b1;}*/
   virtual function string convert2str();
     return $sformatf("values of items pselx = %d penable =%d pwrite = %d paddr =%h pwdata= %h prdata=%h pready = %d",pselx, penable, pwrite, paddr,pwdata, prdata, pready);
  endfunction
 

endclass
