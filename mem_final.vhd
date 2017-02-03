library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_pkg.all;

entity mem_final is
	port(
		address_in		:	in	std_logic_vector(31 downto 0);
		data_to_mux		:	in std_logic_vector(31 downto 0);
		mem_data_write	:	in std_logic_vector(31 downto 0);
		escreve_mem		:	in std_logic;
		le_mem			:	in std_logic;
		mem_para_reg	:	in std_logic;
		clock_mem		: 	in std_logic;
		
		data_wb			:	out std_logic_vector(31 downto 0)
	);
end mem_final;

architecture rtl of mem_final is
	
	signal data_from_mem		:	std_logic_vector(31 downto 0);
	signal res_mux				:	std_logic_vector(31 downto 0);
	signal address_converter:	std_logic_vector(7 downto 0);
	
begin

	address_converter	<=	address_in(9 downto 2);

memoria_dados: entity work.memoria_dados port map(
	address	=> address_converter,
	clock		=> clock_mem,
	data		=>	mem_data_write,
	wren		=>	escreve_mem,
	q			=>	data_from_mem
);

mux_two_to_one: entity work.mux_two_to_one port map(
	A			=> data_from_mem,
	B			=> data_to_mux,
	sel		=> mem_para_reg,
	X			=> res_mux
);

end rtl;