library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mux3to1 is
    generic(N : integer := 16); 
    port (
        in0 : in std_logic_vector(N-1 downto 0); -- Input 0
        in1 : in std_logic_vector(N-1 downto 0); -- Input 1
        in2 : in std_logic_vector(N-1 downto 0); -- Input 2
        sel : in std_logic_vector(1 downto 0);  -- 2-bit select line
        o : out std_logic_vector(N-1 downto 0) -- Output
    );
end Mux3to1;

architecture Behavioral of Mux3to1 is
begin
    process (sel, in0, in1, in2)
    begin
        case sel is
            when "00" =>
                o <= in0; -- Output corresponds to input 0
            when "01" =>
                o <= in1; -- Output corresponds to input 1
            when "10" =>
                o <= in2; -- Output corresponds to input 2
            when others =>
                o <= (others => '0'); -- Default case: all zeros
        end case;
    end process;
end Behavioral;