-- Prepared by Dr. Taek Kwon for the EE4305 lab.
-- A button debounce routine based FSM. 
-- Save this file as "debounce.vhd" in your project source directory.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity debounce is
   port(
      sysclk, reset: in std_logic;
      sw: in std_logic;
      db_level : out std_logic  
   );
end debounce ;


-- Implementation debounce state machine
architecture fsm of debounce is
   constant N: integer:=22;  -- filter of 2^N * 10ns = 40ms
   type state_type is (zero, wait0, one, wait1);
   signal state_reg, state_next: state_type;
   signal q_reg, q_next: unsigned(N-1 downto 0);
begin
   -- FSMD state & data registers
   process(sysclk,reset)
   begin
      if reset='1' then
         state_reg <= zero;
         q_reg <= (others=>'0');
      elsif (sysclk'event and sysclk='1') then
         state_reg <= state_next;
         q_reg <= q_next;
      end if;
   end process;
   -- next-state logic & data path functional units/routing
   process(state_reg,q_reg,sw,q_next)
   begin
      state_next <= state_reg;
      q_next <= q_reg;
      case state_reg is
         when zero =>
            db_level <= '0';
            if (sw='1') then
               state_next <= wait1;
               q_next <= (others=>'1');
            end if;
         when wait1=>
            db_level <= '0';
            if (sw='1') then
               q_next <= q_reg - 1;
               if (q_next=0) then
                  state_next <= one;
               end if;
            else -- sw='0'
               state_next <= zero;
            end if;
         when one =>
            db_level <= '1';
            if (sw='0') then
               state_next <= wait0;
               q_next <= (others=>'1');
            end if;
         when wait0=>
            db_level <= '1';
            if (sw='0') then
               q_next <= q_reg - 1;
               if (q_next=0) then
                  state_next <= zero;
               end if;
            else -- sw='1'
               state_next <= one;
            end if;
      end case;
   end process;
end fsm;
