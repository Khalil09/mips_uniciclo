library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_pkg.all;

entity fetch is
	port(
		pc_mais_4	:	in std_logic_vector(31 downto 0);
		reg_dst		: 	in std_logic;
		clock			:	in std_logic;
		clock_mem	:	in std_logic;
		
		opcode		:	out std_logic_vector(5 downto 0);
		r1,r2,r_out	:	out std_logic_vector(4 downto 0);
		pc_out		: 	out std_logic_vector(31 downto 0);
		imed_16		: 	out std_logic_vector(15 downto 0);
		jump_out		:	out std_logic_vector(25 downto 0)
	);
end fetch;

architecture rtl of fetch is

	signal pc_to_mem	:	std_logic_vector(7 downto 0);
	signal pc_out_32	:	std_logic_vector(31 downto 0);
	signal q_out		:	std_logic_vector(31 downto 0);
	signal res_mux		:	std_logic_vector(4 downto 0);
	signal r_tipo_i	:  std_logic_vector(4 downto 0);
	signal r2_aux		:	std_logic_vector(4 downto 0);
	
begin
	
	pc_to_mem	<=	pc_out_32(9 downto 2);
	r1				<=	q_out(25 downto 21);
	r2				<=	q_out(20 downto 16);
	jump_out		<=	q_out(25 downto 0);
	imed_16		<= q_out(15 downto 0);
	r_tipo_i		<= q_out(15 downto 11);
	r2_aux		<= q_out(20 downto 16);
	r_out			<=	res_mux;
	opcode		<= q_out(31 downto 26);
	
pc: entity work.pc port map(
	din		=>	pc_mais_4,
	clock		=> clock,
	dout		=> pc_out_32
);

memoria_intrucoes: entity work.memoria_instrucoes port map(
	address	=>	pc_to_mem,
	clock		=> clock_mem,
	q			=>	q_out
);

mux_two_to_one: entity work.mux_two_to_one_5 port map(
	A			=> r2_aux,
	B			=> r_tipo_i,
	sel		=> reg_dst,
	X			=> res_mux
);
end rtl;