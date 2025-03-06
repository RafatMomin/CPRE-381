library IEEE;
use IEEE.std_logic_1164.all;

entity OnesComplementor is
    generic (N : integer := 32);
    port (
        i_A : in std_logic_vector(N-1 downto 0);
        o_F : out std_logic_vector(N-1 downto 0)
    );
end OnesComplementor;

architecture structural of OnesComplementor is
    component invg
        port (
            i_A : in std_logic;
            o_F : out std_logic
        );
    end component;

    -- Signals for internal connections
    signal s_inverted : std_logic_vector(N-1 downto 0);

begin
    -- Generate loop to connect each bit of input to a NOT gate
    gen_invert: for i in 0 to N-1 generate
        inv_instance : invg port map (
            i_A => i_A(i),
            o_F => s_inverted(i)
        );
    end generate;

    -- Output the inverted signals
    o_F <= s_inverted;
    
end structural;

