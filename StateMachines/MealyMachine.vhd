----------------------------------------------------------------------------------
-- Company: University Of Minnesota Duluth
-- Engineer: Johnathan Machler
-- 
-- Create Date: 02/17/2019 11:38:16 PM
-- Design Name: 
-- Module Name: seq_detector - Behavioral
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work; 
use work.all; 


entity seq_detector is
 port ( led: out std_logic_vector (3 downto 0) ; -- display vector 
          x: in std_logic_vector (1 downto 0); 
       clock: in std_logic; 
       btn: in std_logic; 
       reset: in std_logic); 
end seq_detector;

architecture Behavioral of seq_detector is
    signal cleanBtn : std_logic; 
    type statetype is (A, B, C, D); 
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
    when A => if x='11' then 
                   next_state <= B; 
                   led <= '0000'; 
               else 
                  next_state <= A; 
                  led <='0000'; 
               end if; 
   when  B => if x='10' then 
                     next_state <= C; 
                     led <= '0000'; 
                  else 
                     next_state <= A; 
                     led <= '0000'; 
                  end if; 

    when stateC => if x='01' then 
                     next_state <= D; 
                     led <= '1111'; 
                  else 
                     next_state <= A; 
                     led <= '0000'; 
                  end if; 

  when stateD => if x='11' then 
                     next_state <= B; 
                     led <= '0000'; 
                  else 
                     next_state <= A; 
                     led <= '0000'; 
                  end if; 
    end case; 
  end process;  


end Behavioral;
