----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2019 09:29:32 PM
-- Design Name: 
-- Module Name: fast_clock_gen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fast_clock_gen is
           Port ( clk100mhz : in std_logic; 
                  fast_clk: out std_logic); 
end fast_clock_gen;

architecture Behav of fast_clock_gen is
signal ckdiv, ckdiv_next: unsigned(27 downto 0); -- step 2

begin
process (clk100mhz)
begin
 if rising_edge (clk100mhz) then 
    ckdiv <= ckdiv_next; 
 end if; 
end process; 

ckdiv_next <=ckdiv+1;

fast_clk <= std_logic(ckdiv(28));
end Behav;
