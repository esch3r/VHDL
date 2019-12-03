----------------------------------------------------------------------------------
-- Company: UMD
-- Engineer: Johnathan Machler
-- 
-- Create Date: 04/08/2019 12:09:48 PM
-- Design Name: 
-- Module Name: control - Behavioral
-- Project Name: MIPS32_execute
-- Description: This module generates the control signals based on the op code of the instruction
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity control is
    port(instruction: in std_logic_vector(31 downto 0);
         jump,RegDst,RegWrite,MemToReg: out std_logic;
         ALUSrc,beq_control: out std_logic;
         ALUOp : out std_logic_vector(1 downto 0);
         MemRead,MemWrite: out std_logic);
end control;

architecture Behavioral of control is

begin
    process(instruction)
        variable opcode: std_logic_vector(5 downto 0);
    begin
        opcode(5 downto 0):= instruction (31 downto 26);
        
         Case opcode is
            when "000000"=>
             RegDst<='1';
             ALUSrc<='0';
             MemToReg<='0';
             RegWrite<='1';
             MemRead<='0';
             MemWrite<='0';
             ALUOp<="10";
             Jump<='0';
             beq_control<='0';
            when "100011"=>
              RegDst<='0';
              ALUSrc<='1';
              MemToReg<='1';
              RegWrite<='1';
              MemRead<='1';
              MemWrite<='0';
              ALUOp<="00";
              Jump<='0';
              beq_control<='0';
            when "101011"=>
             RegDst<='0';
             ALUSrc<='1';
             MemToReg<='0';
             RegWrite<='0';
             MemRead<='0';
             MemWrite<='1';
             ALUOp<="00";
             Jump<='0';
             beq_control<='0';
            when "000100"=>
             RegDst<='0';
             ALUSrc<='0';
             MemToReg<='0';
             RegWrite<='0';
             MemRead<='0';
             MemWrite<='0';
             ALUOp<="01";
             Jump<='0';
             beq_control<='1';
            when "001000"=>
             RegDst<='0';
             ALUSrc<='1';
             MemToReg<='0';
             RegWrite<='1';
             MemRead<='0';
             MemWrite<='0';
             ALUOp<="00";
             Jump<='0';
             beq_control<='0';
            when "000010"=>
             RegDst<='0';
             ALUSrc<='0';
             MemToReg<='0';
             RegWrite<='0';
             MemRead<='0';
             MemWrite<='0';
             ALUOp<="00";
             Jump<='1';
             beq_control<='0';
            when others=>
            
        end case;
