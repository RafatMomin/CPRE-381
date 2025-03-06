library IEEE;
use IEEE.std_logic_1164.all;

entity N_Bit_Adder is
    Generic (N : integer := 32);
    Port ( A : in std_logic_vector(N-1 downto 0);
           B : in std_logic_vector(N-1 downto 0);
           Cin : in std_logic;
           Sum : out std_logic_vector(N-1 downto 0);
           Cout : out std_logic);
end N_Bit_Adder;

architecture Structural of N_Bit_Adder is
    Component Full_Adder
        Port ( A : in std_logic;
               B : in std_logic;
               Cin : in std_logic;
               Sum : out std_logic;
               Cout : out std_logic);
    End Component;

    Signal carry : std_logic_vector(N downto 0);
begin
    carry(0) <= Cin;
    gen_adders: for i in 0 to N-1 generate
        FA: Full_Adder port map(
            A => A(i),
            B => B(i),
            Cin => carry(i),
            Sum => Sum(i),
            Cout => carry(i+1)
        );
    end generate;

    Cout <= carry(N);
end Structural;
