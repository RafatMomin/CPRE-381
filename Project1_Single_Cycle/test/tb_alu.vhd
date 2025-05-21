library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library std;
use std.env.all;

entity tb_alu is
  generic(
    gCLK_HPER : time := 10 ns  -- Generic for half of the clock cycle period
  );
end tb_alu;

architecture mixed of tb_alu is
  -- Define the total clock period time
  constant cCLK_PER : time := gCLK_HPER * 2;

  -- Component Declaration for ALU
  component ALU is
    port (
      iA         : in std_logic_vector(31 downto 0); -- First operand
      iB         : in std_logic_vector(31 downto 0); -- Second operand
      ALUCtrl    : in std_logic_vector(3 downto 0);  -- Control signals for ALU operations
      BNE        : in std_logic;                     -- BNE flag
      overflow_en: in std_logic;                     -- Overflow enable from control unit
      shift      : in std_logic;                     -- Shift control
      resultF    : out std_logic_vector(31 downto 0); -- Result output
      CarryOut   : out std_logic;                    -- Carry-out signal
      Overflow   : out std_logic;                    -- Overflow signal
      Zero       : out std_logic                     -- Zero signal
    );
  end component;

  -- Test signals
  signal iCLK         : std_logic := '0';
  signal s_iA         : std_logic_vector(31 downto 0) := (others => '0');
  signal s_iB         : std_logic_vector(31 downto 0) := (others => '0');
  signal s_ALUCtrl    : std_logic_vector(3 downto 0) := (others => '0');
  signal s_BNE        : std_logic := '0';
  signal s_overflow_en: std_logic := '1'; -- Enable overflow by default
  signal s_shift      : std_logic := '0';
  signal s_resultF    : std_logic_vector(31 downto 0);
  signal s_CarryOut   : std_logic;
  signal s_Overflow   : std_logic;
  signal s_Zero       : std_logic;

  -- Constants for ALU control codes
  constant ALU_ADD : std_logic_vector(3 downto 0) := "0000";
  constant ALU_SUB : std_logic_vector(3 downto 0) := "0001";
  constant ALU_AND : std_logic_vector(3 downto 0) := "0010";
  constant ALU_XOR : std_logic_vector(3 downto 0) := "0011";
  constant ALU_OR  : std_logic_vector(3 downto 0) := "0100";
  constant ALU_NOR : std_logic_vector(3 downto 0) := "0101";
  constant ALU_SLL : std_logic_vector(3 downto 0) := "0111";
  constant ALU_SRL : std_logic_vector(3 downto 0) := "1000";
  constant ALU_SRA : std_logic_vector(3 downto 0) := "1001";
  constant ALU_SLT : std_logic_vector(3 downto 0) := "1011";
  constant ALU_LUI : std_logic_vector(3 downto 0) := "1100";

begin
  -- Clock generation process
  P_CLK: process
  begin
    iCLK <= '0';
    wait for gCLK_HPER;
    iCLK <= '1';
    wait for gCLK_HPER;
  end process;

  -- Instantiate the Unit Under Test (UUT)
  DUT: ALU port map (
    iA          => s_iA,
    iB          => s_iB,
    ALUCtrl     => s_ALUCtrl,
    BNE         => s_BNE,
    overflow_en => s_overflow_en,
    shift       => s_shift,
    resultF     => s_resultF,
    CarryOut    => s_CarryOut,
    Overflow    => s_Overflow,
    Zero        => s_Zero
  );

  -- Test cases process
  P_TEST_CASES: process
  begin
    -- Test 1: Basic Addition
    s_ALUCtrl <= ALU_ADD;
    s_BNE <= '0';
    s_shift <= '0';
    s_iA <= X"00000005"; -- 5
    s_iB <= X"0000000A"; -- 10
    wait for cCLK_PER;
    -- Expected: resultF = 0x0000000F (15), CarryOut = 0, Overflow = 0, Zero = 0
    
    -- Test 2: Addition with Carry
    s_ALUCtrl <= ALU_ADD;
    s_iA <= X"FFFFFFFF"; -- -1 in 2's complement
    s_iB <= X"00000001"; -- 1
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000000, CarryOut = 1, Overflow = 0, Zero = 1
    
    -- Test 3: Addition with Overflow
    s_ALUCtrl <= ALU_ADD;
    s_iA <= X"7FFFFFFF"; -- Maximum positive (2^31 - 1)
    s_iB <= X"00000001"; -- 1
    wait for cCLK_PER;
    -- Expected: resultF = 0x80000000 (negative), CarryOut = 0, Overflow = 1, Zero = 0
    
    -- Test 4: Basic Subtraction
    s_ALUCtrl <= ALU_SUB;
    s_iA <= X"0000000F"; -- 15
    s_iB <= X"00000005"; -- 5
    wait for cCLK_PER;
    -- Expected: resultF = 0x0000000A (10), CarryOut = 1, Overflow = 0, Zero = 0

    -- Test 5: Subtraction with Overflow
    s_ALUCtrl <= ALU_SUB;
    s_iA <= X"80000000"; -- Minimum negative
    s_iB <= X"00000001"; -- 1
    wait for cCLK_PER;
    -- Expected: resultF = 0x7FFFFFFF (max positive), CarryOut = 1, Overflow = 1, Zero = 0
    
    -- Test 6: Subtraction resulting in Zero
    s_ALUCtrl <= ALU_SUB;
    s_iA <= X"00000005"; -- 5
    s_iB <= X"00000005"; -- 5
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000000, CarryOut = 1, Overflow = 0, Zero = 1
    
    -- Test 7: AND operation
    s_ALUCtrl <= ALU_AND;
    s_iA <= X"AAAAAAAA"; -- 10101010...
    s_iB <= X"55555555"; -- 01010101...
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000000, Zero = 1

    -- Test 8: AND operation - non-zero result
    s_ALUCtrl <= ALU_AND;
    s_iA <= X"FFFFFFFF"; -- all 1's
    s_iB <= X"F0F0F0F0"; -- 11110000...
    wait for cCLK_PER;
    -- Expected: resultF = 0xF0F0F0F0, Zero = 0
    
    -- Test 9: OR operation
    s_ALUCtrl <= ALU_OR;
    s_iA <= X"AAAAAAAA"; -- 10101010...
    s_iB <= X"55555555"; -- 01010101...
    wait for cCLK_PER;
    -- Expected: resultF = 0xFFFFFFFF, Zero = 0
    
    -- Test 10: OR operation - special case
    s_ALUCtrl <= ALU_OR;
    s_iA <= X"00000000"; -- all 0's
    s_iB <= X"00000000"; -- all 0's
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000000, Zero = 1
    
    -- Test 11: XOR operation
    s_ALUCtrl <= ALU_XOR;
    s_iA <= X"AAAAAAAA"; -- 10101010...
    s_iB <= X"55555555"; -- 01010101...
    wait for cCLK_PER;
    -- Expected: resultF = 0xFFFFFFFF, Zero = 0
    
    -- Test 12: XOR operation - same inputs
    s_ALUCtrl <= ALU_XOR;
    s_iA <= X"AAAAAAAA"; -- 10101010...
    s_iB <= X"AAAAAAAA"; -- 10101010...
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000000, Zero = 1
    
    -- Test 13: NOR operation
    s_ALUCtrl <= ALU_NOR;
    s_iA <= X"AAAAAAAA"; -- 10101010...
    s_iB <= X"55555555"; -- 01010101...
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000000, Zero = 1
    
    -- Test 14: NOR operation - special case
    s_ALUCtrl <= ALU_NOR;
    s_iA <= X"00000000"; -- all 0's
    s_iB <= X"00000000"; -- all 0's
    wait for cCLK_PER;
    -- Expected: resultF = 0xFFFFFFFF, Zero = 0

    -- Test 15: SLT operation - true case
    s_ALUCtrl <= ALU_SLT;
    s_iA <= X"FFFFFFFF"; -- -1 (negative)
    s_iB <= X"00000001"; -- 1 (positive)
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000001, Zero = 0
    
    -- Test 16: SLT operation - false case
    s_ALUCtrl <= ALU_SLT;
    s_iA <= X"00000002"; -- 2
    s_iB <= X"00000001"; -- 1
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000000, Zero = 1
    
    -- Test 17: SLT operation - equality
    s_ALUCtrl <= ALU_SLT;
    s_iA <= X"00000005"; -- 5
    s_iB <= X"00000005"; -- 5
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000000, Zero = 1
    
    -- Test 18: SLL (Shift Left Logical)
    s_ALUCtrl <= ALU_SLL;
    s_shift <= '0'; -- Use iB as shift amount
    s_iA <= X"00000001"; -- Value to shift
    s_iB <= X"00000004"; -- Shift amount
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000010 (16), Zero = 0
    
    -- Test 19: SLL with SLLV format
    s_ALUCtrl <= ALU_SLL;
    s_shift <= '1'; -- Use iA as shift amount, iB as data
    s_iA <= X"00000004"; -- Shift amount
    s_iB <= X"00000001"; -- Value to shift
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000010 (16), Zero = 0
    
    -- Test 20: SRL (Shift Right Logical)
    s_ALUCtrl <= ALU_SRL;
    s_shift <= '0';
    s_iA <= X"80000000"; -- Value to shift (MSB set)
    s_iB <= X"00000001"; -- Shift amount
    wait for cCLK_PER;
    -- Expected: resultF = 0x40000000, Zero = 0
    
    -- Test 21: SRL with large value and shift
    s_ALUCtrl <= ALU_SRL;
    s_shift <= '0';
    s_iA <= X"FFFFFFFF"; -- All 1's
    s_iB <= X"0000001F"; -- Shift by 31 (max)
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000001, Zero = 0
    
    -- Test 22: SRA (Shift Right Arithmetic) with positive number
    s_ALUCtrl <= ALU_SRA;
    s_shift <= '0';
    s_iA <= X"80000000"; -- Minimum negative number
    s_iB <= X"00000001"; -- Shift amount
    wait for cCLK_PER;
    -- Expected: resultF = 0xC0000000 (sign bit replicated), Zero = 0
    
    -- Test 23: SRA with negative number, max shift
    s_ALUCtrl <= ALU_SRA;
    s_shift <= '0';
    s_iA <= X"80000000"; -- Minimum negative number
    s_iB <= X"0000001F"; -- Shift by 31 (max)
    wait for cCLK_PER;
    -- Expected: resultF = 0xFFFFFFFF (all 1's due to sign extension), Zero = 0
    
    -- Test 24: SRA with positive number
    s_ALUCtrl <= ALU_SRA;
    s_shift <= '0';
    s_iA <= X"40000000"; -- Positive number
    s_iB <= X"00000002"; -- Shift amount
    wait for cCLK_PER;
    -- Expected: resultF = 0x10000000, Zero = 0
    
    -- Test 25: LUI operation
    s_ALUCtrl <= ALU_LUI;
    s_iA <= X"FFFFFFFF"; -- Not used for LUI
    s_iB <= X"0000ABCD"; -- Upper 16 bits will be loaded
    wait for cCLK_PER;
    -- Expected: resultF = 0xABCD0000, Zero = 0
    
    -- Test 26: Test BNE flag - Zero = 0
    s_ALUCtrl <= ALU_SUB;
    s_BNE <= '1'; -- Set BNE flag
    s_iA <= X"00000005"; -- 5
    s_iB <= X"00000008"; -- 8
    wait for cCLK_PER;
    -- Expected: resultF = 0xFFFFFFFD (-3), Zero = 1 (inverted due to BNE)
    
    -- Test 27: Test BNE flag - Zero = 1
    s_ALUCtrl <= ALU_SUB;
    s_BNE <= '1'; -- Set BNE flag
    s_iA <= X"00000005"; -- 5
    s_iB <= X"00000005"; -- 5
    wait for cCLK_PER;
    -- Expected: resultF = 0x00000000, Zero = 0 (inverted due to BNE)

    -- Test 28: Test overflow_en - disabled
    s_ALUCtrl <= ALU_ADD;
    s_overflow_en <= '0'; -- Disable overflow
    s_iA <= X"7FFFFFFF"; -- Maximum positive
    s_iB <= X"00000001"; -- 1
    wait for cCLK_PER;
    -- Expected: resultF = 0x80000000, Overflow = 0 (disabled)
    
    -- Test 29: Test overflow_en - enabled
    s_ALUCtrl <= ALU_ADD;
    s_overflow_en <= '1'; -- Enable overflow
    s_iA <= X"7FFFFFFF"; -- Maximum positive
    s_iB <= X"00000001"; -- 1
    wait for cCLK_PER;
    -- Expected: resultF = 0x80000000, Overflow = 1

    -- Done with simulation
    wait; -- Wait forever
  end process;
end mixed;
