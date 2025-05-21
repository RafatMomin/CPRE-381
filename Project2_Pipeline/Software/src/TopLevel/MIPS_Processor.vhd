-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;

entity MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- this signal indicates an overflow exception would have been initiated

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

   -- PC Calculations
  signal s_PC_PLUS_4      : std_logic_vector(N-1 downto 0);
  signal s_Branch_Add     : std_logic_vector(N-1 downto 0);
  signal s_JumpAddr       : std_logic_vector(N-1 downto 0);
  signal s_Add_SignImm    : std_logic_vector(N-1 downto 0);
  signal s_AndBranch      : std_logic;
  signal s_Jump_or_branch : std_logic_vector(N-1 downto 0); 
  signal s_Last_Mux       : std_logic_vector(N-1 downto 0);
  signal s_PC_IN          : std_logic_vector(N-1 downto 0);

  -- s_Inst Seperated Signals
  signal s_Shift_26       : std_logic_vector(25 downto 0);
  signal s_Shift_28       : std_logic_vector(27 downto 0);
  signal s_Inst_15_0       : std_logic_vector(15 downto 0);
  signal s_Inst_25_21     : std_logic_vector(4 downto 0);
  signal s_Inst_20_16     : std_logic_vector(4 downto 0);
  signal s_Inst_15_11     : std_logic_vector(4 downto 0);
  signal s_Inst_10_6      : std_logic_vector(4 downto 0);
  signal s_shamt          : std_logic_vector(N-1 downto 0);
  signal s_REG_31         : std_logic_vector(4 downto 0);
  
  -- Immediate Sign Extend
  signal s_ImmSignExt     : std_logic_vector(N-1 downto 0); 

  -- Control Signals
  signal s_opcode : std_logic_vector(5 downto 0);  -- 6-bit opcode input
  signal s_funct  : std_logic_vector(5 downto 0);   -- 6-bit function input
  signal s_Reg_Dst : std_logic_vector(1 downto 0);                  -- Register Destination signal
  signal s_Jump : std_logic;                     -- Jump control signal
  signal s_Branch : std_logic;                   -- Branch control signal
  signal s_MemRead : std_logic;                  -- Memory Read signal
  signal s_MemtoReg : std_logic;                 -- Memory to Register signal
  signal s_AluOp : std_logic_vector(3 downto 0); -- ALU operation
  signal s_ALUSrc : std_logic;                   -- ALU Source signal
  signal s_LoadWord  : std_logic;                  --Load Word
  signal s_LoadType : std_logic_vector(1 downto 0);  --loadtype 
  signal s_JAL   : std_logic;
  signal s_SignExtend : std_logic;
  signal s_JR : std_logic;
  signal s_BNE : std_logic;
  signal s_shift : std_logic;
  signal s_shiftvar : std_logic;
  signal s_Overflow_en : std_logic;
  signal s_memWrite : std_logic;

  -- Register Outputs
  signal s_Reg_rs : std_logic_vector(N-1 downto 0);
  signal s_Reg_rt : std_logic_vector(N-1 downto 0);

  -- ALU Signals
  signal s_ALU_A   : std_logic_vector(N-1 downto 0);
  signal s_ALU_B   : std_logic_vector(N-1 downto 0);
  signal s_ALU_Out : std_logic_vector(N-1 downto 0);
  signal s_Zero : std_logic;
  signal s_CarryOut : std_logic;
  signal s_temp_zero : std_logic;
 signal s_overflow_EX : std_logic;

  -- Muxes after Load Unit
  signal s_LoadOut : std_logic_vector(N-1 downto 0);
  signal s_Load_Mux : std_logic_vector(N-1 downto 0);
  signal s_WB : std_logic_vector(N-1 downto 0);

  -- Signals After Pipline Registers
  -- IF/ID Signals
  signal s_Out_IMem_ID : std_logic_vector(N-1 downto 0);
  signal s_Out_PC4_ID : std_logic_vector(N-1 downto 0);
  signal s_regWrite_ID : std_logic;
  signal s_halt_ID     : std_logic;
  -- ID/EX Signals
  signal s_memRead_EX    : std_logic;
  signal    s_memWrite_EX   :  std_logic;
  signal    s_loadWord_EX   :  std_logic;
  signal    s_loadType_EX   :  std_logic_vector(1 downto 0);
  signal     s_memToReg_EX   :  std_logic;
  signal     s_regWrite_EX   :  std_logic;
  signal     s_halt_EX       :  std_logic;
  signal    s_ALUOp_EX :  std_logic_vector(3 downto 0);
  signal    s_ALUSrc_EX :  std_logic;
  signal    s_shift_EX  :  std_logic;
  signal    s_BNE_EX    :  std_logic;
  signal     s_shiftvar_EX :  std_logic;
  signal     s_Overflow_en_EX :  std_logic;
  signal    s_regDest_EX :  std_logic_vector(1 downto 0);
  signal    s_signExtend_EX :  std_logic_vector(N-1 downto 0);
  signal     s_rs_EX         :  std_logic_vector(N-1 downto 0);
  signal     s_rt_EX         :  std_logic_vector(N-1 downto 0);
  signal    s_rd_EX         :  std_logic_vector(4 downto 0);
  signal s_jal_EX        :  std_logic;
  signal s_pc4_EX        :  std_logic_vector(N-1 downto 0);
  signal	 s_addr_rt_EX     :  std_logic_vector(4 downto 0);
  signal s_shamt_EX : std_logic_vector(N-1 downto 0);

  --EX/MEM Signals
  signal s_memRead_MEM    : std_logic;
  signal s_memWrite_MEM   : std_logic;
  signal s_loadWord_MEM   : std_logic;
  signal s_loadType_MEM   : std_logic_vector(1 downto 0);
  signal s_memToReg_MEM   : std_logic;
  signal s_regWrite_MEM   : std_logic;
  signal s_halt_MEM       : std_logic;
  signal s_rt_MEM         : std_logic_vector(N-1 downto 0);
  signal s_rd_MEM         : std_logic_vector(4 downto 0);
  signal s_regDest_MEM    : std_logic_vector(1 downto 0);
  signal s_ALU_Out_MEM    : std_logic_vector(N-1 downto 0);
  signal s_overflow_MEM   : std_logic;
  signal s_jal_MEM        : std_logic;
  signal s_pc4_MEM        : std_logic_vector(N-1 downto 0);
  signal s_addr_rt_MEM    : std_logic_vector(4 downto 0);

  -- MEM/WB Signals
  signal s_memToReg_WB      : std_logic;
  signal s_regWrite_WB      : std_logic;
  signal s_loadWord_WB      : std_logic;
  signal s_halt_WB          : std_logic;
  signal s_rt_WB            : std_logic_vector(N-1 downto 0);
  signal s_rd_WB            : std_logic_vector(4 downto 0);
  signal s_regDest_WB       : std_logic_vector(1 downto 0);
  signal s_ALU_Out_WB       : std_logic_vector(N-1 downto 0);
  signal s_LoadUnit_Out_WB  : std_logic_vector(N-1 downto 0);
  signal s_DMEM_Out_WB      : std_logic_vector(N-1 downto 0);
  signal s_overflow_WB      : std_logic;
  signal s_jal_WB           : std_logic;
  signal s_pc4_WB           : std_logic_vector(N-1 downto 0);
  signal s_addr_rt_WB       : std_logic_vector(4 downto 0);

  component PC is 
   port( iCLK   : in std_logic;
         iRST   : in std_logic;  
         i_D    : in std_logic_vector(31 downto 0);
         o_Q    : out std_logic_vector(31 downto 0));
  end component;

  component andg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

  end component;

  component adder_4 is
    Port ( 
        a   : in  STD_LOGIC_VECTOR (31 downto 0);
        sum : out STD_LOGIC_VECTOR (31 downto 0)
    );
   end component;

  component adder_32 is
    Port ( 
        a   : in  STD_LOGIC_VECTOR (31 downto 0);
        b   : in  STD_LOGIC_VECTOR (31 downto 0);
        sum : out STD_LOGIC_VECTOR (31 downto 0)
    );
  end component;

  component Shift_Left_2_26 is
    port (
        input  : in  std_logic_vector(25 downto 0);
        output : out std_logic_vector(27 downto 0)
    );
  end component;

  component Shift_Left_2 is
    port (
        input  : in  std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0)
    );
   end component;

  component control_unit is
    port (
        opcode : in std_logic_vector(5 downto 0);  -- 6-bit opcode input
        funct  : in std_logic_vector(5 downto 0);   -- 6-bit function input
        Reg_Dst : out std_logic_vector(1 downto 0);                  -- Register Destination signal
        Jump : out std_logic;                     -- Jump control signal
        Branch : out std_logic;                   -- Branch control signal
        MemRead : out std_logic;                  -- Memory Read signal
        MemtoReg : out std_logic;                 -- Memory to Register signal
        AluOp : out std_logic_vector(3 downto 0); -- ALU operation
        MemWrite : out std_logic;                 -- Memory Write signal
        ALUSrc : out std_logic;                   -- ALU Source signal
        RegWrite : out std_logic;                  -- Register Write signal
        LoadWord  : out std_logic;                  --Load Word
        LoadType : out std_logic_vector(1 downto 0);  --loadtype 
        Halt     : out std_logic;                   -- Halt   
        JAL      : out std_logic;
        JR       : out std_logic;
        SignExtend : out std_logic;
        BNE : out std_logic;
        shift : out std_logic;
        shiftvar : out std_logic;
        Overflow_en : out std_logic               -- Overflow enable signal                 
    );
  end component;

  component Extender is
  port(iX   : in std_logic_vector(15 downto 0);
       iSel : in std_logic;
       oX   : out std_logic_vector(31 downto 0));
  end component;

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

  component ALU is
    port (
        iA        : in std_logic_vector(31 downto 0); -- First operand
        iB        : in std_logic_vector(31 downto 0); -- Second operand
        ALUCtrl   : in std_logic_vector(3 downto 0);  -- Control signals for ALU operations
        BNE       : in std_logic;
        overflow_en   : in std_logic;                 -- Overflow enable from control unit
        shift     : in std_logic;
        resultF   : out std_logic_vector(31 downto 0); -- Result output
        CarryOut  : out std_logic;                   -- Carry-out signal
        Overflow  : out std_logic;                   -- Overflow signal
        Zero      : out std_logic                    -- Zero signal
    );
   end component;

  component load_unit is
    port (
        mem_data   : in std_logic_vector(31 downto 0);  -- 32-bit memory output
        addr       : in std_logic_vector(1 downto 0);   -- Byte offset
        load_type  : in std_logic_vector(1 downto 0);   -- 00: lb, 01: lh, 10: lbu, 11: lhu
        q          : out std_logic_vector(31 downto 0)  -- Processed output
    );
  end component;

  component mux2t1_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

  end component;

  component Mux3to1 is
    generic(N : integer := 16); 
    port (
        in0 : in std_logic_vector(N-1 downto 0); -- Input 0
        in1 : in std_logic_vector(N-1 downto 0); -- Input 1
        in2 : in std_logic_vector(N-1 downto 0); -- Input 2
        sel : in std_logic_vector(1 downto 0);  -- 2-bit select line
        o : out std_logic_vector(N-1 downto 0) -- Output
    );
  end component;

  component EqualityChecker is 
    Port ( 
        A : in STD_LOGIC_VECTOR(31 downto 0);
        B : in STD_LOGIC_VECTOR(31 downto 0);
        BNE : in STD_LOGIC;  -- Branch if Not Equal control signal
        Equal : out STD_LOGIC  -- Output signal indicating equality condition
    );
   end component;

  component IF_ID_Registers is 
   generic(N : integer := 32);
   port( iCLK   : in std_logic;
         iRST   : in std_logic;  -- Reset signal
         i_IMem : in std_logic_vector(N-1 downto 0);
         i_PC_4 : in std_logic_vector(N-1 downto 0);
         o_IMem : out std_logic_vector(N-1 downto 0);
         o_PC_4 : out std_logic_vector(N-1 downto 0));
  end component;

  component ID_EX_Registers is 
   generic(N : integer := 32);
   port( iCLK   : in std_logic;
         iRST   : in std_logic;  -- Reset signal
         i_ALUOp : in std_logic_vector(3 downto 0);
         i_ALUSrc : in std_logic;
         i_shift  : in std_logic;
         i_BNE    : in std_logic;
         i_shiftvar : in std_logic;
         i_Overflow_en : in std_logic;
         i_signExtend : in std_logic_vector(N-1 downto 0);
         i_rs         : in std_logic_vector(N-1 downto 0);
         i_rt         : in std_logic_vector(N-1 downto 0);
         i_rd         : in std_logic_vector(4 downto 0);
         i_memRead    : in std_logic;
         i_memWrite   : in std_logic;
         i_loadWord   : in std_logic;
         i_loadType   : in std_logic_vector(1 downto 0);
         i_memToReg   : in std_logic;
         i_regWrite   : in std_logic;
         i_halt       : in std_logic;
         i_regDest    : in std_logic_vector(1 downto 0);
         i_jal        : in std_logic;
 	 i_pc4        : in std_logic_vector(N-1 downto 0);
         i_addr_rt     : in std_logic_vector(4 downto 0);
         i_shamt      : in std_logic_vector(N-1 downto 0);
         o_memRead    : out std_logic;
         o_memWrite   : out std_logic;
         o_loadWord   : out std_logic;
         o_loadType   : out std_logic_vector(1 downto 0);
         o_memToReg   : out std_logic;
         o_regWrite   : out std_logic;
         o_halt       : out std_logic;
         o_ALUOp : out std_logic_vector(3 downto 0);
         o_ALUSrc : out std_logic;
         o_shift  : out std_logic;
         o_BNE    : out std_logic;
         o_shiftvar : out std_logic;
         o_Overflow_en : out std_logic;
         o_regDest : out std_logic_vector(1 downto 0);
         o_signExtend : out std_logic_vector(N-1 downto 0);
         o_rs         : out std_logic_vector(N-1 downto 0);
         o_rt         : out std_logic_vector(N-1 downto 0);
         o_rd         : out std_logic_vector(4 downto 0);
     	 o_overflow   : out std_logic;
	 o_jal        : out std_logic;
	 o_pc4        : out std_logic_vector(N-1 downto 0);
      	 o_addr_rt     : out std_logic_vector(4 downto 0);
         o_shamt      : out std_logic_vector(N-1 downto 0)
);
         
  end component;

  component EX_MEM_Registers is 
   generic(N : integer := 32);
   port( iCLK   : in std_logic;
         iRST   : in std_logic;  -- Reset signal
         i_memRead    : in std_logic;
         i_memWrite   : in std_logic;
         i_halt       : in std_logic;
         i_loadWord   : in std_logic;
         i_loadType   : in std_logic_vector(1 downto 0);
         i_memToReg   : in std_logic;
         i_regWrite   : in std_logic;
         i_rt         : in std_logic_vector(N-1 downto 0);
         i_rd         : in std_logic_vector(4 downto 0);
	 i_regDest    : in std_logic_vector(1 downto 0);
         i_ALU_Out    : in std_logic_vector(N-1 downto 0);
         i_overflow   : in std_logic;
         i_jal        : in std_logic;
 	 i_pc4        : in std_logic_vector(N-1 downto 0);
         i_addr_rt     : in std_logic_vector(4 downto 0);
	 o_rt         : out std_logic_vector(N-1 downto 0);
         o_rd         : out std_logic_vector(4 downto 0);
	 o_memRead    : out std_logic;
         o_memWrite   : out std_logic;
         o_loadWord   : out std_logic;
         o_loadType   : out std_logic_vector(1 downto 0);
         o_memToReg   : out std_logic;
         o_regWrite   : out std_logic;
         o_halt       : out std_logic;
         o_regDest    : out std_logic_vector(1 downto 0);
	 o_ALU_Out    : out std_logic_vector(N-1 downto 0);
     	 o_overflow   : out std_logic;
	 o_jal        : out std_logic;
	 o_pc4        : out std_logic_vector(N-1 downto 0);
      	 o_addr_rt     : out std_logic_vector(4 downto 0)
         
         );
  end component;

  component MEM_WB_Registers is 
   generic(N : integer := 32);
   port( iCLK   : in std_logic;
         iRST   : in std_logic;  -- Reset signal
         i_memToReg   : in std_logic;
         o_memToReg   : out std_logic;
         i_halt       : in std_logic;
         i_regWrite   : in std_logic;
         i_loadWord   : in std_logic;
         i_rt         : in std_logic_vector(N-1 downto 0);
         i_rd         : in std_logic_vector(4 downto 0);
	 i_regDest    : in std_logic_vector(1 downto 0);
         i_ALU_Out    : in std_logic_vector(N-1 downto 0);
         i_LoadUnit_Out : in std_logic_vector(N-1 downto 0);
         i_DMEM_Out : in std_logic_vector(N-1 downto 0);
         i_overflow   : in std_logic;
         i_jal        : in std_logic;
 	 i_pc4        : in std_logic_vector(N-1 downto 0);
         i_addr_rt     : in std_logic_vector(4 downto 0);
	 o_rt         : out std_logic_vector(N-1 downto 0);
         o_rd         : out std_logic_vector(4 downto 0);
         o_loadWord   : out std_logic;
         o_regWrite   : out std_logic;
         o_halt       : out std_logic;
         o_regDest : out std_logic_vector(1 downto 0);
	 o_ALU_Out : out std_logic_vector(N-1 downto 0);
         o_LoadUnit_Out : out std_logic_vector(N-1 downto 0);
         o_overflow   : out std_logic;
	 o_jal        : out std_logic;
	 o_pc4        : out std_logic_vector(N-1 downto 0);
      	 o_addr_rt     : out std_logic_vector(4 downto 0);
         o_DMEM_Out : out std_logic_vector(N-1 downto 0)
         );
  end component;


begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 

  Program_Counter: PC
    port map(iCLK => iCLK,
             iRST => iRST,
             i_D  => s_PC_IN,
             o_Q  => s_NextInstAddr);

  Add_4: Adder_4
    port map(a => s_NextInstAddr,
             sum => s_PC_PLUS_4);

  IF_ID_REG: if_id_registers
    generic map(N => N)
    port map( iCLK  => iCLK,
         iRST   => iRST,
         i_IMem => s_Inst,
         i_PC_4 => s_PC_PLUS_4,
         o_IMem => s_Out_IMem_ID,
         o_PC_4 => s_Out_PC4_ID);

  -- ID Phase of the pipeline

  s_Shift_26 <= s_Out_IMem_ID(25 downto 0);

  Shift_Left26: Shift_Left_2_26
    port map(input => s_Shift_26,
             output => s_Shift_28);

  s_JumpAddr <= s_Out_PC4_ID(31 downto 28) & s_Shift_28;

  Shift_Left32: Shift_left_2
    port map(
          input => s_ImmSignExt,
          output => s_Add_SignImm);

  Add_PC4_Shift_Left: Adder_32
    port map(a => s_Out_PC4_ID,
             b => s_Add_SignImm,
             sum => s_Branch_Add);

  EQUALITY: EqualityChecker
    Port map( 
        A => s_Reg_rs,
        B => s_Reg_rt,
        BNE => s_BNE,
        Equal => s_Zero
    );


  BranchAnd: andg2
    port map(
       i_A => s_Branch,
       i_B => s_Zero,
       o_F => s_AndBranch);

  PCPLUS4ORBRANCH: mux2t1_n
     generic map(N => N)
     port map(i_S   => s_AndBranch,
             i_D0  => s_PC_PLUS_4,
             i_D1  => s_Branch_Add,
             o_O   => s_Jump_or_branch);

  JumpOrBranch: mux2t1_n
       generic map(N => N)
       port map(i_S   => s_Jump,
             i_D0  => s_Jump_or_branch,
             i_D1  => s_JumpAddr,
             o_O   => s_Last_Mux);

  JumpRegister: mux2t1_n
       generic map(N => N)
       port map(i_S   => s_JR,
             i_D0  => s_Last_Mux,
             i_D1  => s_Reg_rs,
             o_O   => s_PC_IN);
  

  s_opcode <= s_Out_IMem_ID(31 downto 26);
  s_funct  <= s_Out_IMem_ID(5 downto 0);

  Control: control_unit
    port map(opcode => s_opcode,
             funct  => s_funct,
             Reg_Dst => s_Reg_Dst,
             Jump => s_Jump,
             Branch => s_Branch,
             MemRead => s_MemRead,
             MemtoReg => s_MemtoReg,
             AluOp => s_AluOp,
             MemWrite => s_memWrite,       -- s_DMemWr
             ALUSrc => s_ALUSrc,
             RegWrite => s_regWrite_ID,
             LoadWord  => s_LoadWord,
             LoadType  => s_LoadType,
             Halt      => s_halt_ID,
             JAL       => s_JAL,
             JR        => s_JR,
             SignExtend => s_SignExtend,
             BNE => s_BNE,
             shift => s_shift,
             shiftvar => s_shiftvar,
             Overflow_en => s_Overflow_en);


  s_Inst_20_16 <= s_Out_IMem_ID(20 downto 16);
  s_Inst_15_11 <= s_Out_IMem_ID(15 downto 11);
  s_REG_31     <= "11111";

  s_Inst_25_21 <= s_Out_IMem_ID(25 downto 21);

  Reg_File: Register_File
  generic map(N => N)
  port map(iCLK      => iCLK,
           rs        => s_Inst_25_21,       
           rt        => s_Inst_20_16,       
           rd        => s_RegWrAddr,       
           wData     => s_RegWrData,       
           wReg      => s_RegWr,
           iRST      => iRST,       
           oR_1      => s_Reg_rs,       
           oR_2      => s_Reg_rt);

  s_Inst_10_6 <= s_Out_IMem_ID(10 downto 6);
  s_Inst_15_0 <= s_Out_IMem_ID(15 downto 0);

  Sign_Extend: Extender
  port map(
        iX   => s_Inst_15_0,
        iSel => s_SignExtend,
        oX   => s_ImmSignExt);

  

   s_shamt <= "000000000000000000000000000" & s_Out_IMem_ID(10 downto 6);


  -- EX Stage of the Pipeline

  ID_EX_REG: ID_EX_Registers  
   generic map(N => N)
   port map(
         iCLK   => iCLK,
         iRST   => iRST,
         i_ALUOp => s_AluOp,
         i_ALUSrc => s_ALUSrc,
         i_shift  => s_shift,
         i_BNE    => s_BNE,
         i_shiftvar => s_shiftvar,
         i_Overflow_en => s_Overflow_en,
         i_signExtend => s_ImmSignExt,
         i_rs         => s_Reg_rs,
         i_rt         => s_Reg_rt,
         i_rd         => s_Inst_15_11,
         i_memRead    => s_memRead,
         i_memWrite   => s_memWrite,
         i_loadWord   => s_loadWord,
         i_loadType   => s_loadType,
         i_memToReg   => s_memToReg,
         i_regWrite   => s_regWrite_ID,  -- Maybe Fix
         i_halt       => s_halt_ID,
         i_regDest    => s_Reg_Dst,   -- Maybe Fix
         i_jal        => s_jal,
         i_pc4        => s_Out_PC4_ID,
         i_addr_rt    => s_Inst_20_16,
         i_shamt      => s_shamt,
         o_memRead    => s_memRead_EX,
         o_memWrite   => s_memWrite_EX,
         o_loadWord   => s_loadWord_EX,
         o_loadType   => s_loadType_EX,
         o_memToReg   => s_memToReg_EX,
         o_regWrite   => s_regWrite_EX,
         o_halt       => s_halt_EX,
         o_ALUOp      => s_ALUOp_EX,
         o_ALUSrc     => s_ALUSrc_EX,
         o_shift      => s_shift_EX,
         o_BNE        => s_BNE_EX,        -- Does Nothing
         o_shiftvar   => s_shiftvar_EX,
         o_Overflow_en => s_Overflow_en_EX,
         o_regDest    => s_regDest_EX,
         o_signExtend => s_signExtend_EX,
         o_rs         => s_rs_EX,
         o_rt         => s_rt_EX,
         o_rd         => s_rd_EX,
         o_jal        => s_jal_EX,
         o_pc4        => s_pc4_EX,
         o_addr_rt    => s_addr_rt_EX,
         o_shamt      => s_shamt_EX
);
         

  RS_SHAMT_MUX: mux2t1_n
    generic map(N => N)
    port map(i_S   => s_shift_EX,
             i_D0  => s_rs_EX,
             i_D1  => s_shamt_EX,
             o_O   => s_ALU_A);

  RT_IMM_MUX: mux2t1_n
    generic map(N => N)
    port map(i_S   => s_ALUSrc_EX,
             i_D0  => s_rt_EX,
             i_D1  => s_signExtend_EX,
             o_O   => s_ALU_B);

  ALUU: ALU
    port map(
          iA           => s_ALU_A,
          iB           => s_ALU_B,
          ALUCtrl      => s_ALUOp_EX,
          BNE          => s_BNE_EX,
          overflow_en  => s_Overflow_en_EX,
          shift        => s_shiftvar_EX,
          resultF      => s_ALU_Out,
          CarryOut     => s_CarryOut,
          Overflow     => s_overflow_EX,           
          Zero         => s_temp_zero);

   oALUOut <= s_ALU_Out;


  --EX/MEM Phase of the Pipeline
  EX_MEM_REG: EX_MEM_Registers
   generic map(N => N)
   port map(
         iCLK          => iCLK,
         iRST          => iRST,
         i_memRead     => s_memRead_EX,
         i_memWrite    => s_memWrite_EX,
         i_halt        => s_halt_EX,
         i_loadWord    => s_loadWord_EX,
         i_loadType    => s_loadType_EX,
         i_memToReg    => s_memToReg_EX,
         i_regWrite    => s_regWrite_EX,
         i_rt          => s_rt_EX,
         i_rd          => s_rd_EX,
         i_regDest     => s_regDest_EX,
         i_ALU_Out     => s_ALU_Out,  
         i_overflow    => s_overflow_EX,
         i_jal         => s_jal_EX,
         i_pc4         => s_pc4_EX,
         i_addr_rt     => s_addr_rt_EX,
         o_rt          => s_rt_MEM,
         o_rd          => s_rd_MEM,
         o_memRead     => s_memRead_MEM,
         o_memWrite    => s_DMemWr,
         o_loadWord    => s_loadWord_MEM,
         o_loadType    => s_loadType_MEM,
         o_memToReg    => s_memToReg_MEM,
         o_regWrite    => s_regWrite_MEM,
         o_halt        => s_halt_MEM,
         o_regDest     => s_regDest_MEM,
         o_ALU_Out     => s_ALU_Out_MEM,
         o_overflow    => s_overflow_MEM,
         o_jal         => s_jal_MEM,
         o_pc4         => s_pc4_MEM,
         o_addr_rt     => s_addr_rt_MEM
   );

  s_DMemAddr <= s_ALU_Out_MEM;
  s_DMemData <= s_rt_MEM;

  LoadUnit: load_unit
    port map(mem_data  => s_DMemOut,
             addr      => s_ALU_Out_MEM(1 downto 0),
             load_type => s_loadType_MEM,
             q         => s_LoadOut);

  LoadType: mux2t1_n
    generic map(N => N)
    port map(i_S   => s_loadWord_MEM,
             i_D0  => s_LoadOut,
             i_D1  => s_DMemOut,
             o_O   => s_Load_Mux);


  -- WB Phase of the pipeline
  MEM_WB_REG: MEM_WB_Registers
   generic map(N => N)
   port map(
         iCLK           => iCLK,
         iRST           => iRST,
         i_memToReg     => s_memToReg_MEM,
         o_memToReg     => s_memToReg_WB,
         i_halt         => s_halt_MEM,
         i_regWrite     => s_regWrite_MEM,
         i_loadWord     => s_loadWord_MEM,
         i_rt           => s_rt_MEM,
         i_rd           => s_rd_MEM,
         i_regDest      => s_regDest_MEM,
         i_ALU_Out      => s_ALU_Out_MEM,
         i_LoadUnit_Out => s_Load_Mux,   -- Assuming this is from a load unit component
         i_DMEM_Out     => s_DMemOut,       -- Assuming this is from data memory
         i_overflow     => s_overflow_MEM,
         i_jal          => s_jal_MEM,
         i_pc4          => s_pc4_MEM,
         i_addr_rt      => s_addr_rt_MEM,
         o_rt           => s_rt_WB,
         o_rd           => s_rd_WB,
         o_loadWord     => s_loadWord_WB,
         o_regWrite     => s_RegWr,    
         o_halt         => s_Halt,
         o_regDest      => s_regDest_WB,
         o_ALU_Out      => s_ALU_Out_WB,
         o_LoadUnit_Out => s_LoadUnit_Out_WB,
         o_overflow     => s_Ovfl,
         o_jal          => s_jal_WB,
         o_pc4          => s_pc4_WB,
         o_addr_rt      => s_addr_rt_WB,
         o_DMEM_Out     => s_DMEM_Out_WB
   );

  WriteBack: mux2t1_n
     generic map(N => N)
     port map(i_S   => s_memToReg_WB,
             i_D0  => s_ALU_Out_WB,
             i_D1  => s_LoadUnit_Out_WB,
             o_O   => s_WB);

  JALMux: mux2t1_n
    generic map(N => N)
    port map(i_S   => s_jal_WB,
             i_D0  => s_WB,
             i_D1  => s_pc4_WB,
             o_O   => s_RegWrData);

  RT_RD_MUX: Mux3to1
  generic map(N => 5)
  port map(
        in0 => s_addr_rt_WB,   -- RT Location
        in1 => s_rd_WB,   -- RD Location
        in2 => s_REG_31,
        sel => s_regDest_WB,
        o   => s_RegWrAddr);

end structure;

