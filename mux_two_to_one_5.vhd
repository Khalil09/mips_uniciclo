library ieee;
use ieee.std_logic_1164.all;
use work.mips_pkg.all;

entity mux_two_to_one_5 is

	generic(	WSIZE	:	natural	:= 5);
	port(
		sel	:	in std_logic;
		A		:	in std_logic_vector(WSIZE-1 downto 0);
		B		:	in std_logic_vector(WSIZE-1 downto 0);
		X		:	out std_logic_vector(WSIZE-1 downto 0)
	);
end mux_two_to_one_5;

architecture behavioral of mux_two_to_one_5 is

	begin
	
	proc_mux: process (sel)
	begin
		if	(sel = '0') then
			X	<=	A;
		elsif (sel = '1') then
			X	<= B;
		else
			X 	<= "00000";
		end if;
	end process;
end behavioral;