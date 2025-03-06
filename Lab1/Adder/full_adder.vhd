library IEEE;
use IEEE.std_logic_1164.all;

entity Full_Adder is
    Port (
        A    : in  std_logic;
        B    : in  std_logic;
        Cin  : in  std_logic;
        Sum  : out std_logic;
        Cout : out std_logic
    );
end Full_Adder;

architecture Structural of Full_Adder is
    signal A_xor_B : std_logic;
    signal A_and_B, B_and_Cin, A_and_Cin : std_logic;

    component xor2
        port (
            i_A   : in std_logic;
            i_B   : in std_logic;
            o_F   : out std_logic
        );
    end component;

    component and2
        port (
            i_A   : in std_logic;
            i_B   : in std_logic;
            o_F   : out std_logic
        );
    end component;

    component or3
        port (
            i_A   : in std_logic;
            i_B   : in std_logic;
            i_C   : in std_logic;
            o_F   : out std_logic
        );
    end component;

begin
    -- XOR gates for Sum calculation
    xor1: xor2 port map (A, B, A_xor_B);
    xor2: xor2 port map (A_xor_B, Cin, Sum);

    -- AND gates for Carry-out calculation
    and1: and2 port map (A, B, A_and_B);
    and2: and2 port map (B, Cin, B_and_Cin);
    and3: and2 port map (A, Cin, A_and_Cin);

    -- OR gate to combine the outputs of the AND gates
    or1: or3 port map (A_and_B, B_and_Cin, A_and_Cin, Cout);
end Structural;
