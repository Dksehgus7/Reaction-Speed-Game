module led_controller (input logic led_flag, output logic [9:0] led);
    always_comb begin
        case (led_flag)
        1'b0: led = 10'b0000000000;
        1'b1: led = 10'b1111111111;
        default: led = 10'b0000000000;
        endcase
    end
endmodule