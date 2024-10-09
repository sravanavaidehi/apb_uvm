class apb_seq extends uvm_sequence #(item);
  `uvm_object_utils(apb_seq)
  item item1;
  function new(string name = "apb_seq");
    super.new(name);
    set_automatic_phase_objection(1);
  endfunction
  task body();
    begin
     // $display("inside seq");
      item item1 = item::type_id::create("item1");
      repeat(10) begin
      
    start_item(item1);
     // `uvm_info("[SEQ]",$sformatf("item get started"),UVM_MEDIUM)

      assert( item1.randomize() with {(item1.pwrite==1);});
     // `uvm_info("[SEQWRITE]",$sformatf("item getting randamozied %s",item1.convert2str()),UVM_LOW)

      finish_item(item1);
      //`uvm_info("[SEQwrite]",$sformatf("finish item"),UVM_LOW)
      start_item(item1);
      item1.randomize() with {(item1.pwrite == 0);};
    //  `uvm_info("[SEQREAD]",$sformatf("item getting randamozied %s",item1.convert2str()),UVM_LOW)
      finish_item(item1);
    //`uvm_info("[SEQREAD]",$sformatf("done item"),UVM_LOW)
      
    end
    end
  endtask
endclass
