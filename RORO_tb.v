
`timescale 1ns/1ps

module RORO_tb;

reg  [11:0] instruccion;
wire [31:0] resultado;
wire        ZF;

RORO uut(.instruccion(instruccion), .resultado(resultado), .ZF(ZF));

integer errores = 0, total = 0;

task chequea(input [11:0] ins, input [31:0] esp, input [255:0] nombre);
	begin
		instruccion = ins; #10;
		total = total + 1;
		if (resultado === esp && ZF === (esp == 0))
			$display("PASS %0s | ins=%b | DD=%0d ZF=%b", nombre, ins, resultado, ZF);
		else begin
			$display("FAIL %0s | ins=%b | DD=%0d (esp %0d) ZF=%b (esp %b)", nombre, ins, resultado, esp, ZF, (esp==0));
			errores = errores + 1;
		end
	end
endtask

initial begin
	$dumpfile("RORO_tb.vcd"); $dumpvars(0, RORO_tb);

	chequea({4'd2,4'd0,4'd0}, 32'd17,         "suma  12+5     ");
	chequea({4'd2,4'd6,4'd6}, 32'd0,          "suma  0+0 (ZF) ");
	chequea({4'd6,4'd7,4'd7}, 32'd9,          "resta 15-6     ");
	chequea({4'd6,4'd9,4'd9}, 32'hFFFFFFD7,   "resta 9-50 (neg)");
	chequea({4'd6,4'd11,4'd11}, 32'd0,        "resta 2-2 (ZF) ");
	chequea({4'd7,4'd14,4'd14}, 32'd1,        "SLT   8<16 = 1 ");
	chequea({4'd7,4'd15,4'd15}, 32'd0,        "SLT   20<4 = 0 ");
	chequea({4'd2,4'd3,4'd4},  32'd23,        "suma  ROMa[3]+ROMina[4]");
	chequea({4'd6,4'd4,4'd3},  32'd31,        "resta ROMa[4]-ROMina[3]");
	chequea({4'd7,4'd3,4'd0},  32'd1,         "SLT   ROMa[3]<ROMina[0]");
	chequea({4'd15,4'd0,4'd0}, 32'd0,         "OP invalida    ");

	$display("---- RORO_tb: %0d casos, %0d errores -> %0s", total, errores, errores==0 ? "TODO PASS" : "HAY FAIL");
	$finish;
end

endmodule