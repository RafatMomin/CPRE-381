library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_Adder is
end tb_Adder;

architecture sim of tb_Adder is
    constant A_WIDTH : integer := 32;
    constant B_WIDTH : integer := 32;
    constant C_WIDTH : integer := 32;
    
    signal clk : std_logic := '0';
    signal iA : std_logic_vector(A_WIDTH-1 downto 0);
    signal iB : std_logic_vector(B_WIDTH-1 downto 0);
    signal oC : std_logic_vector(C_WIDTH-1 downto 0);

    component Adder
        generic (A_WIDTH : integer := 32;
                 B_WIDTH : integer := 32;
                 C_WIDTH : integer := 32);
        port (iCLK  : in std_logic;
              iA    : in std_logic_vector(A_WIDTH-1 downto 0);
              iB    : in std_logic_vector(B_WIDTH-1 downto 0);
              oC    : out std_logic_vector(C_WIDTH-1 downto 0));
    end component;

begin
    uut: Adder generic map (A_WIDTH, B_WIDTH, C_WIDTH)
                 port map (clk, iA, iB, oC);

    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process
    stimulus: process
    begin
        iA <= (others => '0');
        iB <= (others => '0');
        wait for 20 ns;
        
        iA <= std_logic_vector(to_signed(12345678, A_WIDTH));
        iB <= std_logic_vector(to_signed(-123456, B_WIDTH));
        wait for 20 ns;

        iA <= (others => '1'); -- max negative
        iB <= (others => '1'); -- max negative
        wait;
    end process;

end sim;

