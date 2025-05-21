library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.numeric_std.all;
library std;
use std.env.all;
use std.textio.all;
use work.package_t_bus_32x32.all;

entity tb_mux32t1 is
  generic(
    gCLK_HPER : time := 10 ns  -- Generic for half of the clock cycle period
  );
end tb_mux32t1;

architecture mixed of tb_mux32t1 is

-- Define the total clock period time
constant cCLK_PER : time := gCLK_HPER * 2;

component mux32t1 is
  port(data    : in t_bus_32x32;
       sel     : in std_logic_vector(4 downto 0);
       o_O     : out std_logic_vector(31 downto 0));
end component;

signal data    : t_bus_32x32;
signal sel     : std_logic_vector(4 downto 0);
signal o_O     : std_logic_vector(31 downto 0);

begin

  MUX: mux32t1 port map(
    data  =>  data,
    sel   =>  sel,
    o_O   =>  o_O
  );

P_TEST_CASES: process
  begin
   
    sel     <= "00000";
    data(0) <= "00000000000000000000000000000000";
    data(1) <= "00000000000000000000000000000001";
    data(2) <= "00000000000000000000000000000010";
    data(3) <= "00000000000000000000000000000011";
    data(4) <= "00000000000000000000000000000100";
    data(5) <= "00000000000000000000000000000101";
    data(6) <= "00000000000000000000000000000110";
    wait for gCLK_HPER;
    
    sel    <= "00001";
    wait for gCLK_HPER;

    sel    <= "00010";
    wait for gCLK_HPER;

    sel    <= "00011";
    wait for gCLK_HPER;

    sel    <= "00100";
    wait for gCLK_HPER;
    wait;

  end process;

end mixed;

