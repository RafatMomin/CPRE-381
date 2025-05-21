library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder_4 is
    Port ( 
        a   : in  STD_LOGIC_VECTOR (31 downto 0);
        sum : out STD_LOGIC_VECTOR (31 downto 0)
    );
end adder_4;

architecture Behavioral of adder_4 is
    constant B : STD_LOGIC_VECTOR(31 downto 0) := X"00000004"; 
begin
    -- Add constant value 4 to input a
    sum <= a + B;
end Behavioral;