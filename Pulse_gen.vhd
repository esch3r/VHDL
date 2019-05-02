library ieee; 
use ieee.numeric_std.all; 
entity pulse_clock is 
port(clk100MHz: in std_logic; 
     pulse: out std_logic); 
 end pulse_clock; 

 Architecture beh of pulse_clock is 
 signal count Ncount: unsigned (19 downto 0); 
 constant limit: unsigned (19 downto 0) := (19=>'1', others =>'0'); 
   begin 
      process(clk100MHz)
        begin
          if (clk100MHz'event & clk100MHz ='1') then 
             count <= Ncount;
          end if; 
       end process; 
     Ncount <= (others =>'0') when (count = limit) else count+1; 
     pulse <= '1' when count = limit else '0';
  end beh;