library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_dffg_N is
  generic(
    gCLK_HPER : time := 10 ns;  -- Generic for half of the clock cycle period
    N : integer := 32           -- Define N at the testbench level
  );
end tb_dffg_N;

architecture mixed of tb_dffg_N is

-- Define the total clock period time
constant cCLK_PER : time := gCLK_HPER * 2;

component dffg_N is 
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

-- Signals
signal i_CLK  : std_logic := '0';
signal i_RST  : std_logic := '0';
signal i_WE   : std_logic := '0';
signal i_D    : std_logic_vector(N-1 downto 0);
signal o_Q    : std_logic_vector(N-1 downto 0);

begin

  DFFG: dffg_N port map(
    i_CLK   => i_CLK,      
    i_RST   => i_RST,
    i_WE    => i_WE,
    i_D     => i_D, 
    o_Q     => o_Q
  );

  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    i_CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    i_CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  P_RST: process
  begin
  	i_RST <= '0';   
    wait for gCLK_HPER;
	i_RST <= '1';
    wait for gCLK_HPER;
	i_RST <= '0';
	wait;
  end process; 

  P_TEST_CASES: process
  begin
   
    i_WE  <= '0';
    i_D   <= "01010101010101010101010101010101";
    wait for gCLK_HPER;
    
    i_WE  <= '0';
    i_D   <= "01010101010101010101010101010101";
    wait for gCLK_HPER;

    i_WE  <= '1';
    i_D   <= "01010101010101010101010101010101";
    wait for gCLK_HPER;

    i_WE  <= '0';
    i_D   <= "10101010101010101010101010101010";
    wait for gCLK_HPER;

    i_WE  <= '0';
    i_D   <= "10101010101010101010101010101010";
    wait for gCLK_HPER;

    i_WE  <= '1';
    i_D   <= "10101010101010101010101010101010";
    wait for gCLK_HPER;

    i_WE  <= '0';
    i_D   <= "01010101010101010101010101010101";
    wait;

  end process;

end mixed;
