// 3 second delay before turning on LEDs
module delay (input logic clk, delay_flag, rst, output logic delay_done);
    reg [31:0] counter = 0;
    enum logic [3:0] {
        idle  = 4'b000_0,
        count = 4'b001_0,
        done  = 4'b010_1
    } state;
    
    assign delay_done = state[0];

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= idle;
            counter <= 0;
        end
        else begin
            case(state)
            idle:begin 
                if(delay_flag) begin
                    state <= count;
                end
                else begin
                    state <= idle;
                end
            end
            count: begin 
                if(counter <= 32'd3) begin
                    counter <= counter + 1;
                end
                else begin
                    state <= done;
                end
            end
            done: begin
                if (!delay_flag) begin
                    state <= idle;
                    counter <= 0;
                end
                else begin
                    state <= done;
                end
            end
            default: state <= idle;
            endcase
        end
    end
endmodule