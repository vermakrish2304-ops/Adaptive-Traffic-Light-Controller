`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2026 02:34:30
// Design Name: 
// Module Name: traffic_light
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


module traffic_light(
    input clk,
    input reset,
    input traffic_low,
    input traffic_normal,
    input traffic_high,
    input emergency_vehicle,
    input [1:0] emergency_direction,
    output reg north_red,south_red, east_red, west_red,
    output reg north_green, south_green, west_green, east_green,
    output reg north_yellow, south_yellow, east_yellow, west_yellow
);

parameter north_green_s = 4'b0000;
parameter north_yellow_s = 4'b0001;
parameter south_green_s = 4'b0010;
parameter south_yellow_s = 4'b0011;
parameter east_green_s = 4'b0100;
parameter east_yellow_s = 4'b0101;
parameter west_green_s = 4'b0110;
parameter west_yellow_s = 4'b0111;
parameter emergency_s = 4'b1000;

parameter NORTH = 2'b00;
parameter SOUTH = 2'b01;
parameter EAST  = 2'b10;
parameter WEST  = 2'b11;

reg [3:0] state;
reg [3:0] next_state;
reg [3:0] counter;
reg [3:0] green_time;



always @(posedge clk or posedge reset)
begin
    if(reset)
        state <= north_green_s;
    else
        state <= next_state;
end

always @(*)
begin 
  
      if(traffic_low) begin
       green_time = 3;
       
     end else if (traffic_normal) begin
        green_time = 6;
        
     end else if (traffic_high) begin
        green_time = 9;
        
      end else begin
        green_time = 6;
        
      end
  end 
  

always @(*)
begin

    if(emergency_vehicle)
        next_state = emergency_s;

    else
    begin
        case(state)

           north_green_s : 
           begin
                   if(counter >= green_time)
                         next_state = north_yellow_s;
                    else
                         next_state = north_green_s;
                   end
                   
           north_yellow_s : 
           begin
                   if(counter >= 3)
                         next_state = south_green_s;
                    else
                         next_state = north_yellow_s;
                   end
                   
                   south_green_s : 
           begin
                   if(counter >= green_time)
                         next_state = south_yellow_s;
                    else
                         next_state = south_green_s;
                   end
                   
                   south_yellow_s : 
           begin
                   if(counter >= 3)
                         next_state = east_green_s;
                    else
                         next_state = south_yellow_s;
                   end
                   
                   east_green_s : 
           begin
                   if(counter >= green_time)
                         next_state = east_yellow_s;
                    else
                         next_state = east_green_s;
                   end
                   
                   
                   east_yellow_s : 
           begin
                   if(counter >= 3)
                         next_state = west_green_s;
                    else
                         next_state = east_yellow_s;
                   end
                   
                   
                   west_green_s : 
           begin
                   if(counter >= green_time)
                         next_state = west_yellow_s;
                    else
                         next_state = west_green_s;
                   end
                   
                   
                   west_yellow_s : 
           begin
                   if(counter >= 3)
                         next_state = north_green_s;
                    else
                         next_state = west_yellow_s;
                   end    
                   
                   
                   emergency_s:
                if(!emergency_vehicle)
                    next_state = north_green_s;
                else
                    next_state = emergency_s; 
                   
                   default: 
                   next_state = north_green_s;   

        endcase
    end
end

always @(posedge clk or posedge reset)
begin
    if(reset)
        counter <= 0;
    else if(state != next_state)
        counter <= 1;
    else
        counter <= counter + 1;
end

always @(*)
begin
    north_red =0;  south_red=0; east_red=0; west_red=0;
     north_green =0;  south_green=0; west_green=0; east_green=0;
     north_yellow = 0;  south_yellow=0; east_yellow=0; west_yellow = 0;

    case(state)
        
        north_green_s : 
        begin
                north_green = 1;
                south_red = 1;
                east_red = 1;
                west_red = 1;
         end
         
         north_yellow_s : 
        begin
                north_yellow = 1;
                south_red = 1;
                east_red = 1;
                west_red = 1;
         end
         
         south_green_s : 
        begin
                south_green = 1;
                north_red = 1;
                east_red = 1;
                west_red = 1;
         end
         
         south_yellow_s : 
        begin
                south_yellow = 1;
                north_red = 1;
                east_red = 1;
                west_red = 1;
         end
         
         east_green_s : 
        begin
                east_green = 1;
                south_red = 1;
                north_red = 1;
                west_red = 1;
         end
         
         east_yellow_s : 
        begin
                east_yellow = 1;
                south_red = 1;
                north_red = 1;
                west_red = 1;
         end
         
         west_green_s : 
        begin
                west_green = 1;
                south_red = 1;
                east_red = 1;
                north_red = 1;
         end
         
        west_yellow_s : 
        begin
                west_yellow = 1;
                south_red = 1;
                north_red = 1;
                east_red = 1;
         end
        
       emergency_s:
        begin
            case(emergency_direction)
                NORTH:
                begin
                    north_green = 1;
                    south_red   = 1;
                    east_red    = 1;
                    west_red    = 1;
                end
                SOUTH:
                begin
                    south_green = 1;
                    north_red   = 1;
                    east_red    = 1;
                    west_red    = 1;
                end
                EAST:
                begin
                    east_green  = 1;
                    north_red   = 1;
                    south_red   = 1;
                    west_red    = 1;
                end
                WEST:
                begin
                    west_green  = 1;
                    north_red   = 1;
                    south_red   = 1;
                    east_red    = 1;
                end
                default:
                begin
                    north_green = 1;
                    south_red   = 1;
                    east_red    = 1;
                    west_red    = 1;
                end
            endcase
          end   
        
    endcase
end

endmodule
