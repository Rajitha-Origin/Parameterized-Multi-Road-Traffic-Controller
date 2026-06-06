// Code your testbench here
// or browse Examples
module testbench;
  reg clk, rst, pedestrian_req, emergency, night_mode;
  wire [2:0] PATH1, PATH2, PATH3, PATH4, PATH5, PATH6;
  
  Traffic_Controller dut(clk, rst, pedestrian_req, emergency, night_mode, PATH1, PATH2, PATH3, PATH4, PATH5, PATH6);
  
  always #5 clk = ~clk;
  
  property reset_state;
    @(negedge rst)
    1'b1 |=> (dut.present_state == dut.S0);
  endproperty
  
  property no_conflict;
    @(posedge clk)
    !(PATH2 == 3'b001 && PATH4 == 3'b001) || !(PATH3 == 3'b001 && PATH5 == 3'b001);
  endproperty
  
  property emergency_priority;
    @(posedge clk)
    emergency |-> (PATH1 == 3'b001 && PATH6 == 3'b001 && PATH2 == 3'b100 && PATH3 == 3'b100 && PATH4 == 3'b100 && PATH5 == 3'b100);
  endproperty
  
  property night_mode_check;
    @(posedge clk)
    night_mode |-> (PATH1 == 3'b010 && PATH2 == 3'b010 && PATH3 == 3'b010 && PATH4 == 3'b010 && PATH5 == 3'b100 && PATH6 == 3'b100);
  endproperty
  
  covergroup traffic_cg @(posedge clk);
    state_cp : coverpoint dut.present_state;
    emergency_cp : coverpoint emergency;
    pedestrian_cp : coverpoint pedestrian_req;
    night_cp : coverpoint night_mode;

    cross state_cp, emergency_cp;
    cross state_cp, pedestrian_cp;
    cross state_cp, night_cp;
  endgroup
  
  traffic_cg cg;
  
  cover property(
    @(posedge clk)
    dut.present_state == dut.S0
  );
  cover property(
    @(posedge clk)
    dut.present_state == dut.S1
  );
  cover property(
    @(posedge clk)
    dut.present_state == dut.S2
  );
  cover property(
    @(posedge clk)
    dut.present_state == dut.S3
  );
  cover property(
    @(posedge clk)
    dut.present_state == dut.S4
  );
  cover property(
    @(posedge clk)
    dut.present_state == dut.S5
  );
    
  
  assert property(reset_state);
  assert property(night_mode_check);
  assert property(emergency_priority);
  assert property(no_conflict);
    
  initial begin
    cg = new();
    clk = 0; rst =0; pedestrian_req = 0; emergency = 0; night_mode = 0;
    #10 rst = 1; 
    #50 pedestrian_req = 1; #10 pedestrian_req = 0;
    #50 emergency = 1; #20 emergency = 0;
    #70 night_mode = 1; #20 night_mode = 0;
    #120 $finish();
  end
  
  initial $monitor("clk = %b | rst = %b | pedestrian_req = %b | emergency = %b | night_mode = %b | PATH1 = %b | PATH2 = %b | PATH3 = %b | PATH4 = %b | PATH5 = %b | PATH6 = %b", clk, rst, pedestrian_req, emergency, night_mode, PATH1, PATH2, PATH3, PATH4, PATH5, PATH6);
  
endmodule
