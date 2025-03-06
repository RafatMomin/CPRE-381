library IEEE;
use IEEE.std_logic_1164.all;

-- Entity declaration for the 1-bit 2-to-1 multiplexer
entity mux2t1 is
    port(
        i_S  : in std_logic;      -- Selector input
        i_D0 : in std_logic;      -- Data input 0
        i_D1 : in std_logic;      -- Data input 1
        o_O  : out std_logic      -- Output
    );
end mux2t1;

architecture structural of mux2t1 is
    
    signal not_S : std_logic;
    signal and_D0 : std_logic;
    signal and_D1 : std_logic;

    component invg
        port(
            i_A   : in std_logic;
            o_F   : out std_logic
        );
    end component;

    component andg2
        port(
            i_A   : in std_logic;
            i_B   : in std_logic;
            o_F   : out std_logic
        );
    end component;

    component org2
        port(
            i_A   : in std_logic;
            i_B   : in std_logic;
            o_F   : out std_logic
        );
    end component;

begin
    -- Inverter to generate not_S from i_S
    inv1: invg port map (
        i_A => i_S,
        o_F => not_S
    );

    -- AND gate for i_D0 with not_S
    and1: andg2 port map (
        i_A => not_S,
        i_B => i_D0,
        o_F => and_D0
    );

    -- AND gate for i_D1 with i_S
    and2: andg2 port map (
        i_A => i_S,
        i_B => i_D1,
        o_F => and_D1
    );

    -- OR gate to combine the outputs of the two AND gates
    or1: org2 port map (
        i_A => and_D0,
        i_B => and_D1,
        o_F => o_O
    );

end structural;

