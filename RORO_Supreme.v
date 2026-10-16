
module RORO_Supreme #(
	parameter FILE_INST = "instrucciones.txt",
	parameter FILE_A    = "ROMa_init.txt",
	parameter FILE_B    = "ROMina_init.txt"
)(
	input  [3:0]  DirInst,
	output [31:0] DD,
	output        ZF
);

wire [11:0] instr;

ROM_Instrucciones #(.FILE(FILE_INST)) RomInst(
	.Dir(DirInst),
	.Instruccion(instr)
);

RORO #(.FILE_A(FILE_A), .FILE_B(FILE_B)) Roro(
	.instruccion(instr),
	.resultado(DD),
	.ZF(ZF)
);

endmodule
