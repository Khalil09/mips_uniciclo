library ieee;
use ieee.std_logic_1164.all;
use work.mips_pkg.all;

entity controle is
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
end controle;

architecture behavioral of controle is

	begin

	proc_controle:	process	(op)
		begin
			case op is
				when	"000000" =>	-- Tipo R
					reg_dst 			<= '1';
					orig_alu 		<= '0';
					mem_para_reg 	<= '0';
					escreve_reg		<= '1';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '0';
					op_ula			<= "10";
					
				when	"100011" =>	-- LW
					reg_dst 			<= '0';
					orig_alu 		<= '1';
					mem_para_reg 	<= '1';
					escreve_reg		<= '1';
					le_mem			<= '1';
					escreve_mem		<= '0';
					branch			<= '0';
					op_ula			<= "00";
				
				when	"101011" =>	-- SW
					reg_dst 			<= '1';
					orig_alu 		<= '0';
					mem_para_reg 	<= '0';
					escreve_reg		<= '1';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '0';
					op_ula			<= "10";
				
				when	"000100" => -- Beq
					reg_dst 			<= '0';
					orig_alu 		<= '0';
					mem_para_reg 	<= '0';
					escreve_reg		<= '0';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '1';
					op_ula			<= "01";
					
				when others =>	
					reg_dst 			<= '0';
					orig_alu 		<= '0';
					mem_para_reg 	<= '0';
					escreve_reg		<= '0';
					le_mem			<= '0';
					escreve_mem		<= '0';
					branch			<= '0';
					op_ula			<= "00";
				end case;
	end process;
end behavioral;