module rtc(
input clk,
input reset,
output reg [3:0] hr_m, hr_l,
output reg [3:0] min_m, min_l,
output reg [3:0] sec_m, sec_l,
output reg [6:0] seg_hr_m, seg_hr_l,
output reg [6:0] seg_min_m, seg_min_l,
output reg [6:0] seg_sec_m, seg_sec_l
);
always @(posedge clk or posedge reset) begin
if (reset) begin
hr_m <= 0; hr_l <= 0;
min_m <= 0; min_l <= 0;
sec_m <= 0; sec_l <= 0;
end
else begin
if (sec_l == 9) begin
sec_l <= 0;
if (sec_m == 5) begin
sec_m <= 0;
if (min_l == 9) begin
min_l <= 0;
if (min_m == 5) begin
min_m <= 0;
if (hr_l == 9) begin
hr_l <= 0;
if (hr_m == 2) begin
hr_m <= 0;
end
else begin
hr_m <= hr_m + 1;
end
end
else if (hr_m == 2 && hr_l == 3) begin
hr_m <= 0;
hr_l <= 0;
end
else begin
hr_l <= hr_l + 1;
end
end
else begin
min_m <= min_m + 1;
end
end
else begin
min_l <= min_l + 1;
end
end
else begin
sec_m <= sec_m + 1;
end
end
else begin
sec_l <= sec_l + 1;
end
end
end
function [6:0] seven_seg_decode;
input [3:0] digit;
case (digit)
4'b0000: seven_seg_decode = 7'b1111110; // 0
4'b0001: seven_seg_decode = 7'b0110000; // 1
4'b0010: seven_seg_decode = 7'b1101101; // 2
4'b0011: seven_seg_decode = 7'b1111001; // 3
4'b0100: seven_seg_decode = 7'b0110011; // 4
4'b0101: seven_seg_decode = 7'b1011011; // 5
4'b0110: seven_seg_decode = 7'b1011111; // 6
4'b0111: seven_seg_decode = 7'b1110000; // 7
4'b1000: seven_seg_decode = 7'b1111111; // 8
4'b1001: seven_seg_decode = 7'b1111011; // 9
default: seven_seg_decode = 7'b0000000; // blank
endcase
endfunction
always @(*) begin
seg_hr_m = seven_seg_decode(hr_m);
seg_hr_l = seven_seg_decode(hr_l);
seg_min_m = seven_seg_decode(min_m);
seg_min_l = seven_seg_decode(min_l);
seg_sec_m = seven_seg_decode(sec_m);
seg_sec_l = seven_seg_decode(sec_l);
end
endmodule
