----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/09/2019 11:09:00 PM
-- Design Name: 
-- Module Name: slow_clock - Behavioral
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

entity slow_clock is
  Port ( clk100mhz : in std_logic; 
        slow_clk: out std_logic); 
end slow_clock;

architecture Behav of slow_clock is
signal ckdiv, ckdiv_next: unsigned(27 downto 0); -- step 2
begin 
process (clk100mhz)
begin
 if rising_edge (clk100mhz) then 
    ckdiv <= ckdiv_next; 
 end if; 
end process; 

ckdiv_next <=ckdiv+1;


-- clock division by assigning bit 28 step 1 of the procedure 
-- to slow_clock i.e. 2^26 *(1/100m) = 0.67 seconds
slow_clk <= std_logic(ckdiv(28));
end Behav;
