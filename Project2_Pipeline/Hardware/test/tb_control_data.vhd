library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library std;
use std.env.all;

entity tb_control_unit is
  generic(
    gCLK_HPER : time := 10 ns  -- Generic for half of the clock cycle period
  );
end tb_control_unit;

architecture mixed of tb_control_unit is
  -- Define the total clock period time
  constant cCLK_PER : time := gCLK_HPER * 2;

  -- Component Declaration for control_unit
  component control_unit is
    port (
      opcode      : in std_logic_vector(5 downto 0);  -- 6-bit opcode input
      funct       : in std_logic_vector(5 downto 0);  -- 6-bit function input
      Reg_Dst     : out std_logic_vector(1 downto 0); -- Register Destination signal
      Jump        : out std_logic;                    -- Jump control signal
      Branch      : out std_logic;                    -- Branch control signal
      MemRead     : out std_logic;                    -- Memory Read signal
      MemtoReg    : out std_logic;                    -- Memory to Register signal
      AluOp       : out std_logic_vector(3 downto 0); -- ALU operation
      MemWrite    : out std_logic;                    -- Memory Write signal
      ALUSrc      : out std_logic;                    -- ALU Source signal
      RegWrite    : out std_logic;                    -- Register Write signal
      LoadWord    : out std_logic;                    -- Load Word
      LoadType    : out std_logic_vector(1 downto 0); -- loadtype 
      Halt        : out std_logic;                    -- Halt   
      JAL         : out std_logic;
      SignExtend  : out std_logic;
      JR          : out std_logic;
      BNE         : out std_logic;
      shift       : out std_logic;
      shiftvar    : out std_logic;
      Overflow_en : out std_logic                     -- Overflow enable signal                 
    );
  end component;

  -- Test signals
  signal iCLK          : std_logic := '0';
  signal s_opcode      : std_logic_vector(5 downto 0) := (others => '0');
  signal s_funct       : std_logic_vector(5 downto 0) := (others => '0');
  signal s_Reg_Dst     : std_logic_vector(1 downto 0);
  signal s_Jump        : std_logic;
  signal s_Branch      : std_logic;
  signal s_MemRead     : std_logic;
  signal s_MemtoReg    : std_logic;
  signal s_AluOp       : std_logic_vector(3 downto 0);
  signal s_MemWrite    : std_logic;
  signal s_ALUSrc      : std_logic;
  signal s_RegWrite    : std_logic;
  signal s_LoadWord    : std_logic;
  signal s_LoadType    : std_logic_vector(1 downto 0);
  signal s_Halt        : std_logic;
  signal s_JAL         : std_logic;
  signal s_SignExtend  : std_logic;
  signal s_JR          : std_logic;
  signal s_BNE         : std_logic;
  signal s_shift       : std_logic;
  signal s_shiftvar    : std_logic;
  signal s_Overflow_en : std_logic;

  -- Constants for instruction opcodes and function codes
  -- R-type opcodes
  constant RTYPE_OP    : std_logic_vector(5 downto 0) := "000000";

  -- R-type function codes
  constant FUNC_ADD    : std_logic_vector(5 downto 0) := "100000";
  constant FUNC_ADDU   : std_logic_vector(5 downto 0) := "100001";
  constant FUNC_SUB    : std_logic_vector(5 downto 0) := "100010";
  constant FUNC_SUBU   : std_logic_vector(5 downto 0) := "100011";
  constant FUNC_AND    : std_logic_vector(5 downto 0) := "100100";
  constant FUNC_OR     : std_logic_vector(5 downto 0) := "100101";
  constant FUNC_XOR    : std_logic_vector(5 downto 0) := "100110";
  constant FUNC_NOR    : std_logic_vector(5 downto 0) := "100111";
  constant FUNC_SLT    : std_logic_vector(5 downto 0) := "101010";
  constant FUNC_SLL    : std_logic_vector(5 downto 0) := "000000";
  constant FUNC_SRL    : std_logic_vector(5 downto 0) := "000010";
  constant FUNC_SRA    : std_logic_vector(5 downto 0) := "000011";
  constant FUNC_SLLV   : std_logic_vector(5 downto 0) := "000100";
  constant FUNC_SRLV   : std_logic_vector(5 downto 0) := "000110";
  constant FUNC_SRAV   : std_logic_vector(5 downto 0) := "000111";
  constant FUNC_JR     : std_logic_vector(5 downto 0) := "001000";

  -- I-type opcodes
  constant ADDI_OP     : std_logic_vector(5 downto 0) := "001000";
  constant ADDIU_OP    : std_logic_vector(5 downto 0) := "001001";
  constant ANDI_OP     : std_logic_vector(5 downto 0) := "001100";
  constant ORI_OP      : std_logic_vector(5 downto 0) := "001101";
  constant XORI_OP     : std_logic_vector(5 downto 0) := "001110";
  constant LUI_OP      : std_logic_vector(5 downto 0) := "001111";
  constant LW_OP       : std_logic_vector(5 downto 0) := "100011";
  constant SW_OP       : std_logic_vector(5 downto 0) := "101011";
  constant BEQ_OP      : std_logic_vector(5 downto 0) := "000100";
  constant BNE_OP      : std_logic_vector(5 downto 0) := "000101";
  constant SLTI_OP     : std_logic_vector(5 downto 0) := "001010";
  constant LB_OP       : std_logic_vector(5 downto 0) := "100000";
  constant LH_OP       : std_logic_vector(5 downto 0) := "100001";
  constant LBU_OP      : std_logic_vector(5 downto 0) := "100100";
  constant LHU_OP      : std_logic_vector(5 downto 0) := "100101";

  -- J-type opcodes
  constant J_OP        : std_logic_vector(5 downto 0) := "000010";
  constant JAL_OP      : std_logic_vector(5 downto 0) := "000011";

  -- Special opcodes
  constant HALT_OP     : std_logic_vector(5 downto 0) := "010100";

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
  DUT: control_unit port map (
    opcode      => s_opcode,
    funct       => s_funct,
    Reg_Dst     => s_Reg_Dst,
    Jump        => s_Jump,
    Branch      => s_Branch,
    MemRead     => s_MemRead,
    MemtoReg    => s_MemtoReg,
    AluOp       => s_AluOp,
    MemWrite    => s_MemWrite,
    ALUSrc      => s_ALUSrc,
    RegWrite    => s_RegWrite,
    LoadWord    => s_LoadWord,
    LoadType    => s_LoadType,
    Halt        => s_Halt,
    JAL         => s_JAL,
    SignExtend  => s_SignExtend,
    JR          => s_JR,
    BNE         => s_BNE,
    shift       => s_shift,
    shiftvar    => s_shiftvar,
    Overflow_en => s_Overflow_en
  );

  -- Test cases process
  P_TEST_CASES: process
  begin
    -- Test R-type arithmetic instructions
    s_opcode <= RTYPE_OP;
    
    -- ADD
    s_funct <= FUNC_ADD;
    wait for cCLK_PER;
    
    -- ADDU
    s_funct <= FUNC_ADDU;
    wait for cCLK_PER;
    
    -- SUB
    s_funct <= FUNC_SUB;
    wait for cCLK_PER;
    
    -- SUBU
    s_funct <= FUNC_SUBU;
    wait for cCLK_PER;
    
    -- Test R-type logical instructions
    -- AND
    s_funct <= FUNC_AND;
    wait for cCLK_PER;
    
    -- OR
    s_funct <= FUNC_OR;
    wait for cCLK_PER;
    
    -- XOR
    s_funct <= FUNC_XOR;
    wait for cCLK_PER;
    
    -- NOR
    s_funct <= FUNC_NOR;
    wait for cCLK_PER;
    
    -- Test R-type shift instructions
    -- SLL
    s_funct <= FUNC_SLL;
    wait for cCLK_PER;
    
    -- SRL
    s_funct <= FUNC_SRL;
    wait for cCLK_PER;
    
    -- SRA
    s_funct <= FUNC_SRA;
    wait for cCLK_PER;
    
    -- SLLV
    s_funct <= FUNC_SLLV;
    wait for cCLK_PER;
    
    -- SRLV
    s_funct <= FUNC_SRLV;
    wait for cCLK_PER;
    
    -- SRAV
    s_funct <= FUNC_SRAV;
    wait for cCLK_PER;
    
    -- SLT
    s_funct <= FUNC_SLT;
    wait for cCLK_PER;
    
    -- JR
    s_funct <= FUNC_JR;
    wait for cCLK_PER;
    
    -- Test I-type instructions
    -- ADDI
    s_opcode <= ADDI_OP;
    s_funct <= (others => '0'); -- Don't care for I-type
    wait for cCLK_PER;
    
    -- ADDIU
    s_opcode <= ADDIU_OP;
    wait for cCLK_PER;
    
    -- ANDI
    s_opcode <= ANDI_OP;
    wait for cCLK_PER;
    
    -- ORI
    s_opcode <= ORI_OP;
    wait for cCLK_PER;
    
    -- XORI
    s_opcode <= XORI_OP;
    wait for cCLK_PER;
    
    -- LUI
    s_opcode <= LUI_OP;
    wait for cCLK_PER;
    
    -- SLTI
    s_opcode <= SLTI_OP;
    wait for cCLK_PER;
    
    -- Memory operations
    -- LW
    s_opcode <= LW_OP;
    wait for cCLK_PER;
    
    -- SW
    s_opcode <= SW_OP;
    wait for cCLK_PER;
    
    -- LB
    s_opcode <= LB_OP;
    wait for cCLK_PER;
    
    -- LH
    s_opcode <= LH_OP;
    wait for cCLK_PER;
    
    -- LBU
    s_opcode <= LBU_OP;
    wait for cCLK_PER;
    
    -- LHU
    s_opcode <= LHU_OP;
    wait for cCLK_PER;
    
    -- Control flow operations
    -- BEQ
    s_opcode <= BEQ_OP;
    wait for cCLK_PER;
    
    -- BNE
    s_opcode <= BNE_OP;
    wait for cCLK_PER;
    
    -- J
    s_opcode <= J_OP;
    wait for cCLK_PER;
    
    -- JAL
    s_opcode <= JAL_OP;
    wait for cCLK_PER;
    
    -- HALT
    s_opcode <= HALT_OP;
    wait for cCLK_PER;
    
    -- Done with simulation
    wait; -- Wait forever
  end process;
end mixed;
