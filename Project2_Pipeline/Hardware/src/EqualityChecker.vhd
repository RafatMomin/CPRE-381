library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EqualityChecker is
    Port ( 
        A : in STD_LOGIC_VECTOR(31 downto 0);
        B : in STD_LOGIC_VECTOR(31 downto 0);
        BNE : in STD_LOGIC;
        Equal : out STD_LOGIC
    );
end EqualityChecker;

architecture Behavioral of EqualityChecker is
    constant ZERO_VECTOR : std_logic_vector(31 downto 0) := (others => '0');
    signal zero_internal : std_logic;
begin
    -- Check if result is zero (meaning A and B are equal)
    -- When comparing A and B directly, if they're equal, their difference is zero
    zero_internal <= '1' when (A = B) else '0';
    
    -- Zero Detection logic for BEQ/BNE
    -- For BEQ: Equal = zero_internal (if A=B, Equal='1')
    -- For BNE: Equal = not zero_internal (if A?B, Equal='1')
    Equal <= not zero_internal when BNE = '1' else zero_internal;
    
end Behavioral;
