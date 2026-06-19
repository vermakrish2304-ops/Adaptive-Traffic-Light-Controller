`timescale 1ns / 1ps

module traffic_light_tb;

reg clk;
reg reset;
reg traffic_low;
reg traffic_normal;
reg traffic_high;
reg emergency_vehicle;
reg [1:0] emergency_direction;

wire north_red,  south_red,  east_red,  west_red;
wire north_green,south_green,east_green,west_green;
wire north_yellow,south_yellow,east_yellow,west_yellow;

traffic_light uut (
    .clk(clk),
    .reset(reset),
    .traffic_low(traffic_low),
    .traffic_normal(traffic_normal),
    .traffic_high(traffic_high),
    .emergency_vehicle(emergency_vehicle),
    .emergency_direction(emergency_direction),
    .north_red(north_red),   .south_red(south_red),
    .east_red(east_red),     .west_red(west_red),
    .north_green(north_green),.south_green(south_green),
    .east_green(east_green),  .west_green(west_green),
    .north_yellow(north_yellow),.south_yellow(south_yellow),
    .east_yellow(east_yellow),  .west_yellow(west_yellow)
);

always #5 clk = ~clk;

initial begin
    clk                 = 0;
    reset               = 1;
    traffic_low         = 0;
    traffic_normal      = 0;
    traffic_high        = 0;
    emergency_vehicle   = 0;
    emergency_direction = 2'b00;

    #20;
    reset = 0;

    traffic_normal = 1;
    #5000;

    traffic_normal      = 0;
    traffic_high        = 1;
    #5000;

    traffic_high        = 0;
    traffic_low         = 1;
    #5000;

    traffic_low         = 0;
    traffic_normal      = 1;
    emergency_vehicle   = 1;
    emergency_direction = 2'b10;
    #200;
    emergency_vehicle   = 0;
    #5000;

    traffic_normal      = 0;
    emergency_vehicle   = 1;
    emergency_direction = 2'b11;
    #200;
    emergency_vehicle   = 0;

    traffic_high = 1;
    #5000;

    $finish;
end

endmodule