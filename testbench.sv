

`timescale 1ns/1ps

module tb_mealey_FSM110;

  // Inputs
  reg clk;
  reg rst;
  reg in;

  // Output
  wire out;

  // Instantiate the DUT
  mealey_FSM110 dut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out)
  );

  // Clock Generation
  initial clk = 0;
  always #5 clk = ~clk; // 10ns period clock

  // Stimulus
  initial begin
    $dumpfile("mealey_FSM110.vcd");
    $dumpvars(0,tb_mealey_FSM110);
    $display("Time\tin\tout");
    $monitor("%0t\t%b\t%b", $time, in, out);

    // Initialize
    rst = 1;
    in  = 0;
    #10;

    rst = 0;

    // Test sequence: 1 1 0 -> detect (output should be 1)
    #10
    in = 1;
    #10
    in = 1;
    #10
    in = 0;

    // Overlapping sequence: 1 1 0 -> detect again
    #10
    in = 1;
    #10
    in = 1;
    #10
    in = 0;

    // No detection: 0 0 1
    in = 0; #10;
    in = 0; #10;
    in = 1; #10;

    // Random bits
    in = 1; #10;
    in = 0; #10;
    in = 1; #10;
    in = 1; #10;
    in = 0; #10;

    $finish;
  end

endmodule
