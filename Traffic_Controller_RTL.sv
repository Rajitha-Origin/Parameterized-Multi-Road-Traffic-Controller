// Code your design here
/*
PATH1 : Road A Straight Movement
PATH2 : Road B Straight Movement
PATH3 : Road B -> Road D Turn
PATH4 : Road C -> Road B Turn
PATH5 : Road A -> Road D Turn
PATH6 : Road C -> Road A Turn


Green == 001
Yellow == 010
Red == 100

Pedestrian Request: Forces an immediate transition to the next traffic state.


Emergency Mode: Priority is granted to Road A traffic.
PATH1 and PATH6 remain GREEN.
All conflicting movements remain RED.


Night Mode:
PATH1, PATH2, PATH3, and PATH4 operate in yellow caution mode
PATH5 and PATH6 remain red.

*/

module Traffic_Controller #(parameter Green_Time = 10, Yellow_Time = 6) (input wire clk, rst, pedestrian_req, emergency, night_mode, output reg [2:0] PATH1, PATH2, PATH3, PATH4, PATH5, PATH6);
  
  typedef enum reg[2:0] {S0, S1, S2, S3, S4, S5} states;
  states present_state, next_state;
  
  reg [7:0] timer;
  reg timer_reset;
  
  localparam Green = 3'b001, Yellow = 3'b010, Red = 3'b100;
  
  
  always @(posedge clk or negedge rst) begin
    if(!rst) begin
      present_state <= S0;
      timer <= 0;
    end
    else begin
      
      if(timer_reset)
        timer <= 0;
      else
        timer <= timer + 1;
      
      present_state <= next_state;
      
    end
  end
  
  always_comb begin
    timer_reset = 0;
    next_state = present_state;

    case(present_state)
      S0: begin
        if(timer == Green_Time || pedestrian_req == 1) begin
          next_state = S1;
          timer_reset = 1;
        end
        else
          next_state = S0;
      end
      S1: begin
        if(timer == Yellow_Time || pedestrian_req == 1) begin
          next_state = S2;
          timer_reset = 1;
        end
        else
          next_state = S1;
      end
      S2: begin
        if(timer == Green_Time || pedestrian_req == 1) begin
          next_state = S3;
          timer_reset = 1;
        end
        else
          next_state = S2;
      end
      S3: begin
        if(timer == Yellow_Time || pedestrian_req == 1) begin
          next_state = S4;
          timer_reset = 1;
        end
        else
          next_state = S3;
      end
      S4: begin
        if(timer == Green_Time || pedestrian_req == 1) begin
          next_state = S5;
          timer_reset = 1;
        end
        else
          next_state = S4;
      end
      S5: begin
        if(timer == Yellow_Time || pedestrian_req == 1) begin
          next_state = S0;
          timer_reset = 1;
        end
        else
          next_state = S5;
      end
      default: next_state = S0;
    endcase
  end
  
  always_comb begin
    
    /*Night Mode: PATH1, PATH2, PATH3, and PATH4 operate in yellow caution mode 
    PATH5 and PATH6 remain red.*/
    
    
    if(night_mode) begin
      PATH1 = Yellow;
      PATH2 = Yellow;
      PATH3 = Yellow;
      PATH4 = Yellow;
      PATH5 = Red;
      PATH6 = Red;
    end
    
    /*Emergency Mode: Priority is granted to Road A traffic.
    PATH1 and PATH6 remain GREEN.
    All conflicting movements remain RED.*/
    
    
    else if(emergency) begin
      PATH1 = Green;
      PATH2 = Red;
      PATH3 = Red;
      PATH4 = Red;
      PATH5 = Red;
      PATH6 = Green;
    end
    
    else begin
      
      case(present_state)
        S0: begin
          PATH1 = Green; // Green = 001
          PATH2 = Green;
          PATH3 = Green;
          PATH4 = Red;   // Red = 100
          PATH5 = Red;
          PATH6 = Red;
        end
        S1: begin
          PATH1 = Green;
          PATH2 = Yellow;
          PATH3 = Yellow; // Yellow = 010
          PATH4 = Red;
          PATH5 = Red;
          PATH6 = Red;
        end
        S2: begin
          PATH1 = Yellow;
          PATH2 = Red;
          PATH3 = Red;
          PATH4 = Green;
          PATH5 = Green;
          PATH6 = Red;
        end
        S3: begin
          PATH1 = Yellow;
          PATH2 = Red;
          PATH3 = Red;
          PATH4 = Green;
          PATH5 = Yellow;
          PATH6 = Red;
        end
        S4: begin
          PATH1 = Red;
          PATH2 = Red;
          PATH3 = Green;
          PATH4 = Green;
          PATH5 = Red;
          PATH6 = Green;
        end
        S5: begin
          PATH1 = Red;
          PATH2 = Red;
          PATH3 = Green;
          PATH4 = Yellow;
          PATH5 = Red;
          PATH6 = Yellow;
        end
        default: begin
          PATH1 = Red;
          PATH2 = Red;
          PATH3 = Red;
          PATH4 = Red;
          PATH5 = Red;
          PATH6 = Red;
        end
      endcase
    end
  end
endmodule

                                                                          
                                                                         