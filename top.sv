`include "uvm_macros.svh"
`include "test.svh"

module tb;
  import uvm_pkg::*;
  bit pclk;
  bit prstn;
  ab_i vif(.pclk(pclk),.prstn(prstn));
  apb p1(.clk(vif.pclk),.rst_n(vif.prstn),.psel(vif.pselx),.penable(vif.penable),.pwrite(vif.pwrite),.paddr(vif.paddr),.pwdata(vif.pwdata),.prdata(vif.prdata));
 
  initial begin
    uvm_config_db#(virtual ab_i)::set(null,"*","ab_i",vif);
    run_test("apb_test");
  end
  
  initial begin
    pclk=1'b1;
    forever  #5 pclk = ~ pclk;
  end
  initial begin
    prstn = 1'b1;
    $display("pseret =%d",prstn);
    #10 prstn = 1'b0;
    $display("pseret =%d",prstn);
  end
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
  #20000 
  $finish;
end
endmodule
  
  
