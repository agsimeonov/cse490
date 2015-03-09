module calculator(clock, button, switch_x, switch_y, led, cathode, anode);
    input clock;
    input [3:0] button, switch_x, switch_y;
    output [7:0] led, cathode;
    output [3:0] anode;
    reg [7:0] led, cathode;
    reg [3:0] anode;
    reg [5:0] result;
    reg mode;
    integer count;
    
    always @(posedge clock) begin
        if(button[0] ^ button[1] ^ button[2] ^ button[3]) begin
            led[0] <= switch_y[0] == 1 ? 1 : 0;
            led[1] <= switch_y[1] == 1 ? 1 : 0;
            led[2] <= switch_y[2] == 1 ? 1 : 0;
            led[3] <= switch_y[3] == 1 ? 1 : 0;
            led[4] <= switch_x[0] == 1 ? 1 : 0;
            led[5] <= switch_x[1] == 1 ? 1 : 0;
            led[6] <= switch_x[2] == 1 ? 1 : 0;
            led[7] <= switch_x[3] == 1 ? 1 : 0;
            
            case(button)
                4'b0001: 
                    begin
                        mode <= 0;
                        result <= switch_x + switch_y;
                    end
                4'b0010:
                    begin
                        mode <= 0;
                        result <= switch_x - switch_y;
                    end
                4'b0100: 
                    begin
                        mode <= 0;
                        result <= switch_y - switch_x;
                    end
                4'b1000:
                    begin
                        mode <= 1;
                        case(switch_y % 4)
                            0: result <= {0, 0, switch_x};
                            1: result <= {0, 0, switch_x[0], switch_x[3], switch_x[2], switch_x[1]};
                            2: result <= {0, 0, switch_x[1], switch_x[0], switch_x[3], switch_x[2]};
                            3: result <= {0, 0, switch_x[2], switch_x[1], switch_x[0], switch_x[3]};
                        endcase
                    end
            endcase
        end
        
        
        if(count < 16384) begin
            anode <= 4'b1110;
            cathode <= display(mode, 0, result);
        end else if(count < 32768) begin
            anode <= 4'b1101;
            cathode <= display(mode, 1, result);
        end else if(count < 49152) begin
            anode <= 4'b1011;
            cathode <= display(mode, 2, result);
        end else begin
            anode <= 4'b0111;
            cathode <= display(mode, 3, result);
        end
        count = (count + 1) % 65536;
    end
    
    function [7:0] display(input mode, input [1:0] digit, input [5:0] result);
        reg [5:0] new_result;
        reg negative;
        
        begin
            negative = result[5] == 0 ? 0 : 1;
            new_result = negative == 0 ? result : 0 - result;
         
            case(digit)
                0:
                    if(mode == 1) begin
                        display = new_result[0] == 0 ? 8'b00000011 : 8'b10011111;
                    end else if((new_result == 0) || (new_result == 10) || (new_result == 20) || (new_result == 30)) begin
                        display = 8'b00000011;
                    end else if((new_result == 1) || (new_result == 11) || (new_result == 21)) begin
                        display = 8'b10011111;
                    end else if((new_result == 2) || (new_result == 12) || (new_result == 22)) begin
                        display = 8'b00100101;
                    end else if((new_result == 3) || (new_result == 13) || (new_result == 23)) begin
                        display = 8'b00001101;
                    end else if((new_result == 4) || (new_result == 14) || (new_result == 24)) begin
                        display = 8'b10011001;
                    end else if((new_result == 5) || (new_result == 15) || (new_result == 25)) begin
                        display = 8'b01001001;
                    end else if((new_result == 6) || (new_result == 16) || (new_result == 26)) begin
                        display = 8'b01000001;
                    end else if((new_result == 7) || (new_result == 17) || (new_result == 27)) begin
                        display = 8'b00011111;
                    end else if((new_result == 8) || (new_result == 18) || (new_result == 28)) begin
                        display = 8'b00000001;
                    end else begin
                        display = 8'b00001001;
                    end
                1:
                    if(mode == 1) begin
                        display = new_result[1] == 0 ? 8'b00000011 : 8'b10011111;
                    end else if((0 <= new_result) && (new_result <= 9)) begin
                        display = negative == 0 ? 8'b11111111 : 8'b11111101;
                    end else if((10 <= new_result) && (new_result <= 19)) begin
                        display = 8'b10011111;
                    end else if((20 <= new_result) && (new_result <= 29)) begin
                        display = 8'b00100101;
                    end else begin
                        display = 8'b00001101;
                    end
                2:
                    if(mode == 1) begin
                        display = new_result[2] == 0 ? 8'b00000011 : 8'b10011111;
                    end else if(new_result <= 9) begin
                        display = 8'b11111111; 
                    end else begin
                        display = negative == 0 ? 8'b11111111 : 8'b11111101;
                    end
                3:
                    if(mode == 1) begin
                        display = new_result[3] == 0 ? 8'b00000011 : 8'b10011111;
                    end else begin
                        display = 8'b11111111;
                    end
            endcase 
        end
    endfunction
endmodule
