library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mux4to1 is
    generic(N : integer := 32); 
    port (
        in0 : in std_logic_vector(N-1 downto 0);  -- Input 0
        in1 : in std_logic_vector(N-1 downto 0);  -- Input 1
        in2 : in std_logic_vector(N-1 downto 0);  -- Input 2
        in3 : in std_logic_vector(N-1 downto 0);  -- Input 3
        sel : in std_logic_vector(1 downto 0);    -- 2-bit select line
        o   : out std_logic_vector(N-1 downto 0)  -- Output
    );
end Mux4to1;

architecture behavioral of Mux4to1 is
begin
    process(in0, in1, in2, in3, sel)
    begin
        case sel is
            when "00" =>
                o <= in0;
            when "01" =>
                o <= in1;
            when "10" =>
                o <= in2;
            when "11" =>
                o <= in3;
            when others =>
                o <= in0;  -- Default case
        end case;
    end process;
end behavioral;