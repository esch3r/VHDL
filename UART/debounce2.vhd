----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2019 03:07:57 PM
-- Design Name: 
-- Module Name: debounce2 - Behavioral
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

--------------------------------------------------------------------
-- debounce2.vhd 
-- provided by Dr. Taek Kwon for EE4305 lab 
-- db_level : debounced level signal, i.e., noise removed signal keeping the original shape
-- db_tick : one clock cycle enable pulse asserted at the rising edge of the debounced clock
--------------------------------------------------------------------
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity debounce2 is
   port(
      clk: in std_logic;
      sw: in std_logic;
      db_level, db_tick: out std_logic
   );
end debounce2 ;

architecture fsmd of debounce2 is
   constant N: integer:=21;  -- filter of 2^N * 10ns = 40ms, N=22 
   type state_type is (zero, wait0, one, wait1);
   signal state_reg, state_next: state_type;
   signal q_reg: unsigned(N-1 downto 0) := (others=>'1');
	signal q_next: unsigned(N-1 downto 0) := (others=>'1');
begin
   -- FSMD state & data registers
   process(clk)
   begin
    if (clk'event and clk='1') then
         state_reg <= state_next;
         q_reg <= q_next;
     end if;
   end process;
   -- next-state logic & data path functional units/routing
   process(state_reg,q_reg,sw,q_next)
   begin
      q_next <= q_reg; --default counter state
      case state_reg is
         when zero =>
            db_level <= '0';
				db_tick <= '0';
            if (sw='1') then
               state_next <= wait1;
               q_next <= (others=>'1');
				else
				   state_next <= zero;
            end if;
         when wait1=>
            db_level <= '0';				
            if (sw='1') then
               q_next <= q_reg - 1;
               if (q_next=0) then
                  state_next <= one;
                  db_tick <= '1';
					else
					   state_next <= wait1;
					   db_tick <= '0';
               end if;
            else 
				   db_tick <= '0';
               state_next <= zero;
            end if;
         when one =>
            db_level <= '1';
				db_tick <= '0';
            if (sw='0') then
               state_next <= wait0;
               q_next <= (others=>'1');
				else
					state_next <= one;
            end if;
         when wait0=>
            db_level <= '1';
				db_tick <= '0';
            if (sw='0') then
               q_next <= q_reg - 1;
               if (q_next=0) then
                  state_next <= zero;
					else
					   state_next <= wait0;
               end if;
            else 
               state_next <= one;
            end if;
      end case;
   end process;
end fsmd;
