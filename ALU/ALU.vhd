----------------------------------------------------------------------------------
-- Company: University Of Minnnesota Duluth
-- Engineer: Johnathan Machler
-- 
-- Create Date: 02/07/2019 11:58:46 AM
-- Design Name:ALU using multiplexer with modules
-- Module Name: ALU - Behav
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This ALU is built with other modules 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Remember you have to list the ports in the order that you see them from top to bottom
Library IEEE; 
use IEEE.std_logic_1164.all;
library mylib; 
use mylib.all;  -- Grabs the instatiated instances for the other entities 


entity ALU is 
Port 
(
         sel: in std_logic_vector (1 downto 0); -- mux selector 
         x,y : in  std_logic_vector( 3 downto 0); -- Needs to be type unsigned 
         result: out std_logic_vector ( 3 downto 0); -- result
         c_out: out std_logic); 

end entity ALU; 

architecture Behav of ALU is 
     signal F,G,H,I,A,B,C,D: std_logic_vector (3 downto 0); -- Intermediate Signal lines which cannot be declared above
begin 

ORGATE: entity mylib.OR_gate(rtl)
    port map(in1=>x, in2=>y,A=>A); -- mapping the output ports of each 

ANDGATE: entity mylib.AND_gate(rtl)
     port map(in1=>x,in2=>y,B=>B); -- 

NORGATE:entity mylib.NOR_gate(rtl)
     port map(in1=>x,in2=>y,C=>C);

ADDER:entity mylib.Adder(Behav)
      port map(x=>x,y=>y,sum=>D,c_out=> c_out); 
     
MUX1: entity mylib.mux4(Behav) 
      port map(A=>A, B=>B, C=>C,D=>D, result=>result, sel=>sel);  --    Port ( A,B,C,D: in std_logic_vector (3 downto 0 );
     --  result:  out std_logic_vector (3 downto 0);
       ---sel: in std_logic_vector (1 downto 0)); 

end Behav;
