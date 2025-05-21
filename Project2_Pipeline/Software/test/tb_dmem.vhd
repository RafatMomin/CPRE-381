library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;
use IEEE.numeric_std.all;

entity tb_dmem is
  generic(
    gCLK_HPER : time := 10 ns;  -- Generic for half of the clock cycle period
    DATA_WIDTH : natural := 32;
    ADDR_WIDTH : natural := 10;
    N : integer := 32           -- Define N at the testbench level
  );
end tb_dmem;

architecture mixed of tb_dmem is

-- Define the total clock period time
constant cCLK_PER : time := gCLK_HPER * 2;

component mem is
  generic(DATA_WIDTH : natural := 32; ADDR_WIDTH : natural := 10);
  port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end component;

signal clk : std_logic;
signal addr : std_logic_vector((ADDR_WIDTH-1) downto 0);
signal data : std_logic_vector((DATA_WIDTH-1) downto 0);
signal we : std_logic := '1';
signal q : std_logic_vector((DATA_WIDTH -1) downto 0);

begin

  dmem: mem port map(
    clk => clk,
    addr => addr,
    data => data,
    we => we,
    q => q
  );

  P_CLK: process
  begin
    clk <= '1';         -- clock starts at 1
    wait for gCLK_HPER/2; -- after half a cycle
    clk <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER/2; -- after half a cycle, process begins evaluation again
  end process; 

  P_TEST_CASES: process
  begin

    -- Reading starting from 0x000
    addr <= "0000000000";
    data <= "00000000000000000000000000000000";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0000000001";
    data <= "00000000000000000000000000000000";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0000000010";
    data <= "00000000000000000000000000000000";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0000000011";
    data <= "00000000000000000000000000000000";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0000000100";
    data <= "00000000000000000000000000000000";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0000000101";
    data <= "00000000000000000000000000000000";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0000000110";
    data <= "00000000000000000000000000000000";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0000000111";
    data <= "00000000000000000000000000000000";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0000001000";
    data <= "00000000000000000000000000000000";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0000001001";
    data <= "00000000000000000000000000000000";
    we <= '0';
    wait for gCLK_HPER;


    -- Writing to 0x100
    addr <= "0100000000";
    data <= "11111111111111111111111111111111";
    we <= '1';
    wait for gCLK_HPER;

    addr <= "0100000001";
    data <= "11111111111111111111111111111110";
    we <= '1';
    wait for gCLK_HPER;

    addr <= "0100000010";
    data <= "11111111111111111111111111111101";
    we <= '1';
    wait for gCLK_HPER;

    addr <= "0100000011";
    data <= "11111111111111111111111111111100";
    we <= '1';
    wait for gCLK_HPER;

    addr <= "0100000100";
    data <= "11111111111111111111111111111011";
    we <= '1';
    wait for gCLK_HPER;

    addr <= "0100000101";
    data <= "11111111111111111111111111111010";
    we <= '1';
    wait for gCLK_HPER;

    addr <= "0100000110";
    data <= "11111111111111111111111111111001";
    we <= '1';
    wait for gCLK_HPER;

    addr <= "0100000111";
    data <= "11111111111111111111111111111000";
    we <= '1';
    wait for gCLK_HPER;

    addr <= "0100001000";
    data <= "11111111111111111111111111110111";
    we <= '1';
    wait for gCLK_HPER;

    addr <= "0100001001";
    data <= "11111111111111111111111111110110";
    we <= '1';
    wait for gCLK_HPER;

    -- Reading starting at 0x100
    addr <= "0100000000";
    data <= "11111111111111111111111111111111";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0100000001";
    data <= "11111111111111111111111111111110";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0100000010";
    data <= "11111111111111111111111111111101";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0100000011";
    data <= "11111111111111111111111111111100";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0100000100";
    data <= "11111111111111111111111111111011";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0100000101";
    data <= "11111111111111111111111111111010";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0100000110";
    data <= "11111111111111111111111111111001";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0100000111";
    data <= "11111111111111111111111111111000";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0100001000";
    data <= "11111111111111111111111111110111";
    we <= '0';
    wait for gCLK_HPER;

    addr <= "0100001001";
    data <= "11111111111111111111111111110110";
    we <= '0';
    wait for gCLK_HPER;

    wait;

  end process;

end mixed;

