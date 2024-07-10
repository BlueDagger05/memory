`timescale 1ns/1ps

module top_clock ();
  reg clk;

  initial begin
    clk = 0;
  end

  always clk = ~clk;
  
  initial begin
    $monitor("clk value = %0b", clk);
  end

  initial begin
    $dumpfile("top_clk.vcd");
    $dumpvars(1, top_clock);
  end

  initial #200 $finish;


endmodule : top_clock