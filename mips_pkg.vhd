library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
package	mips_pkg	is
	-- Declaracao	de	componentes
	component	ula	is
	generic	(	WSIZE	:	natural	:=	32);
	port	(	
		ulop :	in	std_logic_vector(3	downto	0);
		A,	B :	in	std_logic_vector(WSIZE-1	downto	0);	
		aluout:	out	std_logic_vector(WSIZE-1	downto	0);	
		zero :	out	std_logic	
	);
	end	component;
	
	component	c_ula	is
	port	(
		func	 :	in	std_logic_vector(5	downto	0);
		opUla :	in	std_logic_vector(1	downto	0);
		ctrula	 :	out	std_logic_vector(3	downto	0)
	);
	end	component;
	
	component	breg	is
	generic	(	WSIZE		:	natural	:=	32;
					ISIZE		:	natural	:=	5;
					BREGSIZE	:	natural	:=	32	);
	port	(
		clk 	:	in		std_logic;
		we 	:	in		std_logic;
		rs 	:	in		std_logic_vector(ISIZE-1	downto	0);
		rt 	:	in		std_logic_vector(ISIZE-1	downto	0);
		rd 	:	in		std_logic_vector(ISIZE-1	downto	0);
		d_in 	:	in		std_logic_vector(WSIZE-1	downto	0);
		regA	:	out	std_logic_vector(WSIZE-1	downto	0);
		regB	:	out	std_logic_vector(WSIZE-1	downto	0)
	);
	end component;
	
	component	mux_two_to_one is
	generic	(	WSIZE		: 	natural	:= 32	);
		port(
			sel	:	in std_logic;
			A		:	in std_logic_vector(WSIZE-1 downto 0);
			B		:	in std_logic_vector(WSIZE-1 downto 0);
			X		:	out std_logic_vector(WSIZE-1 downto 0)
		);
	end	component;
	
	component	mux_two_to_one_5 is
	generic	(	WSIZE		: 	natural	:= 5	);
		port(
			sel	:	in std_logic;
			A		:	in std_logic_vector(WSIZE-1 downto 0);
			B		:	in std_logic_vector(WSIZE-1 downto 0);
			X		:	out std_logic_vector(WSIZE-1 downto 0)
		);
	end	component;
	
	component 	pc is
		port(
			din	:	in std_logic_vector(31 downto 0);
			clock	:	in std_logic;
			
			dout	:	out std_logic_vector(31 downto 0)
		);
	end component;
	
	component 	memoria_instrucoes is
		port(
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock			: IN STD_LOGIC  := '1';
			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component memoria_dados is
		PORT
		(
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component somador is
		port(
			a	   : in unsigned  (31 downto 0);
			b	   : in unsigned  (31 downto 0);
			result : out unsigned (31 downto 0)
		);
	end component;
	
	component fetch is
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
	end component;
	
	component bregula is
	
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
	
	end component;
	
	component mem_final is
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
	end component;
	
	component controle is
		port(
			op					:	in std_logic_vector(5 downto 0);
			
			op_ula			:	out std_logic_vector(1 downto 0); -- 2 bits da OpUla
			reg_dst,			-- Se o registrador de escrita rt ou rs
			orig_alu,		-- Se o a segunda entrada na Ula vira do imediato ou nao
			mem_para_reg,	--	O valor que vem da memoria de dados para se escrita no registrador
			escreve_reg,	-- Permite escrever na memoria de registradores
			le_mem,			-- Permite a leitura da memoria
			escreve_mem,	-- Permite a escrita na memoria
			branch,			--	Ligado caso havera uma instrucao de branch
			jump
			:	out std_logic
		);
	end component;
	-- Controle	ULAmips
	constant	ULA_AND :	std_logic_vector(3	downto	0)	:=	"0000";	-- 0
	constant	ULA_OR  :	std_logic_vector(3	downto	0)	:=	"0001";	-- 1
	constant	ULA_ADD :	std_logic_vector(3	downto	0)	:=	"0010";	-- 2
	constant	ULA_SUB :	std_logic_vector(3	downto	0)	:=	"0110";	-- 6
	constant	ULA_SLT :	std_logic_vector(3	downto	0)	:=	"0111";	-- 7
	constant	ULA_NOR :	std_logic_vector(3	downto	0)	:=	"1100";	-- 12
	constant	ULA_UKW :	std_logic_vector(3	downto	0)	:=	"XXXX";
end	mips_pkg;