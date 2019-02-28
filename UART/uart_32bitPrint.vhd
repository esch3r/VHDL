----------------------------------------------------------------------------------
-- Company: University of Minnesota - Duluth
-- Engineer: Johnathan Machler
-- 
-- Create Date: 02/26/2019 02:43:51 PM
-- Design Name: UART array fetch elementer
-- Module Name: uart_32bitPrint - Behavioral
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
----------------------------------------------------------------------------------

-- Create Date: 10/4/2018 12:55:49 PM
-- Module Name:    uart_hello
-- Description: A sample code privuded to students to illustrate how to create uart signals 
-- Created by Dr. Taek Kwon for EE4305 Lab 
----------------------------------------------------------------------------------

library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all; 


entity uart_32bitPrint is
   port(
   clk,btn: in std_logic;  -- 100MHz system clock  
   ascii_data: in std_logic_vector(31 downto 0); --pass four ASCII characters
   hex_data: in std_logic_vector(31 downto 0);--pass a 32-bit binary number
   tx: out std_logic  -- UART tx line connected to outside
);
end uart_32bitPrint;

architecture Bhv of uart_32bitPrint is
    signal uartRdy, tx_en: std_logic;
    signal send_data: std_logic_vector(7 downto 0);
    signal btn_tick: std_logic;
	
	type mem_array is array(0 to 15) of std_logic_vector(31 downto 0);
	type state_type is (idle, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15); -- states for controlling  15 elements in an array 
    signal state_reg, state_next: state_type; -- signal that permits the count of 7 characters
	
begin

--Concurrent component that sends a byte of data over the UART Tx line.
Imp_UART_tx_chr: entity work.UART_tx_chr(Beh) port map(
		SEND => tx_en, DATA => send_data, CLK => clk,
		READY => uartRdy, UART_TX => tx );
						
					
-- connect the debounce circuit
btn_debounce: entity work.debounce2(fsmd)
          port map(clk=>clk, sw=>btn, db_level=>open, db_tick=>btn_tick);
  
		
	process(clk, btn_tick)
	begin
	  if clk='1' and clk'event then
	    if btn_tick='1' then
	      state_reg <= s1; -- detection of btn0=1 triggers the state to change from idle to s1
	    else
		   state_reg <= state_next;
		  end if;
	  end if;
	end process;

	--send out e.g. "rXX=11111234"
	process( state_reg, uartRdy)
	begin
		 case state_reg is 
            when idle => 
					  state_next <= idle;
					  tx_en <= '0';
			when s1 =>
                if uartRdy = '1'  then				
				      send_data <= X"72";  -- "r lower case"
					   state_next <= s2;
						tx_en <= '1';
			    else	
					   tx_en <= '0';
						state_next <= s1;
			    end if;
			    
			when s2 =>
				    if uartRdy = '1' then				
				      send_data <= ascii_data ;  -- hex for the ascii e.g. 0
					   state_next <= s3;
						tx_en <= '1';
					 else
						tx_en <= '0';
						state_next <= s2;
					 end if;   
					 
				when s3 => 
				    if uartRdy = '1' then				
				      send_data <= ascii_data ;   -- hex for the ascii e.g  1  
					   state_next <= s4;
						tx_en <= '1';
					 else
						tx_en <= '0';
						state_next <= s3;
					 end if;   
					 
				when s4 => 
				    if uartRdy = '1' then				
				      send_data <= X"3D";   -- "3D is hex for the equals sign in ASCII"
					   state_next <= s5;
						tx_en <= '1';
					 else	
					   tx_en <= '0';
						state_next <= s4;
					 end if;   
					 
				when s5 =>
				    if uartRdy = '1' then				
				      send_data <= ascii_data;   -- 
					   state_next <= s6;
						tx_en <= '1';
					 else	
					   tx_en <= '0';
						state_next <= s5;
					 end if;   		
					 		
				when s6 =>
				    if uartRdy = '1' then				
				      send_data <= ascii_data;
					   state_next <= s7;
						tx_en <= '1';
					 else	
					   tx_en <= '0';
						state_next <= s6;
					 end if;   		
					 	
			  when s7 =>
			     if uartRdy ='1' then 
			        send_data <= ascii_data; 
			        state_next <= s8; 
			        tx_en <='1'; 
			        
			        else	
                      tx_en <= '0';
                      state_next <= s7;
                      end if;           
			        
			   when s8 =>
                  if uartRdy ='1' then 
                     send_data <= ascii_data; 
                     state_next <= s9; 
                     tx_en <='1'; 
			         else	
                       tx_en <= '0';
                       state_next <= s8;
                       end if;           
					 				 
					 
				when s9 =>
				    if uartRdy = '1' then				
				      send_data <= X"0D";   -- CR
					   state_next <= s10;
						tx_en <= '1';
					 else	
					   tx_en <= '0';
						state_next <= s9;
					 end if; 
				when s10 =>
				    if uartRdy = '1' then				
				      send_data <= X"0A";   -- LF
					   state_next <= idle;
						tx_en <= '1';
					 else	
					   tx_en <= '0';
						state_next <= s10;
					 end if;   	
            when others =>
                  tx_en <= '0';				
           end case;	
	end process;

end Bhv;

