----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2019 11:02:45 PM
-- Design Name: 
-- Module Name: rot_clk - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rot_clk is
    port (anodes:  out std_logic_vector(7 downto 0); 
          cathodes: out std_logic_vector(6 downto 0) );
end rot_clk;

architecture Behavioral of rot_clk is

begin 
segment_count: process(rot_clk)
  begin
   ifsw1 ='0' then  --rotsquares
      case rot_clk is
          when "0000" =>  
                     anode <= "01111111";--controls which leds to turn on
                     cathode <= "0011100";--controls the display patternwhen .....
          when "1100"=>
                     anode <= "11101111";
                     cathode <= "0100011"; 
          when others =>...end case;
          else  --numbers 
          case rot_clk(3 downto 1)is
          when "000" =>
                    anode <= "01111111";
                    cathode <= "1111001"; --1
          when "001" =>......
          when others =>
                  anode <= "11111110";
                  cathode <= "0000000";--8            
         end case;
     end if;
   end process segment_count;     
end Behavioral;
