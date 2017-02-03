library	ieee;
use	ieee.std_logic_1164.all;	
use	ieee.numeric_std.all;
use	work.mips_pkg.all;

entity	ula	is
generic	(	WSIZE	:	natural	:=	32);
port	(	
	ulop :	in	std_logic_vector(3	downto	0);
	A,	B :	in	std_logic_vector(WSIZE-1	downto	0);	
	aluout:	out	std_logic_vector(WSIZE-1	downto	0);	
	zero :	out	std_logic	
);
end	ula;
architecture	behavioral	of	ula	is
	signal	tmp		:	std_logic_vector(WSIZE-1	downto	0);	
	signal	a32		:	std_logic_vector(WSIZE-1	downto	0);
	constant	C_ZERO	:	std_logic_vector(WSIZE-1	downto	0)	:=	(others	=>	'0');

begin
	tmp	<=	std_logic_vector(signed(A)	- signed(B));
	aluout	<=	a32;	
proc_ula:	process	(A,	B,	ulop,	a32,	tmp)

	begin
		if	(a32	=	C_ZERO)
			then	zero	<=	'1';
			else	zero	<=	'0';	
		end	if;	
		case	ulop	is
			when	ULA_AND 	=>	a32	<=	A	and	B;
			when	ULA_OR 	=>	a32	<=	A	or	B;
			when	ULA_ADD	=>	a32	<=	std_logic_vector(signed(A)	 +	 signed(B));
			when	ULA_SUB	=>	a32	<=	tmp;
			when	ULA_SLT	=>	a32	<=	(0	=>	tmp(31),	others	=>	'0');	
			when	ULA_NOR	=>	a32	<=	A	nor	B;
			when	others	=>	a32	<=	(others	=>	'X');	
		end	case;
	end	process;
end	architecture	behavioral;