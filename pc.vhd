library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_pkg.all;

entity pc is
	port(
		din	:	in std_logic_vector(31 downto 0);
		clock	:	in std_logic;
		
		dout	:	out std_logic_vector(31 downto 0)
	);
end pc;

architecture rtl of pc is
	
	begin
	
	proc_pc: process (clock)
	begin
		if rising_edge(clock) then
			dout <= din;
		end if;
	end process;
end architecture rtl;