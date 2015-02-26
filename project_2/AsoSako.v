module AsoSako(clock, switch, button, anode, cathode, led);
    input clock, switch;
    input [3:0] button;
    output [3:0] anode;
    output [7:0] cathode, led;
    reg [1:0] state;
    reg [3:0] anode, combo_3, combo_2, combo_1, combo_0, try_3, try_2, try_1, try_0, press;
    reg [4:0] hits;
    reg [6:0] pc_3, pc_2, pc_1, pc_0;
    reg [7:0] cathode, led;
    reg [16:0] seven_ctrl;
    reg [22:0] button_ctrl_3, button_ctrl_2, button_ctrl_1, button_ctrl_0;
    reg [23:0] led_ctrl;
    reg [29:0] combo_timer, set_timer, deact_timer;
    
    initial begin
        state <= 0;
        anode <= 1;
        combo_3 <= 0;
        combo_2 <= 0;
        combo_1 <= 0;
        combo_0 <= 0;
        try_3 <= 15;
        try_2 <= 15;
        try_1 <= 15;
        try_0 <= 15;
        press <= 0;
        hits <= 0;
        pc_3 <= 0;
        pc_2 <= 0;
        pc_1 <= 0;
        pc_0 <= 0;
        cathode <= 0;
        led <= 0;
        seven_ctrl <= 0;
        button_ctrl_3 <= 0;
        button_ctrl_2 <= 0;
        button_ctrl_1 <= 0;
        button_ctrl_0 <= 0;
        led_ctrl <= 0;
        combo_timer <= 0;
        set_timer <= 0;
        deact_timer <= 0;
    end
    
    always @(posedge clock) begin
        if(state == 0) begin
            if((button == 0) && (set_timer == 0)) begin
                if(seven_ctrl < 16384) begin
                    anode <= 4'b0111;
                    cathode <= 8'b10000011;
                end else if(seven_ctrl < 32768) begin
                    anode <= 4'b1011;
                    cathode <= 8'b11010101;
                end else if(seven_ctrl < 49152) begin
                    anode <= 4'b1101;
                    cathode <= 8'b11100011;
                end else begin
                    anode <= 4'b1110;
                    cathode <= 8'b01100011;
                end
            end else begin 
                if(seven_ctrl < 16384) begin
                    anode <= 4'b0111;
                    case(combo_3)
                        0: cathode <= 8'b00000011;
                        1: cathode <= 8'b10011111;
                        2: cathode <= 8'b00100101;
                        3: cathode <= 8'b00001101;
                        4: cathode <= 8'b10011001;
                        5: cathode <= 8'b01001001;
                        6: cathode <= 8'b01000001;
                        7: cathode <= 8'b00011111;
                        8: cathode <= 8'b00000001;
                        9: cathode <= 8'b00001001;
                    endcase
                end else if(seven_ctrl < 32768) begin
                    anode <= 4'b1011;
                    case(combo_2)
                        0: cathode <= 8'b00000011;
                        1: cathode <= 8'b10011111;
                        2: cathode <= 8'b00100101;
                        3: cathode <= 8'b00001101;
                        4: cathode <= 8'b10011001;
                        5: cathode <= 8'b01001001;
                        6: cathode <= 8'b01000001;
                        7: cathode <= 8'b00011111;
                        8: cathode <= 8'b00000001;
                        9: cathode <= 8'b00001001;
                    endcase
                end else if(seven_ctrl < 49152) begin
                    anode <= 4'b1101;
                    case(combo_1)
                        0: cathode <= 8'b00000011;
                        1: cathode <= 8'b10011111;
                        2: cathode <= 8'b00100101;
                        3: cathode <= 8'b00001101;
                        4: cathode <= 8'b10011001;
                        5: cathode <= 8'b01001001;
                        6: cathode <= 8'b01000001;
                        7: cathode <= 8'b00011111;
                        8: cathode <= 8'b00000001;
                        9: cathode <= 8'b00001001;
                    endcase
                end else begin
                    anode <= 4'b1110;
                    case(combo_0)
                        0: cathode <= 8'b00000011;
                        1: cathode <= 8'b10011111;
                        2: cathode <= 8'b00100101;
                        3: cathode <= 8'b00001101;
                        4: cathode <= 8'b10011001;
                        5: cathode <= 8'b01001001;
                        6: cathode <= 8'b01000001;
                        7: cathode <= 8'b00011111;
                        8: cathode <= 8'b00000001;
                        9: cathode <= 8'b00001001;
                    endcase
                end
                
                set_timer <= set_timer != 750000000 ? set_timer + 1 : 0;
            end
            
            if(led_ctrl == 0) begin
                if(led == 0) begin
                    led <= 8'b11111111;
                end else begin
                    led <= 8'b00000000;
                end
            end
            led_ctrl <= led_ctrl + 1;
            
            if(button[3]) begin
                if(button_ctrl_3 == 8388607) begin
                    combo_3 <= combo_3 != 9 ? combo_3 + 1 : 0;
                end
                button_ctrl_3 <= button_ctrl_3 + 1;
            end else begin
                button_ctrl_3 <= 0;
            end
            if(button[2]) begin
                if(button_ctrl_2 == 8388607) begin
                    combo_2 <= combo_2 != 9 ? combo_2 + 1 : 0;
                end
                button_ctrl_2 <= button_ctrl_2 + 1;
            end else begin
                button_ctrl_2 <= 0;
            end
            if(button[1]) begin
                if(button_ctrl_1 == 8388607) begin
                    combo_1 <= combo_1 != 9 ? combo_1 + 1 : 0;
                end
                button_ctrl_1 <= button_ctrl_1 + 1;
            end else begin
                button_ctrl_1 <= 0;
            end
            if(button[0]) begin
                if(button_ctrl_0 == 8388607) begin
                    combo_0 <= combo_0 != 9 ? combo_0 + 1 : 0;
                end
                button_ctrl_0 <= button_ctrl_0 + 1;
            end else begin
                button_ctrl_0 <= 0;
            end
            
            combo_timer <= 749990000;
            
            state <= switch;
        end else if(state == 1) begin
            if(((button == 0) && (combo_timer == 0)) || (switch == 0)) begin
                if(seven_ctrl < 16384) begin
                    anode <= 4'b0111;
                    cathode <= 8'b11100011;
                end else if(seven_ctrl < 32768) begin
                    anode <= 4'b1011;
                    cathode <= 8'b00000011;
                end else if(seven_ctrl < 49152) begin
                    anode <= 4'b1101;
                    cathode <= 8'b01100011;
                end else begin
                    anode <= 4'b1110;
                    cathode <= 8'b11111111;
                end
                
                if(switch == 1) begin
                    try_3 <= 15;
                    try_2 <= 15;
                    try_1 <= 15;
                    try_0 <= 15;
                end
            end else begin
                if(seven_ctrl < 16384) begin
                    anode <= 4'b0111;
                    case(try_3)
                        0: cathode <= 8'b00000011;
                        1: cathode <= 8'b10011111;
                        2: cathode <= 8'b00100101;
                        3: cathode <= 8'b00001101;
                        4: cathode <= 8'b10011001;
                        5: cathode <= 8'b01001001;
                        6: cathode <= 8'b01000001;
                        7: cathode <= 8'b00011111;
                        8: cathode <= 8'b00000001;
                        9: cathode <= 8'b00001001;
                        default: cathode <= 8'b11111111;
                    endcase
                end else if(seven_ctrl < 32768) begin
                    anode <= 4'b1011;
                    case(try_2)
                        0: cathode <= 8'b00000011;
                        1: cathode <= 8'b10011111;
                        2: cathode <= 8'b00100101;
                        3: cathode <= 8'b00001101;
                        4: cathode <= 8'b10011001;
                        5: cathode <= 8'b01001001;
                        6: cathode <= 8'b01000001;
                        7: cathode <= 8'b00011111;
                        8: cathode <= 8'b00000001;
                        9: cathode <= 8'b00001001;
                        default: cathode <= 8'b11111111;
                    endcase
                end else if(seven_ctrl < 49152) begin
                    anode <= 4'b1101;
                    case(try_1)
                        0: cathode <= 8'b00000011;
                        1: cathode <= 8'b10011111;
                        2: cathode <= 8'b00100101;
                        3: cathode <= 8'b00001101;
                        4: cathode <= 8'b10011001;
                        5: cathode <= 8'b01001001;
                        6: cathode <= 8'b01000001;
                        7: cathode <= 8'b00011111;
                        8: cathode <= 8'b00000001;
                        9: cathode <= 8'b00001001;
                        default: cathode <= 8'b11111111;
                    endcase
                end else begin
                    anode <= 4'b1110;
                    case(try_0)
                        0: cathode <= 8'b00000011;
                        1: cathode <= 8'b10011111;
                        2: cathode <= 8'b00100101;
                        3: cathode <= 8'b00001101;
                        4: cathode <= 8'b10011001;
                        5: cathode <= 8'b01001001;
                        6: cathode <= 8'b01000001;
                        7: cathode <= 8'b00011111;
                        8: cathode <= 8'b00000001;
                        9: cathode <= 8'b00001001;
                        default: cathode <= 8'b11111111;
                    endcase
                end
                
                combo_timer <= combo_timer != 750000000 ? combo_timer + 1 : 0;
                
                if(combo_timer == 0) begin
                    try_3 <= 15;
                    try_2 <= 15;
                    try_1 <= 15;
                    try_0 <= 15;
                end
            end
            
            if(button[3] && (switch == 1)) begin
                if(button_ctrl_3 == 8388607) begin
                    try_3 <= try_3 != 9 ? try_3 + 1 : 0;
                end
                button_ctrl_3 <= button_ctrl_3 + 1;
            end else begin
                button_ctrl_3 <= 0;
            end
            if(button[2] && (switch == 1)) begin
                if(button_ctrl_2 == 8388607) begin
                    try_2 <= try_2 != 9 ? try_2 + 1 : 0;
                end
                button_ctrl_2 <= button_ctrl_2 + 1;
            end else begin
                button_ctrl_2 <= 0;
            end
            if(button[1] && (switch == 1)) begin
                if(button_ctrl_1 == 8388607) begin
                    try_1 <= try_1 != 9 ? try_1 + 1 : 0;
                end
                button_ctrl_1 <= button_ctrl_1 + 1;
            end else begin
                button_ctrl_1 <= 0;
            end
            if(button[0] && (switch == 1)) begin
                if(button_ctrl_0 == 8388607) begin
                    try_0 <= try_0 != 9 ? try_0 + 1 : 0;
                end
                button_ctrl_0 <= button_ctrl_0 + 1;
            end else begin
                button_ctrl_0 <= 0;
            end
            
            if(button[3]) begin
                pc_3 <= pc_3 + 1;
            end else begin
                pc_3 <= 0;
            end
            if(button[2]) begin
                pc_2 <= pc_2 + 1;
            end else begin
                pc_2 <= 0;
            end
            if(button[1]) begin
                pc_1 <= pc_1 + 1;
            end else begin
                pc_1 <= 0;
            end
            if(button[0]) begin
                pc_0 <= pc_0 + 1;
            end else begin
                pc_0 <= 0;
            end
            
            if(button[3] && (press[3] == 0) && (pc_3 == 127)) begin
                hits <= hits + 1;
                press[3] <= 1;
            end else if(button[3] == 0) begin
                press[3] <= 0;
            end
            if(button[2] && (press[2] == 0) && (pc_2 == 127)) begin
                hits <= hits + 1;
                press[2] <= 1;
            end else if(button[2] == 0) begin
                press[2] <= 0;
            end
            if(button[1] && (press[1] == 0) && (pc_1 == 127)) begin
                hits <= hits + 1;
                press[1] <= 1;
            end else if(button[1] == 0) begin
                press[1] <= 0;
            end
            if(button[0] && (press[0] == 0) && (pc_0 == 127)) begin
                hits <= hits + 1;
                press[0] <= 1;
            end else if(button[0] == 0) begin
                press[0] <= 0;
            end
            
            if(hits == 25) begin
                state <= 2;
                hits <= 0;
            end
            
            led <= 0;
            
            set_timer <= 0;
            
            if((switch == 0) && (combo_3 == try_3) && (combo_2 == try_2) && (combo_1 == try_1) && (combo_0 == try_0)) begin
                state <= 0;
                hits <= 0;
            end else if((switch == 0) && ((combo_3 != try_3) || (combo_2 != try_2) || (combo_1 != try_1) || (combo_0 != try_0))) begin
                combo_timer <= 749990000;
            end
        end else begin
            if(seven_ctrl < 16384) begin
                anode <= 4'b0111;
                cathode <= 8'b00110001;
            end else if(seven_ctrl < 32768) begin
                anode <= 4'b1011;
                cathode <= 8'b00010001;
            end else if(seven_ctrl < 49152) begin
                anode <= 4'b1101;
                cathode <= 8'b10000011;
            end else begin
                anode <= 4'b1110;
                cathode <= 8'b01001001;
            end
            
            if(deact_timer == 500000000) begin
                state <= 1;
            end
            
            combo_timer <= 0;
            
            deact_timer <= deact_timer != 500000000 ? deact_timer + 1 : 0;
        end
        seven_ctrl <= seven_ctrl + 1;
    end
endmodule
