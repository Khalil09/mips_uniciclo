library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use	work.mips_pkg.all;

entity bregula is
	
	port (
		din				:	in std_logic_vector(31 downto 0);
		we, clk			:	in std_logic;
		rs, rt, rd		:	in std_logic_vector(4 downto 0);
		func				: 	in std_logic_vector(5 downto 0);
		opula				:	in std_logic_vector(1 downto 0);
		orig_alu			:	in std_logic;
		imed_16			:	in std_logic_vector(15 downto 0);
		
		zero				:	out std_logic;
		dout				:	out std_logic_vector(31 downto 0);
		imed_32			:	out std_logic_vector(31 downto 0);
		mem_data_write	:	out std_logic_vector(31 downto 0)
	);
	
end bregula;

architecture rtl of bregula is

signal r1, r2			:	std_logic_vector(31 downto 0);
signal ctrula			:	std_logic_vector(3 downto 0);
signal imed_32_aux	:	std_logic_vector(31 downto 0);
signal res_mux			:	std_logic_vector(31 downto 0);

begin

	imed_32_aux		<=	std_logic_vector(resize(signed(imed_16), imed_32_aux'length));
	imed_32 			<= imed_32_aux;
	mem_data_write	<= r2;

ula: entity work.ula port map(
	ulop		=>	ctrula,
	A			=> r1,
	B			=> res_mux,
	aluout	=>	dout,
	zero		=> zero
);

breg: entity work.breg port map(
	clk		=> clk,
	we			=> we,
	rs			=> rs,
	rt			=> rt,
	rd 		=> rd,
	d_in 		=> din,
	regA 		=> r1,
	regB		=> r2
);

c_ula: entity work.c_ula port map(
	func		=> func,
	opUla 	=> opula,
	ctrUla	=> ctrula
);

mux_two_to_one: entity work.mux_two_to_one port map(
	A			=> r2,
	B			=> imed_32_aux,
	sel		=> orig_alu,
	X			=> res_mux
);

end rtl;