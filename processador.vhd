library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.mips_pkg.all;

entity processador is
	port(
		clock			:	in std_logic;
		clock_mem	:	in std_logic
	);
end processador;

architecture rtl of processador is

	constant shift		: natural := 2;
	
	signal soma_pc								: std_logic_vector(31 downto 0);
	
	signal rs_r1								: std_logic_vector(4 downto 0);
	signal rt_r2								: std_logic_vector(4 downto 0);
	signal r_out_rd							: std_logic_vector(4 downto 0);
	signal imed_16_imed_16					: std_logic_vector(15 downto 0);
	signal reg_dst_reg_dst					: std_logic;
	signal op_code_to_controle				: std_logic_vector(5 downto 0);
	signal pc_out_to_somador				: std_logic_vector(31 downto 0);
	signal jump_out_shift_left				: std_logic_vector(31 downto 0);
	signal pc_mais_4_from_somador			: std_logic_vector(31 downto 0);
	signal jump_out_jump_out				: std_logic_vector(25 downto 0);
	signal jump_jump							: std_logic;
	signal mux_to_pc_mais_4					: std_logic_vector(31 downto 0);
	signal din_data_wb						: std_logic_vector(31 downto 0);
	signal we_escreve_reg					: std_logic;
	signal func_aux							: std_logic_vector(5 downto 0);
	signal op_ula_controle					: std_logic_vector(1 downto 0);
	signal orig_alu_orig_alu				: std_logic;
	signal branch_and_zero					: std_logic;
	signal branch_controle					: std_logic;
	signal zero_ula							: std_logic;
	signal dout_address						: std_logic_vector(31 downto 0);
	signal dout_aux							: std_logic_vector(31 downto 0);
	signal mem_data_write_mem_data_write: std_logic_vector(31 downto 0);
	signal imed_32_aux						: std_logic_vector(31 downto 0);
	signal imed_32_shift_left				: std_logic_vector(31 downto 0);
	signal pc_mais_4_from_beq				: std_logic_vector(31 downto 0);
	signal res_first_mux						: std_logic_vector(31 downto 0);
	signal mem_para_reg_mem_para_reg		: std_logic;
	signal escreve_mem_escreve_mem		: std_logic;
	
	signal part_of_jump 						: std_logic_vector(3 downto 0);
	
	signal imed_32_aux_converter			: signed(31 downto 0);
	signal jump_out_jump_out_converter	: unsigned(31 downto 0);
	signal jump_out_shift_left_aux		: std_logic_vector(31 downto 0);
	
begin
	jump_out_jump_out_converter		<= resize(unsigned(jump_out_jump_out), 32);
	jump_out_shift_left 					<= std_logic_vector(shift_left(jump_out_jump_out_converter, shift));
	
	soma_pc 									<= std_logic_vector(to_unsigned(4, soma_pc'length));
	
	part_of_jump							<= pc_mais_4_from_somador(31 downto 28);
	jump_out_shift_left_aux				<= (part_of_jump & jump_out_shift_left(27 downto 2) & "00");
	
	func_aux									<= imed_16_imed_16(5 downto 0);
	branch_and_zero						<= branch_controle and zero_ula;
	dout_address							<= dout_aux;
	
	imed_32_aux_converter				<= signed(imed_32_aux);
	imed_32_shift_left					<= std_logic_vector(shift_left(imed_32_aux_converter, shift));

bregula:	entity work.bregula port map(
	din				=> din_data_wb,				
	we					=>	we_escreve_reg, 
	clk				=> clock,		
	rs					=> rs_r1, 
	rt					=> rt_r2, 
	rd					=>	r_out_rd,		
	func				=> func_aux,			
	opula				=> op_ula_controle,				
	orig_alu			=> orig_alu_orig_alu,			
	imed_16			=> imed_16_imed_16,			
	
	zero				=> zero_ula,				
	dout				=> dout_aux,				
	imed_32			=> imed_32_aux,			
	mem_data_write	=> mem_data_write_mem_data_write	
);

fetch: entity work.fetch port map(
	pc_mais_4	=> mux_to_pc_mais_4,	
	reg_dst		=> reg_dst_reg_dst,		
	clock			=> clock,			
	clock_mem	=> clock_mem,	
	
	opcode		=> op_code_to_controle,		
	r1				=> rs_r1,
	r2				=> rt_r2,
	r_out			=> r_out_rd,	
	pc_out		=> pc_out_to_somador,	
	imed_16		=> imed_16_imed_16,	
	jump_out		=> jump_out_jump_out

);

mem_final: entity work.mem_final port map(
	address_in			=> dout_address,
	data_to_mux			=>	dout_aux,	
	mem_data_write		=> mem_data_write_mem_data_write,
	escreve_mem			=> escreve_mem_escreve_mem,
	le_mem				=> '1',		
	mem_para_reg		=> mem_para_reg_mem_para_reg,
	clock_mem			=> clock_mem,	
	
	data_wb				=> din_data_wb
);

controle: entity work.controle port map(
	op					=> op_code_to_controle,
	
	op_ula			=> op_ula_controle,			
	reg_dst			=> reg_dst_reg_dst,
	orig_alu			=> orig_alu_orig_alu,
	mem_para_reg   => mem_para_reg_mem_para_reg,
	escreve_reg		=> we_escreve_reg,
	--le_mem,
	escreve_mem		=> escreve_mem_escreve_mem,
	branch			=> branch_controle,
	jump				=> jump_jump
);

somador_pc:	entity work.somador port map(
	a			=> pc_out_to_somador,
	b			=> soma_pc,
	result	=> pc_mais_4_from_somador
);

somador_beq: entity work.somador port map(
	a			=> pc_mais_4_from_somador,
	b			=> imed_32_shift_left,
	result	=> pc_mais_4_from_beq
);

mux_two_to_one_firts: entity work.mux_two_to_one port map(
	sel	=> branch_and_zero,
	A		=> pc_mais_4_from_somador,	
	B		=> pc_mais_4_from_beq,	
	X		=> res_first_mux
);

mux_two_to_one_second: entity work.mux_two_to_one port map(
	sel 	=> jump_jump,
	A	 	=> res_first_mux,	
	B		=>	jump_out_shift_left_aux,	
	X		=> mux_to_pc_mais_4
);

end rtl;