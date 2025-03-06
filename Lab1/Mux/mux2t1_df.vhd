library IEEE;
use IEEE.std_logic_1164.all;

-- Entity declaration for the 2-to-1 multiplexer using dataflow modeling
entity mux2t1_dataflow is
    port(
        i_S  : in std_logic;      -- Selector input
        i_D0 : in std_logic_vector(3 downto 0);  -- Data input 0
        i_D1 : in std_logic_vector(3 downto 0);  -- Data input 1
        o_O  : out std_logic_vector(3 downto 0)  -- Output
    );
end mux2t1_dataflow;

architecture dataflow of mux2t1_dataflow is
begin
    -- Multiplexer logic using conditional signal assignment
    o_O <= i_D0 when i_S = '0' else
           i_D1;
end dataflow;

