
`timescale 1ns/1ps
module ram16_8_tb;

  reg clk0 = 0, clk1 = 0;
  reg [7:0] din_a, din_b;
  reg [3:0] addr_a, addr_b;
  reg we_a, we_b;
  reg re_a, re_b;
  wire [7:0] dout_a, dout_b;
  reg rst;

  ram16_8 dut(
    .clk0(clk0), 
    .clk1(clk1),
    .rst(rst),
    .din_a(din_a), .din_b(din_b),
    .dout_a(dout_a), .dout_b(dout_b),
    .addr_a(addr_a), .addr_b(addr_b),
    .we_a(we_a), .we_b(we_b),
    .re_a(re_a), .re_b(re_b)
  );

  always #5 clk0 = ~clk0;   // 100 MHz
  always #10 clk1 = ~clk1;  // 50 MHz

  initial begin
    $monitor("T=%0t | A: addr=%0d din=%0d dout=%0d we=%b re=%b | B: addr=%0d din=%0d dout=%0d we=%b re=%b | rst=%b",
              $time, addr_a, din_a, dout_a, we_a, re_a,
              addr_b, din_b, dout_b, we_b, re_b, rst);

    // 🔹 Apply reset
    rst = 1;
    we_a = 0; we_b = 0;
    re_a = 0; re_b = 0;
    #15;
    rst = 0;

    // 🔹 Write using Port A
    addr_a = 4'd2; din_a = 8'd10; we_a = 1; re_a = 0;
    #10;
    we_a = 0;

    // 🔹 Read using Port A
    re_a = 1;
    #10;

    // 🔹 Write using Port B
    addr_b = 4'd5; din_b = 8'd20; we_b = 1; re_b = 0;
    #20;
    we_b = 0;

    // 🔹 Read using Port B
    re_b = 1;
    #20;

    // 🔴 Same address conflict test
    addr_a = 4'd3; din_a = 8'd55; we_a = 1;
    addr_b = 4'd3; din_b = 8'd99; we_b = 1;
    #20;

    we_a = 0; we_b = 0;

    // 🔹 Read conflict result
    re_a = 1; re_b = 1;
    #20;

    $finish;
  end

endmodule