`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 09:18:03
// Design Name: 
// Module Name: timer
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


module timer(
    input  sys_clk,
    input  sys_rst_n, 
    input  start_flag, 
    output logic [7:0] min,      
    output logic [7:0] sec      
    );
    logic clk_out;
    logic [24:0] cnt;                
    always_ff@(posedge sys_clk) begin
            if(!sys_rst_n) begin cnt<=0;min<=0; sec<=0;end
            else if(start_flag) begin
            cnt<=cnt+1;
            if(cnt==25000000-1) begin
                cnt<=0;
                if(sec==59) begin min<=min+1;sec<=0;end
                else if(min==59) begin min<=0;end
                else sec=sec+1;                
            end
            end
            else cnt<=cnt;
     end
endmodule
