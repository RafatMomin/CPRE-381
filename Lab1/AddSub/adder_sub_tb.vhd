library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_AddSub is
end tb_AddSub;

architecture Behavioral of tb_AddSub is
    constant N : integer := 32;
    signal tb_iA, tb_iB, tb_oResult : std_logic_vector(N-1 downto 0);
    signal tb_nAdd_Sub : std_logic;
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
        -- Initialize inputs
        tb_iA <= (others => '0');
        tb_iB <= (others => '0');
        tb_nAdd_Sub <= '0';

        -- Apply test vectors
        tb_iA <= x"00000001";
        tb_iB <= x"00000001";
        tb_nAdd_Sub <= '0';  -- Perform addition
        wait for 20 ns;

        tb_iA <= x"00000005";
        tb_iB <= x"00000003";
        tb_nAdd_Sub <= '1';  -- Perform subtraction
        wait for 20 ns;

        -- More test cases as needed...

        -- End simulation after tests
        wait;  -- Suspend the process indefinitely
    end process;
end Behavioral;

