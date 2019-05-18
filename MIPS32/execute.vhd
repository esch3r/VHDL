----------------------------------------------------------------------------------
-- Company: University of Minnesota Duluth
-- Engineer: Johnathan M
-- 
-- Create Date: 04/08/2019 12:09:32 PM
-- Design Name: 
-- Module Name: execute - Behavioral
-- Project Name: MIPS32_execute
-- Description: This module takes inputs from the decode module and performs ALU operations.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity execute is
    port(PC_in,register_rs,register_rt: in std_logic_vector(31 downto 0);
         immediate: in std_logic_vector(31 downto 0);
         ALUOp: in std_logic_vector(1 downto 0);
         ALUSrc,beq_control: in std_logic;
         alu_result,branch_addr: out std_logic_vector(31 downto 0);
         branch_decision: out std_logic);
end execute;

architecture Behavioral of execute is

begin


    process(ALUOp,immediate)-- check this
    variable alu_output: signed(31 downto 0);
    variable zero: std_logic:='0';-- bit that indicates alu_result is zero
    variable branch_offset: std_logic_vector(31 downto 0);
    begin
       Case ALUOp is 
            When "00"=>
            -- This is for memory instructions(lw,sw) and computs memory address by (rs+imm)
                alu_output:=signed(register_rs)+signed(immediate);
            
            When "01"=>
            -- This is for a branch instruction and performs a subtraction to determine the zero bit
                alu_output:= signed(register_rs)-signed(register_rt);
            --The zero signal is set according to above subtraction results
                if(alu_output=x"00000000") then
                    zero:='1';
                else
                    zero:='0';
                end if;
            
            When "10"=>
            --This is for r-type instructions The ALU operation is determined by the function field of the instruction
            -- The function field is obtained from the least significant 6 bits of the immediate input
                case immediate(5 downto 0) is
                    when "100000"=> --add
                        alu_output:= signed(register_rs)+signed(register_rt);
                    when "100010"=> --subtract
                        alu_output:= signed(register_rs)-signed(register_rt);
                    when "100100"=> -- AND
                        alu_output:= signed(register_rs)and signed(register_rt);
                    when "100101"=> -- OR
                        alu_output:= signed(register_rs)or signed(register_rt);
                    when "100111"=> --NOR
                        alu_output:= signed(register_rs)nor signed(register_rt);
                    when "101010"=> -- slt
                        if (signed(register_rs)<signed(register_rt)) then
                            alu_output:= x"00000001";
                        else
                            alu_output:= x"00000000";
                        end if;    
                        
                    when others =>
                        alu_output:=x"ffffffff"; -- error indication
                    end case;
                        
            When others=>
                alu_output:=x"ffffffff"; --error indication when ALUOp is unknown
                zero:='0'; -- to avoid fale branching
            end case;
            
    branch_offset:=immediate;    
    branch_addr<=std_logic_vector(signed(PC_in)+signed(branch_offset));
    branch_decision<= (beq_control and zero);
    alu_result<= std_logic_vector(alu_output);
    
  end process; 
end Behavioral;
