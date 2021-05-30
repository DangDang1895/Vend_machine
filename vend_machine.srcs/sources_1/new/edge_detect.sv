`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 08:46:21
// Design Name: 
// Module Name: edge_detect
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


module edge_detect(
    input           	sys_clk,
    input         	sys_rst_n,
    input	       	coin5,
    input           coin10,
    output logic	have_coin5,
    output logic    have_coin10
  
    );
       logic [1:0] coin5_start;
       logic [1:0] coin10_start;
     //  logic    edge_coin5;
     //  logic    edge_coin10;
	   always_ff@(posedge sys_clk)
	   begin
		    if(sys_rst_n==0) begin coin5_start<=2'b00;end
		    else begin coin5_start<={coin5_start[0],coin5}; end
	   end 
	   always_ff@(posedge sys_clk)
       begin
            if(sys_rst_n==0) begin coin10_start<=2'b00;end
            else begin coin10_start<={coin10_start[0],coin10}; end
       end 
	   assign	 have_coin5  =( coin5_start[0]  & (~coin5_start[1]));
	   assign	 have_coin10 =( coin10_start[0] & (~coin10_start[1]));
		
      /*  always_ff@(posedge sys_clk) begin
        if(!sys_rst_n) begin have_coin5<=0;end
        else if(edge_coin5)  have_coin5 <= have_coin5+1;
        else  have_coin5<=have_coin5;
        end
        
       always_ff@(posedge sys_clk) begin
       if(!sys_rst_n) begin have_coin10<=0;end
       else if(edge_coin10) have_coin10<= have_coin10+1;
       else begin have_coin10<=have_coin10;end
       end*/

endmodule
