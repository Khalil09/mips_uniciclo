library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
use	work.mips_pkg.all;

entity	breg	is
	generic	(	WSIZE	:	natural	:=	32;
	ISIZE	:	natural	:=	5;
	BREGSIZE	:	natural	:=	32	);
	port	
	(
		clk	:	in std_logic;
		we 	:	in std_logic;
		rs 	:	in std_logic_vector(ISIZE-1 downto	0);
		rt 	:	in std_logic_vector(ISIZE-1 downto	0);
		rd 	:	in std_logic_vector(ISIZE-1 downto	0);
		d_in 	:	in		std_logic_vector(WSIZE-1	downto	0);
		regA	:	out	std_logic_vector(WSIZE-1	downto	0);
		regB	:	out	std_logic_vector(WSIZE-1	downto	0)
	);
end	entity;

architecture	rtl	of	breg	is
	constant	 ZERO32	:	std_logic_vector(WSIZE-1 downto 0) := (others => '0');
	type reg_array_t is array(natural range <>) of std_logic_vector(WSIZE-1	downto 0);
	signal breg: reg_array_t(BREGSIZE-1 downto 0) := (others => (others	=>	'0'));
	
	begin
		-- leitura	dos	registradores
		regA	 <=	 ZERO32	 when	 (rs	 =	 "00000")	 else	
		breg(to_integer(unsigned(rs)));
		regB	 <=	 ZERO32	 when	 (rt	 =	 "00000")	 else	
		breg(to_integer(unsigned(rt)));
		-- processo	de	escrita	de	um	registrador	do	banco
	
	process	(clk)
		begin
			if	(rising_edge(clk))	then
				if	(we	=	'1')	then
					breg(to_integer(unsigned(rd)))	<=	d_in;
				end	if;
			end	if;
	end	process;
end	rtl;