module traffic_light (
  input  clk,
  input  rst,
  input  pass,
  output reg R,
  output reg G,
  output reg Y
);
reg [2:0] state,nextstate;
reg [11:0] count,change;

always @(posedge clk or posedge rst) begin
  if(rst) begin
    state<=3'd0;
    count<=12'd1;
  end
  else begin
    count<=count+12'd1;
    if(pass) begin
      if(state!=3'd0) begin
        count<=12'd1;
        state<=3'd0;
      end  
    end
    if(count==change) begin
      state<=nextstate;
      count<=12'd1;
    end
  end
end

always @(*) begin
  case(state)
      3'd0:begin //green
        change=12'd1024;
        nextstate=3'd1;
      end
      3'd1:begin //none
        change=12'd128;
        nextstate=3'd2;
      end
      3'd2:begin //green
        change=12'd128;
        nextstate=3'd3;
      end
      3'd3:begin //none
        change=12'd128;
        nextstate=3'd4;
      end
      3'd4:begin //green
        change=12'd128;
        nextstate=3'd5;
      end
      3'd5:begin //yellow
        change=12'd512;
        nextstate=3'd6;
      end
      3'd6:begin //red
        change=12'd1024;
        nextstate=3'd0;
      end
  endcase
end

always @(*) begin
  case(state)
      3'd0:begin //green
        R=0;
        G=1;
        Y=0;
      end
      3'd1:begin //none
        R=0;
        G=0;
        Y=0;
      end
      3'd2:begin //green
        R=0;
        G=1;
        Y=0;
      end
      3'd3:begin //none
        R=0;
        G=0;
        Y=0;
      end
      3'd4:begin //green
        R=0;
        G=1;
        Y=0;
      end
      3'd5:begin //yellow
        R=0;
        G=0;
        Y=1;
      end
      3'd6:begin //red
        R=1;
        G=0;
        Y=0;
      end
  endcase
end

endmodule
