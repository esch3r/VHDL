----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2019 07:15:43 PM
-- Design Name: 
-- Module Name: Hex2Ascii - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

library work;
use work.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Hex2Ascii is
       port (hex: in std_logic_vector (3 downto 0); 
             ascii: out std_logic_vector (7 downto 0));
end Hex2Ascii;
                                    
architecture Bhv of Hex2Ascii is
            
begin
 Hex2Ascii: entity work.uart_32bitPrint(Bhv) 
           port map (hex_data=>hex,ascii => ascii_data);	


process (hex) 
begin
      if  hex >= "1010" then  -- if hex is 10 or greater than offset so that its in its hex ascii equivalent
           ascii <= std_logic_vector(unsigned(hex)+55); -- offset it to hex for its ascii equivalent 
      else 
           ascii <= std_logic_vector(unsigned(hex)+48); -- offset it to hex for its ascii equivalent
     end if;
end process;

end Bhv;
