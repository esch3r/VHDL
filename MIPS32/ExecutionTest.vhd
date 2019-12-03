----------------------------------------------------------------------------------
-- Company: UMD
-- Engineer: Johnathan Machler
-- 
-- Create Date: 04/11/2019 01:12:43 PM
-- Design Name: 
-- Module Name: execute_test - Behavioral
-- Project Name: MIPS32_execute
-- Description: This module maps all of the other modules together and outputs the decoded data to the Tera Terminal and SSD.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity execute_test is
    port(reset,clock,clkbtn,cmdbtn: in std_logic;
        slide_sw: in std_logic_vector(2 downto 0);
        SW_code: in std_logic_vector(1 downto 0);
        anodes: out std_logic_vector(7 downto 0);
        cathodes: out std_logic_vector(6 downto 0);
        tx: out std_logic);
             
end execute_test;

architecture Behavioral of execute_test is
signal db_clkbtn,btn_tick: std_logic;
signal RegDst,MemToReg,RegWrite,ALUSrc,beq_control: std_logic;
signal MemRead,MemWrite,jump,branch_decision: std_logic;
signal inst,write_data,read_data: std_logic_vector(31 downto 0); 
signal PC_out, instruction,instdata,alu_result: std_logic_vector(31 downto 0);
signal branch_addr, jump_addr: std_logic_vector(31 downto 0);
signal register_rs,register_rt,register_rd,immediate: std_logic_vector(31 downto 0);
signal ALUOp,db_sw: std_logic_vector(1 downto 0);


begin

--Port maps for inputs
debounceclkbtn: entity work.debounce2(fsmd)
                port map(clk=>clock,sw=>clkbtn,db_level=>db_clkbtn,db_tick=>open);

debouncecmdbtn: entity work.debounce2(fsmd)
                port map(clk=>clock,sw=>cmdbtn,db_level=>open,db_tick=>btn_tick);

debouncesw0:    entity work.debounce2(fsmd)
                port map(clk=>clock,sw=>SW_code(0),db_level=>db_sw(0),db_tick=>open);
debouncesw1:    entity work.debounce2(fsmd)
                port map(clk=>clock,sw=>SW_code(1),db_level=>db_sw(1),db_tick=>open);                                

-- Port maps for the datapath
 control: entity work.control(Behavioral)
                 port map(instruction=>instruction,jump=>jump,RegDst=>RegDst,RegWrite=>RegWrite,
                 MemToReg=>MemToReg,ALUSrc=>ALUSrc,beq_control=>beq_control,ALUOp=>ALUOp,
                 MemRead=>MemRead,MemWrite=>MemWrite);
                           
fetch:  entity work.fetch(Behavioral)
            port map(reset=>reset,clock=>db_clkbtn,branch_addr=>branch_addr,jump_addr=>jump_addr,branch_decision=>branch_decision
                     ,jump_decision=>jump,SW=>db_sw,PC_out=>PC_out,instruction=>instruction);
                     
Decode: entity work.decode(Behavioral)
                port map(instruction=>instruction,memory_data=>read_data,alu_result=>alu_result,RegDst=>RegDst,RegWrite=>RegWrite,
                MemToReg=>MemToReg,reset=>reset,register_rs=>register_rs,register_rt=>register_rt,register_rd=>register_rd,
                jump_addr=>jump_addr,immediate=>immediate,write_data=>write_data,writeClock=>db_clkbtn);
                
execute: entity work.execute(Behavioral)
                  port map(PC_in=>PC_out,register_rs=>register_rs,register_rt=>register_rt,
                  immediate=>immediate,ALUOp=>ALUOp,ALUSrc=>ALUSrc,beq_control=>beq_control,
                  alu_result=>alu_result,branch_addr=>branch_addr,branch_decision=>branch_decision );
                  
memory : entity work.memory(Behavioral)
                  port map(address=>alu_result,write_data=>write_data,MemWrite=>MemWrite, MemRead=>MemRead,read_data=>read_data,wclock=>db_clkbtn);

 
 -- Port maps for the output / display
 
Terminal:  entity work.uart_32bitPrint(Behavioral)
             port map(clk=>clock,btn_tick=>btn_tick,ascii_data=>inst,hex_data=>instdata,tx=>tx);

SSD: entity work.ssd_4digit(Behavioral)
       port map(clk=>clock,hex=>PC_out(15 downto 0),an=>anodes,ca=>cathodes);
                  
                  
MUX: process(slide_sw)
               begin
                   case slide_sw is
                       when "000"=> instdata<=register_rs;
                       inst<= x"7273" & x"20" & x"3d"; 
                       when "001"=> instdata<=register_rt;
                      inst<= x"7274" & x"20" & x"3d";
                       when "010"=> instdata<=register_rd;
                      inst<= x"7264" & x"20" & x"3d";
                       when "011"=> instdata<=immediate;
                      inst<=  x"696d" & x"6d" & x"3d";
                       when "100"=> instdata<=alu_result;
                      inst<= x"616c" & x"75" & x"3d";
                       when "101"=> instdata<=read_data;
                      inst<= x"7265" & x"64" &  x"3d";
                       when "110"=> instdata<=write_data;
                      inst<= x"7772" & x"74" &  x"3d";
                       when others=> instdata<=instdata;
                   end case;
           end process;
