module apb
#(
  addrWidth = 32,
  dataWidth = 32
)
(
  input                        clk,
  input                        rst_n,
  input        [addrWidth-1:0] paddr,
  input                        pwrite,
  input                        psel,
  input                        penable,
  input        [dataWidth-1:0] pwdata,
  output logic [dataWidth-1:0] prdata
);

  reg [31:0] mem [0:31];

  logic [1:0] apb_st,crt_st;
const logic [1:0] SETUP = 0;
const logic [1:0] W_ENABLE = 1;
const logic [1:0] R_ENABLE = 2;

  
// SETUP -> ENABLE
  always @(posedge clk) begin
    
  if (rst_n) begin
      $display("inside isle");
    apb_st = 0;
    prdata = 0;
    for(int i=0; i<mem[i];i++)begin
      mem[i]=32'h0;
    end
  end
else 
  apb_st = crt_st;
  end
    
  always @(*) begin
    case (apb_st)
      
      SETUP : begin
        if(psel && pwrite)
          crt_st = W_ENABLE;
        else if(psel && !pwrite)
          crt_st = R_ENABLE;
        else
          crt_st =SETUP;
      end
      W_ENABLE : begin
        // write pwdata to memory
        if (psel && penable && pwrite) begin
          $display("inside write mem=%p,",mem);
          mem[paddr] = pwdata;
          $display("inside write mem[%h]=%h,pwdata=%d",paddr,mem[paddr],pwdata);
        end
		else
        // return to SETUP
       crt_st = SETUP;
      end

      R_ENABLE : begin
        // read prdata from memory
        if (psel && penable && !pwrite) begin
          prdata = mem[paddr];
        end
		else
        // return to SETUP
       crt_st = SETUP;
      end
    endcase
  end


endmodule
