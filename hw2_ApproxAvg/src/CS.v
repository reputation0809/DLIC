module CS(
  input                                 clk, 
  input                                 reset,
  input                           [7:0] X,
  output                          [9:0] Y
);

reg [7:0] appro;
reg [7:0] shift[8:0];
reg [11:0] sum;
reg [3:0] i;

always @(posedge clk or posedge reset) begin
  if(reset) begin
    sum<=12'd0;
    for(i=0;i<9;i=i+1) begin
      shift[i]<=8'd0;
    end
  end
  else begin
    shift[0]<=shift[1];
    shift[1]<=shift[2];
    shift[2]<=shift[3];
    shift[3]<=shift[4];
    shift[4]<=shift[5];
    shift[5]<=shift[6];
    shift[6]<=shift[7];
    shift[7]<=shift[8];
    shift[8]<=X;

    sum<=sum+X-shift[0];
  end
end

assign Y=(sum+(($unsigned(appro)<<3)+appro))>>3;

always @(*) begin
  appro=8'd0;
  for(i=0;i<9;i=i+1) begin
    if((($unsigned(shift[i])<<3)+shift[i])<=sum&&shift[i]>appro) begin
      appro=shift[i];
    end
  end
end

endmodule
