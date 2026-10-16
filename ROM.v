module ROM #(
	parameter FILE = "initData.txt"
)(
	input  [3:0]  DirL,
	output [31:0] Data
);

reg [31:0] srom [0:63];

assign Data = srom[DirL];

initial
begin
	$readmemb(FILE, srom);
end

endmodule
