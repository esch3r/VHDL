----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/09/2019 11:27:02 PM
-- Design Name: 
-- Module Name: arb_counter - Behavioral
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

entity arb_counter is
   port ( clk100mhz : in std_logic; -- 100MHz clock provided by the Nexys board 
          reset,sw0,sw1 : in std_logic;
          anode: out std_logic_vector (6 downto 0);
          cathode: out std_logic_vector(6 downto 0)); -- counter output to LEDs
end arb_counter;

architecture Behavioral of arb_counter is
 signal rot_clk : unsigned(3 downto 0); 
 signal sclk,fclk : std_logic;
 
begin
slow_clock_gen: entity work.slow_clock(Behav)
                port map(clk100mhz =>clk100mhz,slow_clk=>sclk);
fast_clock_gen: entity work.fast_clock(Behav)
                port map(clk100mhz =>clk100mhz,fast_clk=>fclk);
  
  
-- sclk is now used for synchronization of arbitary counter
process (sclk, reset)
begin  
       if sw1 = '0' then  -- rot squares
         case rot_clk is 
          when "0000" =>
            anode <= "01111111"; -- Digit Position
            cathode <= "0011100"; -- Top Square
          when "0001" =>
            anode <= "01111111"; -- Digit Position
            cathode <= "0100011";-- Bottom Square
          when "0010" =>
             anode <="10111111"; 
             cathode <="0100011";
          when "0011" =>
             anode <="1101111";
             cathode <="0100011";
          when "0100" =>
             anode <="1110111";
             cathode <="0100011";
          when "0101" =>
             anode <="11110111";
             cathode <="0100011";
          when "0110" =>
             anode <="11111011";
             cathode <="0100011";
           when "0111" =>
             anode <="11111101";
             cathode <="0100011";
           when "1000" =>
             anode <="11111101";
             cathode <="0100011";
           when "1001" =>
             anode <="11111110";
             cathode <="0100011";
           when "1010" =>
             anode <="11111110";
             cathode <="0011100";
           when "1011" =>
              anode <="11111101";
              cathode <="0011100";
           when "1100" =>
                 anode <="11111011";
                 cathode <="0011100";
             
end process;
          
  sclk<= std_logic_vector(ckdiv(27 downto 24)); 
  fclk <= std_logic_vector(ckdiv(19 downto 16));
end Behavioral;
