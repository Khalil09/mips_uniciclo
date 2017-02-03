-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "02/03/2017 17:42:29"
                                                            
-- Vhdl Test Bench template for design  :  processador
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY processador_tb IS
END processador_tb;
ARCHITECTURE processador_arch OF processador_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL clock : STD_LOGIC;
SIGNAL clock_mem : STD_LOGIC;
COMPONENT processador
	PORT (
	clock : IN STD_LOGIC;
	clock_mem : IN STD_LOGIC
	);
END COMPONENT;

BEGIN
	i1 : processador
	PORT MAP (
-- list connections between master ports and signals
	clock => clock,
	clock_mem => clock_mem
	);
init : PROCESS                                    
-- variable declarations                                     
BEGIN
        -- code that executes only once
wait;
END PROCESS init;
                                           
always : PROCESS

-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
	clock <= '0';
	wait for 1 ns;
	clock <= '1';
	wait for 1 ns;  
	
END PROCESS always;                                          
END processador_arch;
