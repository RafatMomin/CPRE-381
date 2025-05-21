library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library std;
use std.env.all;

entity tb_BarrelShifter is
  generic(
    gCLK_HPER : time := 10 ns  -- Generic for half of the clock cycle period
  );
end tb_BarrelShifter;

architecture mixed of tb_BarrelShifter is
  -- Define the total clock period time
  constant cCLK_PER : time := gCLK_HPER * 2;

  -- Component Declaration for BarrelShifter
  component BarrelShifter is
    port (
      input      : in std_logic_vector(31 downto 0);
      shift_amt  : in std_logic_vector(31 downto 0);
      ALUOp      : in std_logic_vector(3 downto 0);
      output     : out std_logic_vector(31 downto 0)
    );
  end component;

  -- Test signals
  signal iCLK        : std_logic := '0';
  signal s_input     : std_logic_vector(31 downto 0) := (others => '0');
  signal s_shift_amt : std_logic_vector(31 downto 0) := (others => '0');
  signal s_ALUOp     : std_logic_vector(3 downto 0)  := (others => '0');
  signal s_output    : std_logic_vector(31 downto 0);

  -- Constants for ALUOp codes
  constant ALU_SLL : std_logic_vector(3 downto 0) := "0111";  -- Shift Left Logical
  constant ALU_SRL : std_logic_vector(3 downto 0) := "1000";  -- Shift Right Logical
  constant ALU_SRA : std_logic_vector(3 downto 0) := "1001";  -- Shift Right Arithmetic

begin
  -- Clock generation process
  P_CLK: process
  begin
    iCLK <= '1';
    wait for gCLK_HPER;
    iCLK <= '0';
    wait for gCLK_HPER;
  end process;

  -- Instantiate the Unit Under Test (UUT)
  DUT: BarrelShifter port map (
    input     => s_input,
    shift_amt => s_shift_amt,
    ALUOp     => s_ALUOp,
    output    => s_output
  );

  -- Test cases process
  P_TEST_CASES: process
  begin
    -- Test SLL (Shift Left Logical) instruction
    s_input <= X"12345678";
    s_shift_amt <= X"00000004"; -- Shift by 4
    s_ALUOp <= ALU_SLL;
    wait for cCLK_PER;
    
    s_input <= X"FEDCBA98";
    s_shift_amt <= X"00000008"; -- Shift by 8
    s_ALUOp <= ALU_SLL;
    wait for cCLK_PER;
    
    s_input <= X"FFFFFFFF";
    s_shift_amt <= X"0000001F"; -- Shift by 31 (max shift)
    s_ALUOp <= ALU_SLL;
    wait for cCLK_PER;
    
    -- Test SLLV (Shift Left Logical Variable) instruction - uses same ALUOp as SLL
    s_input <= X"12345678";
    s_shift_amt <= X"00000004"; -- Shift by 4
    s_ALUOp <= ALU_SLL;
    wait for cCLK_PER;
    
    s_input <= X"FEDCBA98";
    s_shift_amt <= X"00000008"; -- Shift by 8
    s_ALUOp <= ALU_SLL;
    wait for cCLK_PER;
    
    s_input <= X"00000001";
    s_shift_amt <= X"00000000"; -- No shift
    s_ALUOp <= ALU_SLL;
    wait for cCLK_PER;
    
    -- Test SRL (Shift Right Logical) instruction
    s_input <= X"12345678";
    s_shift_amt <= X"00000004"; -- Shift by 4
    s_ALUOp <= ALU_SRL;
    wait for cCLK_PER;
    
    s_input <= X"FEDCBA98";
    s_shift_amt <= X"00000008"; -- Shift by 8
    s_ALUOp <= ALU_SRL;
    wait for cCLK_PER;
    
    s_input <= X"80000000";
    s_shift_amt <= X"0000001F"; -- Shift by 31 (max shift)
    s_ALUOp <= ALU_SRL;
    wait for cCLK_PER;
    
    -- Test SRLV (Shift Right Logical Variable) instruction - uses same ALUOp as SRL
    s_input <= X"12345678";
    s_shift_amt <= X"00000004"; -- Shift by 4
    s_ALUOp <= ALU_SRL;
    wait for cCLK_PER;
    
    s_input <= X"FEDCBA98";
    s_shift_amt <= X"00000008"; -- Shift by 8
    s_ALUOp <= ALU_SRL;
    wait for cCLK_PER;
    
    s_input <= X"00000001";
    s_shift_amt <= X"00000000"; -- No shift
    s_ALUOp <= ALU_SRL;
    wait for cCLK_PER;
    
    -- Test SRA (Shift Right Arithmetic) instruction
    s_input <= X"12345678";
    s_shift_amt <= X"00000004"; -- Shift by 4
    s_ALUOp <= ALU_SRA;
    wait for cCLK_PER;
    
    s_input <= X"FEDCBA98"; -- Negative number (MSB=1)
    s_shift_amt <= X"00000008"; -- Shift by 8
    s_ALUOp <= ALU_SRA;
    wait for cCLK_PER;
    
    s_input <= X"80000000"; -- Most negative number
    s_shift_amt <= X"0000001F"; -- Shift by 31 (max shift)
    s_ALUOp <= ALU_SRA;
    wait for cCLK_PER;
    
    -- Test SRAV (Shift Right Arithmetic Variable) instruction - uses same ALUOp as SRA
    s_input <= X"12345678";
    s_shift_amt <= X"00000004"; -- Shift by 4
    s_ALUOp <= ALU_SRA;
    wait for cCLK_PER;
    
    s_input <= X"FEDCBA98"; -- Negative number (MSB=1)
    s_shift_amt <= X"00000008"; -- Shift by 8
    s_ALUOp <= ALU_SRA;
    wait for cCLK_PER;
    
    s_input <= X"00000001";
    s_shift_amt <= X"00000000"; -- No shift
    s_ALUOp <= ALU_SRA;
    wait for cCLK_PER;
    
    -- Test large shift value but only 5 bits should be used
    s_input <= X"FFFFFFFF";
    s_shift_amt <= X"FFFFFF04"; -- Only 4 bits (0x04) should be used
    s_ALUOp <= ALU_SLL;
    wait for cCLK_PER;
    
    -- Done with simulation
    wait; -- Wait forever
  end process;
end mixed;
