library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.mips_types.all;

entity Register_File is
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
end Register_File;

architecture mixed of Register_File is
  component dffg_N is
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));
  end component;
  component mux32t1 is
  port(data    : in t_bus_32x32;
        sel     : in std_logic_vector(4 downto 0);
        o_O     : out std_logic_vector(31 downto 0));
  end component;
  component decoder_5t32 is
  generic(N : integer := 32);
  port(D_IN   :   in std_logic_vector(4 downto 0);
       F_OUT  :   out std_logic_vector(N-1 downto 0));
  end component;
  signal s_And_vector      : std_logic_vector(31 downto 0);
  signal s_And             : t_bus_32x1;
  signal reg_inputs        : std_logic_vector(31 downto 0);
  signal registers         : t_bus_32x32;
  -- Custom reset value for register 29
  signal reg29_rst_val     : std_logic_vector(N-1 downto 0);
begin
  -- Set the reset value for register 29
  reg29_rst_val <= x"7FFFEFFC";

  decoder: decoder_5t32
  generic map(N => N)
    port map(D_IN   => rd,
             F_OUT  => s_And_vector);
  process(s_And_vector)
  begin
      for i in 0 to 31 loop
          s_And(i) <= s_And_vector(i);
      end loop;
  end process;
  and_gates: for i in 0 to 31 generate
    reg_inputs(i) <= s_And(i) and wReg;
  end generate;
  
  -- Register 0 is hardwired to zero
  reg_zero: dffg_N
    generic map(N => N)
    port map(i_CLK => iCLK,
             i_RST => '1',
             i_WE  => '0',
             i_D   => (others => '0'),
             o_Q   => registers(0));
  
  -- Process to handle register 29 with custom reset value
  process(iCLK, iRST)
  begin
    if (iRST = '1') then
      registers(29) <= reg29_rst_val;
    elsif rising_edge(iCLK) then
      if reg_inputs(29) = '1' then
        registers(29) <= wData;
      end if;
    end if;
  end process;
  
  -- Generate all other registers (except 0 and 29)
  registers_others: for i in 1 to 31 generate
    normal_reg: if i /= 29 generate
      dffg_N32: dffg_N
        generic map(N => N)
        port map(i_CLK => iCLK,
                 i_RST => iRST,
                 i_WE  => reg_inputs(i),
                 i_D   => wData,
                 o_Q   => registers(i));
    end generate normal_reg;
  end generate registers_others;
  
  mux_1: mux32t1
    port map(data  => registers,
             sel   => rs,
             o_O   => oR_1);
  mux_2: mux32t1
    port map(data  => registers,
             sel   => rt,
             o_O   => oR_2);
end mixed;
