library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AddSub is
    generic (N : integer := 32);
    port (
        iA        : in std_logic_vector(N-1 downto 0);
        iB        : in std_logic_vector(N-1 downto 0);
        nAdd_Sub  : in std_logic;  -- Control bit: '0' for add, '1' for subtract
        oResult   : out std_logic_vector(N-1 downto 0)
    );
end AddSub;


architecture Behavioral of AddSub is
    signal b_negated : std_logic_vector(N-1 downto 0);
    signal b_selected : std_logic_vector(N-1 downto 0);
    signal sum : std_logic_vector(N-1 downto 0);
begin
    -- Inverter implementation
    b_negated <= not iB;  -- Invert each bit of B

    -- Multiplexer implementation
    b_selected <= iB when nAdd_Sub = '0' else b_negated;

    -- Adder implementation
    process(iA, b_selected)
    begin
        sum <= std_logic_vector(signed(iA) + signed(b_selected));
    end process;

    -- Assign the result
    oResult <= sum;
end Behavioral;

