library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;
use work.package_t_bus_32x32.all;
use IEEE.numeric_std.all;

entity tb_Register_File is
  generic(
    gCLK_HPER : time := 10 ns;  -- Generic for half of the clock cycle period
    N : integer := 32           -- Define N at the testbench level
  );
end tb_Register_File;

architecture mixed of tb_Register_File is

-- Define the total clock period time
constant cCLK_PER : time := gCLK_HPER * 2;

component Register_File is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(iCLK             : in std_logic;
       rs               : in std_logic_vector(4 downto 0);
       rt               : in std_logic_vector(4 downto 0);
       rd               : in std_logic_vector(4 downto 0);
       wData            : in std_logic_vector(N-1 downto 0);
       wReg             : in std_logic;
       iRST             : in std_logic;
       oR_1             : out std_logic_vector(N-1 downto 0);
       oR_2             : out std_logic_vector(N-1 downto 0));
end component;

signal iCLK           : std_logic;
signal rs             : std_logic_vector(4 downto 0);
signal rt               : std_logic_vector(4 downto 0);
signal rd               : std_logic_vector(4 downto 0);
signal wData            : std_logic_vector(N-1 downto 0);
signal wReg             : std_logic;
signal iRST             : std_logic;
signal oR_1             : std_logic_vector(N-1 downto 0);
signal oR_2             : std_logic_vector(N-1 downto 0);

begin

  RF: Register_File port map(
    iCLK  => iCLK,
    rs => rs,
    rt => rt,
    rd => rd,
    wData => wData,
    wReg => wReg,
    iRST => iRST,
    oR_1 => oR_1,
    oR_2 => oR_2
  );

  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    iCLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER/2; -- after half a cycle
    iCLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER/2; -- after half a cycle, process begins evaluation again
  end process; 

  P_TEST_CASES: process
  begin

    iRST  <= '1';
    wReg  <= '0';
    wait for gCLK_HPER/2;
    iRST  <= '0';
    wait for gCLK_HPER/2;
    
    --Testing Writing to register $0
    rs  <= "00000";
    rt  <= "00000";
    rd  <= "00000";
    wData  <= "00000000000000001111111111111111";
    wReg <= '0';
    iRST  <= '0';
    wait for gCLK_HPER;
  
    rs  <= "00000";
    rt  <= "00000";
    rd  <= "00000";
    wData  <= "00000000000000001111111111111111";
    wReg <= '1';
    iRST  <= '0';
    wait for gCLK_HPER;

-- Loop to write values to registers 1 to 31
    for i in 1 to 31 loop
      rs  <= std_logic_vector(to_unsigned(i-1, 5)); -- Previous register for rs
      rt  <= std_logic_vector(to_unsigned(i, 5));   -- Current register for rt
      rd  <= std_logic_vector(to_unsigned(i, 5));   -- Target register rd
      wData  <= std_logic_vector(to_unsigned(i, 32)); -- Data value equals register index
      wReg <= '1'; -- Enable writing
      wait for cCLK_PER;
    end loop;

    rs  <= "00000";
    rt  <= "00000";
    rd  <= "00001";
    wData  <= "00000000000000001111111111111111";
    wReg <= '0';
    iRST  <= '0';
    wait for gCLK_HPER;

    -- Testing Reset
    rs  <= "00000";
    rt  <= "00000";
    rd  <= "00001";
    wData  <= "00000000000000001111111111111111";
    wReg <= '0';
    iRST  <= '1';
    wait for gCLK_HPER;

    rs  <= "00000";
    rt  <= "00001";
    rd  <= "00001";
    wData  <= "00000000000000001111111111111111";
    wReg <= '0';
    iRST  <= '0';
    wait for gCLK_HPER;

    wait;

  end process;

end mixed;


    