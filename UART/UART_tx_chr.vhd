----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2019 03:05:21 PM
-- Design Name: 
-- Module Name: UART_tx_chr - Behavioral
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

----------------------------------------------------------------------------
--	UART_tx_chr.vhd -- UART Single Byte Transfer Component used for EE4305
----------------------------------------------------------------------------
--	This component serializes a byte of data and transmit it over a UART TXD line. 
-- The serial port should be set up as: 
--         *38400 Baud Rate
--         *8 bit data
--         *1 stop bit
--         *no parity
--         				
-- Port Descriptions:
--    SEND - Used to trigger a send operation. 
--           Setting this signal high for a single clock cycle triggers a 
--           send. When this signal is set high DATA must be valid . Should 
--           not be asserted unless READY is high.
--    DATA - The 8-bit data to be sent to terminal. 
--    CLK  - 100 MHz from Nexys-4 clock.
--   READY - This signal goes low once a send operation has begun and
--           remains low until it has completed and the module is ready to
--           send another byte.
-- UART_TX - This signal should be routed to the TX pin of the 
--           Nexys UART, N18.
--   
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity UART_tx_chr is
    Port ( SEND : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC; -- 100MHz clock
           READY : out  STD_LOGIC;
           UART_TX : out  STD_LOGIC);
end UART_tx_chr;

architecture Beh of UART_tx_chr is

type TX_STATE_TYPE is (RDY, LOAD_BIT, SEND_BIT);

constant BIT_TMR_MAX : unsigned(13 downto 0) := "00101000101100"; --2604 = (round(100MHz / 38400)) - 1
constant BIT_INDEX_MAX : natural := 10;

--Counter that keeps track of the number of clock cycles the current bit has been held stable over the
--UART TX line.
signal bitTmr : unsigned(13 downto 0) := (others => '0');

--combinatorial logic that goes high when bitTmr has counted to the proper value to ensure
--a 38400 baud rate
signal bitDone : std_logic;

--Contains the index of the next bit in txData that needs to be transferred 
signal bitIndex : natural;

--a register that holds the current data being sent over the UART TX line
signal txBit : std_logic := '1';

--A register that contains the whole data packet to be sent, including start and stop bits. 
signal txData : std_logic_vector(9 downto 0);

signal txState : TX_STATE_TYPE := RDY;

begin

--Next state logic
next_txState_process : process (CLK)
begin
	if (rising_edge(CLK)) then
		case txState is 
		when RDY =>
			if (SEND = '1') then
				txState <= LOAD_BIT;
			end if;
		when LOAD_BIT =>
			txState <= SEND_BIT;
		when SEND_BIT =>
			if (bitDone = '1') then
				if (bitIndex = BIT_INDEX_MAX) then
					txState <= RDY;
				else
					txState <= LOAD_BIT;
				end if;
			end if;
		when others=> 
			txState <= RDY;
		end case;
	end if;
end process;

bit_timing_process : process (CLK)
begin
	if (rising_edge(CLK)) then
		if (txState = RDY) then
			bitTmr <= (others => '0');
		else
			if (bitDone = '1') then
				bitTmr <= (others => '0');
			else
				bitTmr <= bitTmr + 1;
			end if;
		end if;
	end if;
end process;

bitDone <= '1' when (bitTmr = BIT_TMR_MAX) else
				'0';

bit_counting_process : process (CLK)
begin
	if (rising_edge(CLK)) then
		if (txState = RDY) then
			bitIndex <= 0;
		elsif (txState = LOAD_BIT) then
			bitIndex <= bitIndex + 1;
		end if;
	end if;
end process;

tx_data_latch_process : process (CLK)
begin
	if (rising_edge(CLK)) then
		if (SEND = '1') then
			txData <= '1' & DATA & '0';
		end if;
	end if;
end process;

tx_bit_process : process (CLK)
begin
	if (rising_edge(CLK)) then
		if (txState = RDY) then
			txBit <= '1';
		elsif (txState = LOAD_BIT) then
			txBit <= txData(bitIndex);
		end if;
	end if;
end process;

UART_TX <= txBit;
READY <= '1' when (txState = RDY) else
			'0';

end Beh;

