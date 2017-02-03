transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/mips_pkg.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/memoria_instrucoes.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/Somador.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/ula.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/c_ula.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/breg.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/mux_two_to_one.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/controle.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/pc.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/mux_two_to_one_5.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/memoria_dados.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/bregula.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/fetch.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/mem_final.vhd}
vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/processador.vhd}

vcom -93 -work work {C:/Users/Khalil/Documents/Quartus projetos/Processador_mips/processador_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  processador

add wave *
view structure
view signals
run 200 sec
