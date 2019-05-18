----------------------------------------------------------------------------------
-- Company: University of Minnesota Duluth
-- Engineer: Johnathan Machler
-- 
-- Create Date: 04/30/2019 11:59:04 AM
-- Design Name: 
-- Module Name: memory - Behavioral
-- Project Name: MIPS32_execute
-- Description: This module implements the data memory, handling the read and writing to memory.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity memory is
    Port(address: in std_logic_vector(31 downto 0);
         write_data: in std_logic_vector(31 downto 0);
         MemWrite, MemRead: in std_logic;
         read_data: out std_logic_vector(31 downto 0);
         wclock : in std_logic);
end memory;

architecture Behavioral of memory is
    type mem_array is array(0 to 7) of std_logic_vector(31 downto 0);
begin
    ReadWrite1: process
        variable data_mem: mem_array:=(
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000");
            
        variable addr: unsigned(2 downto 0);
        variable mem_content : std_logic_vector(31 downto 0);
        
    begin
    --wait until the halfway of the computer clock cycle for writing rd
    wait until (wclock'event and wclock='0');
        addr:=unsigned(address(2 downto 0)); -- since there are only 8 words
        mem_content:=write_data;
        
        if MemWrite='1' then
            data_mem(to_integer(addr)):=mem_content;
        elsif MemRead='1' then
            mem_content:= data_mem(to_integer(addr));
            read_data<= mem_content;
        end if;
   end process ReadWrite1; 
        
end Behavioral;
