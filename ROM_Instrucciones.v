
module ROM_Instrucciones #(
	parameter FILE = "instrucciones.txt"
)(
	input  [3:0]  Dir,
	output [11:0] Instruccion
);

reg [11:0] mem [0:15];

assign Instruccion = mem[Dir];

initial
begin
	$readmemb(FILE, mem);
end

endmodule
