module main(

      ///////// ADC /////////
      output             ADC_CONVST,
      output             ADC_DIN,
      input              ADC_DOUT,
      output             ADC_SCLK,

      ///////// AUD /////////
      input              AUD_ADCDAT,
      inout              AUD_ADCLRCK,
      inout              AUD_BCLK,
      output             AUD_DACDAT,
      inout              AUD_DACLRCK,
      output             AUD_XCK,

      ///////// CLOCK2 /////////
      input              CLOCK2_50,

      ///////// CLOCK3 /////////
      input              CLOCK3_50,

      ///////// CLOCK4 /////////
      input              CLOCK4_50,

      ///////// CLOCK /////////
      input              CLOCK_50,

      ///////// DRAM /////////
      output      [12:0] DRAM_ADDR,
      output      [1:0]  DRAM_BA,
      output             DRAM_CAS_N,
      output             DRAM_CKE,
      output             DRAM_CLK,
      output             DRAM_CS_N,
      inout       [15:0] DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_RAS_N,
      output             DRAM_UDQM,
      output             DRAM_WE_N,

      ///////// FAN /////////
      output             FAN_CTRL,

      ///////// FPGA /////////
      output             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,

      ///////// GPIO /////////
      inout     [35:0]         GPIO_0,
      inout     [35:0]         GPIO_1,
 

      ///////// HEX0 /////////
      output      [6:0]  HEX0,
 
      ///////// HEX1 /////////
      output      [6:0]  HEX1,

      ///////// HEX2 /////////
      output      [6:0]  HEX2,

      ///////// HEX3 /////////
      output      [6:0]  HEX3,

      ///////// HEX4 /////////
      output      [6:0]  HEX4,

      ///////// HEX5 /////////
      output      [6:0]  HEX5,

`ifdef ENABLE_HPS
      ///////// HPS /////////
      inout              HPS_CONV_USB_N,
      output      [14:0] HPS_DDR3_ADDR,
      output      [2:0]  HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output      [3:0]  HPS_DDR3_DM,
      inout       [31:0] HPS_DDR3_DQ,
      inout       [3:0]  HPS_DDR3_DQS_N,
      inout       [3:0]  HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_N,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input       [3:0]  HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output      [3:0]  HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout       [3:0]  HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C1_SCLK,
      inout              HPS_I2C1_SDAT,
      inout              HPS_I2C2_SCLK,
      inout              HPS_I2C2_SDAT,
      inout              HPS_I2C_CONTROL,
      inout              HPS_KEY,
      inout              HPS_LED,
      inout              HPS_LTC_GPIO,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout       [3:0]  HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      inout              HPS_SPIM_SS,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout       [7:0]  HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/

      ///////// IRDA /////////
      input              IRDA_RXD,
      output             IRDA_TXD,

      ///////// KEY /////////
      input       [3:0]  KEY,

      ///////// LEDR /////////
      output      [9:0]  LEDR,

      ///////// PS2 /////////
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,

      ///////// SW /////////
      input       [9:0]  SW,

      ///////// TD /////////
      input              TD_CLK27,
      input      [7:0]  TD_DATA,
      input             TD_HS,
      output             TD_RESET_N,
      input             TD_VS,

      ///////// VGA /////////
      output      [7:0]  VGA_B,
      output             VGA_BLANK_N,
      output             VGA_CLK,
      output      [7:0]  VGA_G,
      output             VGA_HS,
      output      [7:0]  VGA_R,
      output             VGA_SYNC_N,
      output             VGA_VS
);

`define ZERO 7'b1000000;
`define ONE 7'b1111001;
`define TWO 7'b0100100;
`define THREE 7'b0110000;
`define FOUR 7'b0011001;
`define FIVE 7'b0010010;
`define SIX 7'b0000010;
`define SEVEN 7'b1111000;
`define EIGHT 7'b0000000;
`define NINE 7'b0011000;

// 1 second clock
logic clock_1s;
clock_divider one_second (.divider(32'd50000000), .base_clock(CLOCK_50), .clock(clock_1s));

// 1 millisecond clock
logic clock_1ms;
clock_divider one_millisecond (.divider(32'd50000), .base_clock(CLOCK_50), .clock(clock_1ms));

// GAME STATE MACHINE
logic delay_flag;
logic led_flag;
logic rxn_flag;
game_fsm rxn_speed_game (.clk(CLOCK_50), .rst(!KEY[3]), .start(!KEY[0]), .delay_done(delay_done), .rxn_done(rxn_done), 
                         .delay_flag(delay_flag), .led_flag(led_flag), .rxn_flag(rxn_flag));

// delay controller -- delay for three seconds
logic delay_done;
delay wait_for_delay (.clk(clock_1s), .rst(!KEY[3]), .delay_flag(delay_flag), .delay_done(delay_done));

// LED controller
led_controller led_control (.led_flag(led_flag), .led(LEDR[9:0]));

// reaction time counter
reg [31:0] reaction_time;
logic rxn_done;
rxn_timer rxn_time (.clk(clock_1ms), .start(led_flag), .stop(!KEY[1]), .rst(!KEY[3]), .rxn_done(rxn_done), .rxn_time(reaction_time));

// do i want these to be 32 bits or is 4 okay?
reg [3:0] ones = 4'b0;
reg [3:0] tens = 4'b0;
reg [3:0] hundreds = 4'b0;
reg [3:0] thousands = 4'b0;
reg [3:0] ten_thousands = 4'b0;
reg [3:0] hundred_thousands = 4'b0;

always_comb begin
    ones = reaction_time % 32'd10;
    tens = (reaction_time/32'd10) % 32'd10; // no (counter - ones)? --> remainder is truncated with integer division
    hundreds = (reaction_time/32'd100) % 32'd10;
    thousands = (reaction_time/32'd1000) % 32'd10;
    ten_thousands = (reaction_time/32'd10000) % 32'd10;
    hundred_thousands = (reaction_time/32'd100000) % 32'd10;
end

hex_decoder zach1 (.hex_code(ones), .hex_number(HEX0));
hex_decoder zach10 (.hex_code(tens), .hex_number(HEX1));
hex_decoder zach100 (.hex_code(hundreds), .hex_number(HEX2));
hex_decoder zach1000 (.hex_code(thousands), .hex_number(HEX3));
hex_decoder zach10000 (.hex_code(ten_thousands), .hex_number(HEX4));
hex_decoder zach100000 (.hex_code(hundred_thousands), .hex_number(HEX5));

endmodule