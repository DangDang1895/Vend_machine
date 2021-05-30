`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/27 11:12:59
// Design Name: 
// Module Name: State
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module State(
   input           sys_clk,
   input           sys_rst_n,
   input           have_coin5,
   input           have_coin10,
   output logic [7:0]   price,
   output logic [7:0]   change,
   output logic         open
    );
    
    //s0  ��Ӳ��Ͷ��    ����һ��5��Ͷ�룬תΪs1������һ��10��Ͷ�룬תΪs2��
    //s1  ��5��Ӳ��     ����һ��5��Ͷ�룬תΪs2
    //s2  ��10��Ӳ��    ����һ��5��Ͷ�룬תΪs3
    //s3   ��15��Ӳ��   10s��ת��s0
    logic [30:0] cnt;     
    logic start_flag;
    logic [1:0] S0,S1,S2,S3;
    logic [1:0] current_state ;
    logic [1:0] next_state;
    logic [7:0] cnt5;
    logic [7:0]cnt10;
    logic Is_20;
    logic  flag;
    assign S0=0;
    assign S1=1;
    assign S2=2;
    assign S3=3;
    
  /*   always_ff@(posedge sys_clk) begin
                   if(!sys_rst_n)       x_cnt<=4'b0000;
                   else if(have_coin5)  x_cnt<=x_cnt+1;
                   else  x_cnt<=x_cnt;
      end
      
     always_ff@(posedge sys_clk) begin
                        if(!sys_rst_n)       y_cnt<=4'b0000;
                        else if(have_coin10)  y_cnt<=y_cnt+1;
                        else  y_cnt<=y_cnt;
      end  */
     
    
    
    
    always_ff@(posedge sys_clk) begin
                if(!sys_rst_n)  begin  cnt<=0;flag<=0;end
                else if(next_state==S3)  begin  cnt<=cnt+1;
                if(cnt==(249999990)) begin  flag<=1;cnt<=0;end 
                end
                else flag<=0;
                
    end
    
    always_ff@(posedge sys_clk) begin
                        if(!sys_rst_n)  begin Is_20<=0;end
                        else if(current_state==S2 && have_coin10) begin  Is_20<=1;end
                        else if(next_state ==S0) Is_20<= 0;
                        else Is_20<= Is_20;                   
    end
    
    
    always_ff@(posedge  sys_clk) begin //ͬ����λ
    if(!sys_rst_n) begin current_state <=S0;end
    else current_state <= next_state; //ע�⣬ʹ�õ��Ƿ�������ֵ
    end
    //�ڶ��Σ�����߼� always ģ�飬����״̬ת�������ж�
    always_comb begin
    case(current_state)
    S0: begin if(have_coin5)  begin next_state = S1;end else if( have_coin10) begin next_state = S2;end else  next_state = S0; end
    S1: begin if(have_coin5)  begin next_state = S2;end else if( have_coin10) begin next_state = S3;end else  next_state = S1; end
    S2: begin if(have_coin5)  begin next_state = S3;end else if( have_coin10) begin next_state = S3;end else  next_state = S2; end
    S3: begin if(flag) begin next_state = S0;end else next_state = S3; end 
    endcase
    end
    //�����Σ�ͬ��ʱ�� always ģ�飨����߼�Ҳ���ԣ�������״̬�������
    always_ff@ (posedge  sys_clk) begin
    case(next_state)
    S0: begin open <=0;change<=0;price<=0;end
    S1: begin open <=0;change<=0;price<=5;end
    S2: begin open <=0;change<=0;price<= 10;end
    S3: begin open <=1;begin if(Is_20) begin change<=5;price<=20;end else begin change<=0;price<=15; end end end
    endcase
    end
     //s0  ��Ӳ��Ͷ��    ����һ��5��Ͷ�룬תΪs1������һ��10��Ͷ�룬תΪs2��
       //s1  ��5��Ӳ��     ����һ��5��Ͷ�룬תΪs2
       //s2  ��10��Ӳ��    ����һ��5��Ͷ�룬תΪs3
       //s3   ��15��Ӳ��   10s��ת��s0
    
    
    
    
endmodule
