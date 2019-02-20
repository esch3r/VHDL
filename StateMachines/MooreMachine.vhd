----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2019 09:41:36 PM
-- Design Name: 
-- Module Name: MooreMachine - Behavioral
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

entity MooreMachine is 

Port (clock: in std_logic; 
       x: in std_logic_vector (1 downto 0); 
       reset: in std_logic;
       led: out std_logic_vector (3 downto 0)); 

end MooreMachine;

-- Architecture definition for the SimpleFSM entity
Architecture RTL of MooreMachine is
TYPE State_type IS (A, B, C, D);  -- Define the states
	SIGNAL State : State_Type;    -- Create a signal that uses 
							      -- the different states
BEGIN 

  PROCESS (clock, reset) 
  BEGIN 
    If (reset = '1') THEN            -- Upon reset, set the state to A
	State <= A;
 
    ELSIF rising_edge(clock) THEN    -- if there is a rising edge of the
			 -- clock, then do the stuff below
 
	-- The CASE statement checks the value of the State variable,
	-- and based on the value and any other control signals, changes
	-- to a new state.
	CASE State IS
 
		-- If the current state is A and P is set to 1, then the
		-- next state is B
		WHEN A => 
			IF x="11" THEN 
				State <= B; 
			END IF; 
 
		-- If the current state is B and P is set to 1, then the
		-- next state is C
		WHEN B => 
			IF x="10" THEN 
				State <= C; 
			END IF; 
 
		-- If the current state is C and P is set to 1, then the
		-- next state is D
		WHEN C => 
			IF x="01" THEN 
				State <= D; 
			END IF; 
 
		-- If the current state is D and P is set to 1, then the
		-- next state is B.
		-- If the current state is D and P is set to 0, then the
		-- next state is A.
		WHEN D=> 
			IF x="11" THEN 
				State <= B; 
			ELSE 
				State <= D; 
			END IF; 
		WHEN others =>
			State <= A;
	END CASE; 
    END IF; 
  END PROCESS;

-- Decode the current state to create the output
-- if the current state is D, R is 1 otherwise R is 0
led <= "1111" WHEN State=D ELSE "0000";
END RTL;
