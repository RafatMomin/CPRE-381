library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC is 
   port( iCLK    : in std_logic;
         iRST    : in std_logic;  
         iSTALL  : in std_logic;  -- Stall signal
         i_D     : in std_logic_vector(31 downto 0);
         o_Q     : out std_logic_vector(31 downto 0));
end PC;

architecture behavioral of PC is
  begin
    process(iCLK, iRST)
    begin
      if (iRST = '1') then
        o_Q <= (others => '0');  -- Reset to zeros
      elsif (rising_edge(iCLK)) then
        if (iSTALL = '0') then  -- Only update if not stalled
          o_Q <= i_D;
        end if;
        -- If stalled, maintain the current value (implicit)
      end if;
    end process;
end behavioral;