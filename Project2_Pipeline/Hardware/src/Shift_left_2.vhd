library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Shift_Left_2 is
    port (
        input  : in  std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0)
    );
end Shift_Left_2;

architecture behavioral of Shift_Left_2 is
begin
    output <= input(29 downto 0) & "00";
end behavioral;