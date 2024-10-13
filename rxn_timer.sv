
module rxn_timer(input logic clk, start, stop, rst, output logic rxn_done, output logic [31:0] rxn_time);
    reg [31:0] counter = 32'b0;

    enum logic [3:0] {
        idle  = 4'b000_0,
        count = 4'b001_0,
        done  = 4'b010_1
    } state;

    assign rxn_done = state[0];

    always_ff @(posedge clk) begin
        if (rst) begin
            rxn_time <= 0;
            counter <= 0;
            state <= idle;
        end
        else begin
            case (state)
                idle: begin 
                    if (start) begin
                        state <= count;
                    end
                    else begin
                        state <= idle;
                    end
                end
                count: begin 
                    if (stop) begin
                        state <= done;
                    end
                    else begin
                        counter <= counter + 1;
                    end
                end
                done: begin 
                    rxn_time <= counter;
                    state <= idle;
                end
                default: state <= idle;
            endcase
        end
    end

endmodule