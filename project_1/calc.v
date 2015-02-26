`timescale 1ms / 1ps

module calc(button, switch_x, switch_y);
    input [3:0] button, switch_x, switch_y;
    reg [3:0] result;

            case(button)
                4'b0001: result <= switch_x + switch_y;
                4'b0010: result <= switch_x - switch_y;
                4'b0100: result <= switch_y - switch_x;
                4'b1000:
                    case(switch_y % 4)
                        0: result <= switch_x;
                        1: result <= {switch_x[3], switch_x[0], switch_x[1], switch_x[2]};
                        2: result <= {switch_x[2], switch_x[3], switch_x[0], switch_x[1]};
                        3: result <= {switch_x[1], switch_x[2], switch_x[3], switch_x[0]};
                    endcase
            endcase
    
    initial begin
        button = 4'b0001;
        switch_x = 4'b0001;
        switch_y = 4'b0001;
        $didplay("%B", result);
    end
endmodule
