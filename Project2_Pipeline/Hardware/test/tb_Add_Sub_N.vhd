library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_Add_Sub_N is
  generic(
    gCLK_HPER : time := 10 ns;  -- Generic for half of the clock cycle period
    N : integer := 32           -- Define N at the testbench level
  );
end tb_Add_Sub_N;

architecture mixed of tb_Add_Sub_N is

-- Define the total clock period time
constant cCLK_PER : time := gCLK_HPER * 2;

-- Component Declaration for Add_Sub_N
component Add_Sub_N is
  generic(N : integer := 32);
  port(
    iCLK    : in std_logic;
    iC      : in std_logic;
    iA      : in std_logic_vector(N-1 downto 0);
    iB      : in std_logic_vector(N-1 downto 0);
    oC      : out std_logic;
    oS      : out std_logic_vector(N-1 downto 0)
  );
end component;

signal iCLK : std_logic := '0';
signal iC   : std_logic := '0';
signal iA, iB, oS : std_logic_vector(N-1 downto 0);
signal oC   : std_logic;

begin

  -- Instantiate
  AS: Add_Sub_N port map(
    iCLK => iCLK,      
    iA   => iA,
    iB   => iB,
    iC   => iC, 
    oC   => oC,
    oS   => oS
  );

  P_TEST_CASES: process
  begin
    iA <= "00000000000000000000000000001010"; -- Binary for 10
    iB <= "00000000000000000000000000011001"; -- Binary for 25
    iC <= '0';
    wait for gCLK_HPER * 2;

    iA <= "00000000000000000000000000101000"; -- Binary for 40
    iB <= "00000000000000000000000000001111"; -- Binary for 15
    iC <= '1';
    wait for gCLK_HPER * 2;

    iA <= "11111111111111111111111111111111"; -- Binary for 0xFFFFFFFF
    iB <= "00000000000000000000000000000000"; -- Binary for 0
    iC <= '0';
    wait for gCLK_HPER * 2;

    iA <= "11111111111111111111111111111111"; -- Binary for 0xFFFFFFFF
    iB <= "00000000000000000000000000000000"; -- Binary for 0
    iC <= '1';
    wait for gCLK_HPER * 2;

    iA <= "11111111111111111111111111111111"; -- Binary for 0xFFFFFFFF
    iB <= "11111111111111111111111111111111"; -- Binary for 0
    iC <= '0';
    wait for gCLK_HPER * 2;

    iA <= "11111111111111111111111111111111"; -- Binary for 0xFFFFFFFF
    iB <= "11111111111111111111111111111111"; -- Binary for 0
    iC <= '1';
    wait;

  end process;

end mixed;
