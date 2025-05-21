library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pipeline_register is
-- Testbench has no ports
end tb_pipeline_register;

architecture behavior of tb_pipeline_register is
  -- Clock period definition
  constant clk_period : time := 10 ns;

  -- Component declarations for pipeline registers
  component Pipeline_Register_N
    generic(N : integer := 32);
    port( iCLK    : in std_logic;
          iRST    : in std_logic;
          iSTALL  : in std_logic;
          iFLUSH  : in std_logic;
          i_D     : in std_logic_vector(N-1 downto 0);
          o_Q     : out std_logic_vector(N-1 downto 0));
  end component;

  -- Clock signal
  signal clk : std_logic := '0';
  -- Reset signal
  signal rst : std_logic := '1';

  -- Input data for first register
  signal data_in : std_logic_vector(31 downto 0) := x"00000000";
  
  -- Control signals for each register
  signal stall_if_id : std_logic := '0';
  signal stall_id_ex : std_logic := '0';
  signal stall_ex_mem : std_logic := '0';
  signal stall_mem_wb : std_logic := '0';
  
  signal flush_if_id : std_logic := '0';
  signal flush_id_ex : std_logic := '0';
  signal flush_ex_mem : std_logic := '0';
  signal flush_mem_wb : std_logic := '0';
  
  -- Register outputs
  signal if_id_out : std_logic_vector(31 downto 0);
  signal id_ex_out : std_logic_vector(31 downto 0);
  signal ex_mem_out : std_logic_vector(31 downto 0);
  signal mem_wb_out : std_logic_vector(31 downto 0);
  
begin
  -- Instantiate the pipeline registers
  IF_ID_reg: Pipeline_Register_N
    generic map(N => 32)
    port map(
      iCLK => clk,
      iRST => rst,
      iSTALL => stall_if_id,
      iFLUSH => flush_if_id,
      i_D => data_in,
      o_Q => if_id_out
    );
    
  ID_EX_reg: Pipeline_Register_N
    generic map(N => 32)
    port map(
      iCLK => clk,
      iRST => rst,
      iSTALL => stall_id_ex,
      iFLUSH => flush_id_ex,
      i_D => if_id_out,
      o_Q => id_ex_out
    );
    
  EX_MEM_reg: Pipeline_Register_N
    generic map(N => 32)
    port map(
      iCLK => clk,
      iRST => rst,
      iSTALL => stall_ex_mem,
      iFLUSH => flush_ex_mem,
      i_D => id_ex_out,
      o_Q => ex_mem_out
    );
    
  MEM_WB_reg: Pipeline_Register_N
    generic map(N => 32)
    port map(
      iCLK => clk,
      iRST => rst,
      iSTALL => stall_mem_wb,
      iFLUSH => flush_mem_wb,
      i_D => ex_mem_out,
      o_Q => mem_wb_out
    );
    
  -- Clock process
  clk_process: process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;
  
  -- Stimulus process
  stim_proc: process
  begin
    -- Hold reset for a few clock cycles
    wait for clk_period*2;
    rst <= '0';
    
    -- Test normal operation: values propagate through pipeline
    wait for clk_period;
    data_in <= x"AAAAAAAA";  -- First value
    
    wait for clk_period;
    data_in <= x"BBBBBBBB";  -- Second value
    
    wait for clk_period;
    data_in <= x"CCCCCCCC";  -- Third value
    
    wait for clk_period;
    data_in <= x"DDDDDDDD";  -- Fourth value
    
    -- Allow time for the first value to propagate through all stages
    wait for clk_period;
    data_in <= x"EEEEEEEE";  -- Fifth value
    
    -- After this point, the first value (0xAAAAAAAA) should be at MEM_WB output
    -- Verify this in simulation
    
    -- Test stalling IF/ID register
    wait for clk_period;
    data_in <= x"11111111";
    stall_if_id <= '1';  -- Stall IF/ID register
    
    wait for clk_period;
    data_in <= x"22222222";  -- This value should not be captured by IF/ID
    
    wait for clk_period;
    stall_if_id <= '0';  -- Release stall
    data_in <= x"33333333";  -- This value should be captured
    
    -- Test flushing ID/EX register
    wait for clk_period;
    flush_id_ex <= '1';  -- Flush ID/EX register
    data_in <= x"44444444";
    
    wait for clk_period;
    flush_id_ex <= '0';  -- Release flush
    data_in <= x"55555555";
    
    -- Test stalling multiple registers
    wait for clk_period;
    stall_id_ex <= '1';
    stall_ex_mem <= '1';
    data_in <= x"66666666";
    
    wait for clk_period;
    data_in <= x"77777777";
    
    wait for clk_period;
    stall_id_ex <= '0';
    stall_ex_mem <= '0';
    data_in <= x"88888888";
    
    -- Test flushing MEM/WB register
    wait for clk_period;
    flush_mem_wb <= '1';
    data_in <= x"99999999";
    
    wait for clk_period;
    flush_mem_wb <= '0';
    data_in <= x"AAAAAAAA";
    
    -- Run for a few more cycles to observe complete pipeline behavior
    wait for clk_period*5;
    
    -- End simulation
    assert false report "Simulation ended" severity note;
    wait;
  end process;
end behavior;