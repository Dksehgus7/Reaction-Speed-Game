module game_fsm (input logic clk, rst, start, delay_done, rxn_done, output logic delay_flag, led_flag, rxn_flag);

enum logic [6:0] {
    idle         = 7'b0000_0_0_0,
    wait_delay   = 7'b0001_1_0_0,
    led_on       = 7'b0010_0_1_0,
    display_time = 7'b0100_0_0_1
} state;

assign delay_flag = state[2];
assign led_flag = state[1];
assign rxn_flag = state[0];

always_ff @(posedge clk) begin
    if (rst) begin
        state <= idle;
    end
    else begin
        case(state)
            idle: begin
                if (start) begin
                    state <= wait_delay;
                end
                else begin
                    state <= idle;
                end
            end
            wait_delay: begin
                if (delay_done) begin
                    state <= led_on;
                end
                else begin
                    state <= wait_delay;
                end
            end
            led_on: begin
                if (rxn_done) begin
                    state <= display_time;
                end
                state <= led_on;
            end
            display_time: begin
                state <= display_time;
            end
            default: state <= idle;
        endcase
    end
end
endmodule