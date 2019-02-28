----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2019 02:48:03 PM
-- Design Name: 
-- Module Name: HexC - Behavioral
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
library work;
use work.all; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Addr_element is
 Port( clk: in  std_logic; 
       btn: in  std_logic;
       ascii_data: in std_logic_vector(31 downto 0); --pass four ASCII characters
       hex_data: in std_logic_vector(31 downto 0);--pass a 32-bit binary number
       slide_sw: in std_logic_vector(3 downto 0);
       tx: out std_logic); 
end Addr_element;

architecture Bhv of Addr_element is

signal addr: unsigned(3 downto 0);
signal mem_content: std_logic_vector(31 downto 0); -- 32 bit vector which holds the element of the array

type mem_array is array(0 to 15) of std_logic_vector(31 downto 0);



signal data_mem: mem_array := (X"00001234",
  X"11111234",
  X"22221234",
  X"33331234",
  X"44445678",
  X"55555678",
  X"66665678",
  X"77775678", 
  X"88889abc",
  X"99999abc", 
  X"aaaa9abc", 
  X"bbbb9abc",
  X"ccccdef0",
  X"dddddef0",
  X"eeeedef0",
  X"ffffdef0");
  
  
addr <=  unsigned(slide_sw);--converts inputed slide switch bit vector into an unsigned address number 
unsigned mem_content <= data_mem(to_integer(addr)); --read the element at index, addr

begin

hex_disp: entity work.uart_32bitPrint(Bhv)  -- Sends ascii and hex data from the array into the 32 bit print module
         port map(clk=>clk, btn=>btn_tick ,ascii_data=>ascii , hex_data=>mem_content, tx=>tx);               
-- SW3, SW2, SW1, SW0)=(1,0,0,1) is selected, your implementationshould display the 9thelement of the array with the corresponding labelto the terminal as shown below.
--X"  " notation for hex 
 
end Bhv;
