library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_AddSub is
end tb_AddSub;

architecture Behavioral of tb_AddSub is
    constant N : integer := 32;  -- Bit width
    signal tb_iA, tb_iB, tb_oResult : std_logic_vector(N-1 downto 0);
    signal tb_nAdd_Sub : std_logic;  -- '0' for addition, '1' for subtraction
    signal tb_clk : std_logic := '0';  -- Clock signal for clocked operations

begin
    -- Clock process for generating clock signal
    clock_process: process
    begin
        while true loop
            tb_clk <= '0';
            wait for 5 ns;  -- Clock low period
            tb_clk <= '1';
            wait for 5 ns;  -- Clock high period
        end loop;
    end process;

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.AddSub
        generic map (N => N)
        port map (
            iA => tb_iA,
            iB => tb_iB,
            nAdd_Sub => tb_nAdd_Sub,
            oResult => tb_oResult
        );

    -- Test process
    test_process: process
    begin
        -- Test 1: Simple addition
        tb_iA <= "00000000000000000000000000000010"; -- 2
        tb_iB <= "00000000000000000000000000000101"; -- 5
        tb_nAdd_Sub <= '0';  -- Perform addition
        wait for 20 ns;

        -- Test 2: Simple subtraction
        tb_iA <= "00000000000000000000000000001010"; -- 10
        tb_iB <= "00000000000000000000000000000100"; -- 4
        tb_nAdd_Sub <= '1';  -- Perform subtraction
        wait for 20 ns;

        -- Test 3: Overflow addition
        tb_iA <= (others => '1');  -- Max positive value
        tb_iB <= "00000000000000000000000000000001"; -- 1
        tb_nAdd_Sub <= '0';  -- Addition (should cause overflow)
        wait for 20 ns;

        -- Test 4: Zero edge case
        tb_iA <= (others => '0');  -- 0
        tb_iB <= (others => '0');  -- 0
        tb_nAdd_Sub <= '0';  -- Addition of zero
        wait for 20 ns;

        -- Test 5: Subtraction to negative
        tb_iA <= "00000000000000000000000000000010"; -- 2
        tb_iB <= "00000000000000000000000000000110"; -- 6
        tb_nAdd_Sub <= '1';  -- Should result in a negative value
        wait for 20 ns;

        -- End simulation after tests
        assert false report "End of Simulation" severity note;
        wait;
    end process;
end Behavioral;
