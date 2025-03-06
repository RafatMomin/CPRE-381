library IEEE;
use IEEE.std_logic_1164.ALL;

entity mux2t1_dataflow_tb is
-- No ports, as this is a testbench
end mux2t1_dataflow_tb;

architecture behavior of mux2t1_dataflow_tb is
    -- Signals to connect to the mux2t1_dataflow entity
    signal i_S  : std_logic := '0';  -- Select signal for mux
    signal i_D0 : std_logic_vector(3 downto 0) := "0000";  -- 4-bit input data 0
    signal i_D1 : std_logic_vector(3 downto 0) := "1111";  -- 4-bit input data 1
    signal o_O  : std_logic_vector(3 downto 0);            -- Output of mux

    -- Instantiate the Unit Under Test (UUT)
    component mux2t1_dataflow
        port(
            i_S  : in  std_logic;
            i_D0 : in  std_logic_vector(3 downto 0);
            i_D1 : in  std_logic_vector(3 downto 0);
            o_O  : out std_logic_vector(3 downto 0)
        );
    end component;

begin
    
    uut: mux2t1_dataflow
        port map (
            i_S  => i_S,
            i_D0 => i_D0,
            i_D1 => i_D1,
            o_O  => o_O
        );

    -- Stimulus process to test the multiplexer
    process
    begin
        -- Test case 1: Select i_D0
        i_S <= '0';
        wait for 10 ns;
        assert (o_O = i_D0) report "Test failed: o_O should equal i_D0 when i_S is '0'" severity error;

        -- Test case 2: Select i_D1
        i_S <= '1';
        wait for 10 ns;
        assert (o_O = i_D1) report "Test failed: o_O should equal i_D1 when i_S is '1'" severity error;

        -- Conclude test
        report "All tests completed successfully" severity note;
        wait;  -- Stop simulation
    end process;
end behavior;

