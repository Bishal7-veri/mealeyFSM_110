// Code your design here
//mealey sequence for overlapping allowed 110

module mealey_FSM110(input clk, rst, in,
                     output reg out);
  
   typedef enum logic [1:0] {
    S0, // Initial state
    S1, // Detected 1
    S2  // Detected 11
  } states;
    states current_state, next_state; 
  always @ (posedge clk) 
    begin
      if(rst)
        begin
          current_state <= S0;
        end
      else 
        current_state <= next_state;
    end
  
  // flip flop logic
  
  always @ (posedge clk)
    begin
      case (current_state)
        S0 : next_state = (in) ? S1 : S0;
        S1 : next_state = (in) ? S2 : S0;
        S2 : next_state = (in) ? S2 : S0;
        default : next_state = S0;
      endcase
    end
  
  // output logic
  // always block for combinational block
  always_comb begin
    case (current_state)
      S2: out = (!in) ? 1 : 0;  // When S2 and input 0 → detected 110
      default: out = 0;
    endcase
  end
  
    
  
endmodule
