library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_32 is
    Port ( 
        a   : in  STD_LOGIC_VECTOR (31 downto 0);
        b   : in  STD_LOGIC_VECTOR (31 downto 0);
        sum : out STD_LOGIC_VECTOR (31 downto 0)
    );
end adder_32;

architecture Behavioral of adder_32 is
  
begin
    
    sum <= std_logic_vector(unsigned(a) + unsigned(b));
    
end Behavioral;