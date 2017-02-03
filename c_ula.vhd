library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use	work.mips_pkg.all;

entity c_ula is 
	port(
		func		:	in std_logic_vector(5 downto 0);
		opUla		:	in std_logic_vector(1 downto 0);
		
		ctrUla	:	out std_logic_vector(3 downto 0)
	);
end c_ula;

architecture rtl of c_ula is
	signal a4	:	std_logic_vector(3 downto 0);

	begin
		ctrUla <= a4;
	proc_ctrl_ula:	process (func, opUla, a4)

	begin
		if(opUla = "00") then
			a4 <= "0010";
		elsif(opUla = "01") then
			a4 <= "0110";
		else
			case func is
				when "100000"	=> a4 <= ULA_ADD;
				when "100010"	=> a4 <= ULA_SUB;
				when "100100"	=> a4 <= ULA_AND;
				when "100101"	=> a4 <= ULA_OR;
				when "101010"	=> a4 <= ULA_SLT;
				when others 	=> a4	<= ULA_UKW;
			end case;
		end if;
	end process;
end rtl;

