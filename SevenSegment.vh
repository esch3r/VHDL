----------------------------------------------------------------------------------
-- Company: University of Minnesota Duluth
-- Engineer: Johnathan Machler
-- 
-- Create Date: 01/31/2019 01:02:01 PM
-- Design Name: Even & Odd Alternating seven segment Display
-- Module Name: Lab_2 - Behavioral
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

entity Lab_2 is
  Port (anodes:  out std_logic_vector(7 downto 0); 
        cathodes: out std_logic_vector(6 downto 0); 
        binInput: in std_logic_vector (3 downto 0));
end Lab_2;

architecture Behavioral of Lab_2 is

begin
anodes <= "01010101" when binInput(0) = '0' else  -- alternates between odd and even numbers being displayed on seperate templates
          "10101010";         

cathodes <= "1111001" when binInput = "0001" else  -- Displays "1"
            "0100100" when binInput = "0010" else  -- Displays "2"
            "0110000" when binInput = "0011" else  -- Displays "3"
            "0011001" when binInput = "0100" else  -- Displays "4"
            "0010010" when binInput = "0101" else  -- Displays "5"
            "0000010" when binInput = "0110" else -- Displays "6"
            "1111000" when binInput = "0111" else -- Displays "7"
            "0000000" when binInput = "1000" else  -- Displays "8"
            "0010000" when binInput = "1001" else  -- Displays "9"
            "0001000" when binInput = "1010" else  -- Displays "A"
            "0000011" when binInput = "1011" else  -- Displays "b"
            "1000110" when binInput = "1100" else  -- Displays "C"
            "0100001" when binInput = "1101" else  -- Displays "d" correct this
            "0000110" when binInput = "1110" else  -- Displays "E"
            "0001110" when binInput = "1111" else  -- Displays "F"
            "1000000";  -- displays "0" for else 

end Behavioral;
