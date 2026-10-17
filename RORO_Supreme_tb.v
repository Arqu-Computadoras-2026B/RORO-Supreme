`timescale 1ns/1ps
// Recorre las 16 instrucciones y compara DD y ZF contra la tabla de la actividad.
module RORO_Supreme_tb;

reg  [3:0]  DirInst;
wire [31:0] DD;
wire        ZF;

RORO_Supreme uut(.DirInst(DirInst), .DD(DD), .ZF(ZF));

reg [31:0] esperado [0:15];
integer i, errores = 0;

initial begin
	esperado[0]=17;  esperado[1]=21;  esperado[2]=35;  esperado[3]=12;
	esperado[4]=60;  esperado[5]=48;  esperado[6]=0;   esperado[7]=9;
	esperado[8]=51;  esperado[9]=32'd4294967255; esperado[10]=97; esperado[11]=0;
	esperado[12]=0;  esperado[13]=0;  esperado[14]=1;  esperado[15]=0;

	$dumpfile("RORO_Supreme_tb.vcd"); $dumpvars(0, RORO_Supreme_tb);

	for (i = 0; i < 16; i = i + 1) begin
		DirInst = i[3:0]; #10;
		if (DD === esperado[i] && ZF === (esperado[i] == 0))
			$display("PASS dir=%2d | OP=%0d | DD=%0d (0x%h) | ZF=%b", i, uut.instr[11:8], DD, DD, ZF);
		else begin
			$display("FAIL dir=%2d | OP=%0d | DD=%0d (esp %0d) | ZF=%b (esp %b)", i, uut.instr[11:8], DD, esperado[i], ZF, (esperado[i]==0));
			errores = errores + 1;
		end
	end

	$display("---- RORO_Supreme_tb: 16 casos, %0d errores -> %0s", errores, errores==0 ? "TODO PASS" : "HAY FAIL");
	$finish;
end

endmodule
