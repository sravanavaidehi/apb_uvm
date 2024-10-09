interface ab_i(input pclk,prstn);
  logic pselx,penable,pwrite;
  logic [31:0]paddr,pwdata;
  logic [31:0]prdata;
  logic pready;
endinterface
  
