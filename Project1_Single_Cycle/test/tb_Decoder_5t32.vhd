library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_Decoder_5t32 is
  generic(
    gCLK_HPER : time := 10 ns;  -- Generic for half of the clock cycle period
    N : integer := 32           -- Define N at the testbench level
  );
end tb_Decoder_5t32;

architecture mixed of tb_Decoder_5t32 is

-- Define the total clock period time
constant cCLK_PER : time := gCLK_HPER * 2;

component Decoder_5t32 is 
  generic(N : integer := 32);
  port(D_IN           : in std_logic_vector(4 downto 0);
       F_OUT          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

signal D_IN   :  std_logic_vector(4 downto 0);
signal F_OUT  :  std_logic_vector(N-1 downto 0);

begin

  D5t32: Decoder_5t32 port map(
    D_IN   =>  D_IN,
    F_OUT  =>  F_OUT
  );

  P_TEST_CASES: process
  begin
   
    D_IN  <= "00000";
    wait for gCLK_HPER/2;
    
    D_IN  <= "00001";
    wait for gCLK_HPER/2;

    D_IN  <= "00010";
    wait for gCLK_HPER/2;

    D_IN  <= "00011";
    wait for gCLK_HPER/2;

    D_IN  <= "00100";
    wait for gCLK_HPER/2;  

    D_IN  <= "00101";
    wait for gCLK_HPER/2;  

    D_IN  <= "00110";
    wait for gCLK_HPER/2;

    D_IN  <= "00111";
    wait for gCLK_HPER/2;

    D_IN  <= "01001";
    wait for gCLK_HPER/2;

    D_IN  <= "01010";
    wait for gCLK_HPER/2;

    D_IN  <= "01011";
    wait for gCLK_HPER/2;

    D_IN  <= "01100";
    wait for gCLK_HPER/2;

    D_IN  <= "01101";
    wait for gCLK_HPER/2;

    D_IN  <= "01110";
    wait for gCLK_HPER/2;

    D_IN  <= "01111";
    wait for gCLK_HPER/2;

    D_IN  <= "10000";
    wait for gCLK_HPER/2;

    D_IN  <= "10001";
    wait for gCLK_HPER/2;

    D_IN  <= "10010";
    wait for gCLK_HPER/2;

    D_IN  <= "10011";
    wait for gCLK_HPER/2;

    D_IN  <= "10100";
    wait for gCLK_HPER/2;

    D_IN  <= "10101";
    wait for gCLK_HPER/2;

    D_IN  <= "10110";
    wait for gCLK_HPER/2;

    D_IN  <= "10111";
    wait for gCLK_HPER/2;

    D_IN  <= "11000";
    wait for gCLK_HPER/2;

    D_IN  <= "11001";
    wait for gCLK_HPER/2;

    D_IN  <= "11010";
    wait for gCLK_HPER/2;

    D_IN  <= "11011";
    wait for gCLK_HPER/2;

    D_IN  <= "11100";
    wait for gCLK_HPER/2;

    D_IN  <= "11101";
    wait for gCLK_HPER/2;

    D_IN  <= "11110";
    wait for gCLK_HPER/2;

    D_IN  <= "11111";
    wait for gCLK_HPER/2;

    wait;

  end process;

end mixed;