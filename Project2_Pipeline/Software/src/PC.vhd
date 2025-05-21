library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC is 
   port( iCLK   : in std_logic;
         iRST   : in std_logic;  -- Reset signal
         i_D    : in std_logic_vector(31 downto 0);
         o_Q    : out std_logic_vector(31 downto 0));
end PC;

architecture behavioral of PC is
begin
  process(iCLK, iRST)
  begin
    if (iRST = '1') then
      o_Q <= x"00400000";  -- Reset to MIPS starting address
    elsif (rising_edge(iCLK)) then
      o_Q <= i_D;
    end if;
  end process;
end behavioral;