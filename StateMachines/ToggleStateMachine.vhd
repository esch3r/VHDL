----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2019 11:38:16 PM
-- Design Name: 
-- Module Name: seq_detector - Behavioral
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
library work; 
use work.all; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seq_detector is
 port ( led0 : out std_logic; -- output sent to LED0 
          x: in std_logic ; 
       clock: in std_logic; 
       btn: in std_logic; 
       reset: in std_logic); 
end seq_detector;

architecture Behavioral of seq_detector is
    signal cleanBtn : std_logic; 
    type statetype is (state0, state1); 
    signal state, next_state : statetype; 
begin
-- debounce a push button 
Debounce_btn : entity work.debounce(fsm) 
          port map(sysclk => clock, reset => '0', sw=>btn, db_level => cleanBtn); 
          
      process 
       begin 
        wait until (cleanBtn'event and cleanBtn='1'); 
        if reset ='1' then  
           state <=statetype'left; 
        else 
          state <= next_state; 
        end if; 
     end process; 
 -- next state preparation 
 process (state, x) 
 begin 
   case state is  
    when state0 => if x='0' then 
                   next_state <= state0; 
                   led0 <= '0'; 
               else 
                  next_state <= state1; 
                  led0 <='1'; 
               end if; 
   when state1 => if x='1' then 
                     next_state <= state1; 
                     led0 <= '0'; 
                  else 
                     next_state <= state0; 
                     led0 <= '1'; 
                  end if; 
  
    end case; 
  end process;  


end Behavioral;
