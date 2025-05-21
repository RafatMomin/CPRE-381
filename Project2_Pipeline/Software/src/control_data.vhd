library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity control_unit is
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
        SignExtend : out std_logic;
        JR : out std_logic;
        BNE : out std_logic;
        shift : out std_logic;
        shiftvar : out std_logic;
        Overflow_en : out std_logic               -- Overflow enable signal                 
    );
end control_unit;

architecture dataflow of control_unit is
begin

    -- Decode the control signals based on opcode
        with opcode select

        Reg_Dst  <= "01" when "000000",  -- R-type instruction
                    "10" when "000011",
                    "00" when others;

        shift <= '1' when ((opcode="000000" and funct="000000") or (opcode="000000" and funct="000010") or (opcode="000000" and funct="000011"))
            else '0';

        shiftvar <= '1' when ((opcode="000000" and funct="000100") or (opcode="000000" and funct="000110") or (opcode="000000" and funct="000111") or (opcode="000000" and funct="000000") or (opcode="000000" and funct="000010") or (opcode="000000" and funct="000011"))
               else '0';

        with opcode select 
        BNE  <= '1' when "000101",
                '0' when others;           

        with opcode select
        SignExtend <= '1' when "001000" | "001001" | "100100" | "100101" | "100011" | "001010" | "101011",
                      '0' when others;

        
        JR <= '1' when ((opcode="000000" and funct="001000"))
            else '0';

        with opcode select
        JAL      <= '1' when "000011",
                    '0' when others;

        with opcode select
        Halt <= '1' when "010100",       -- Halt instruction
                '0' when others;

        with opcode select
        Jump     <= '1' when "000010" | "000011",  -- Jump instruction
                    '0' when others;

	with opcode select
        Branch   <= '1' when "000100" | "000101",  -- Branch instructions
                    '0' when others;

	with opcode select
        MemRead  <= '1' when "100011" | "100000" | "100001" | "100100" | "100101",  -- Load word instruction
                    '0' when others;

	with opcode select
        MemtoReg <= '1' when "100011" | "100000" | "100001" | "100100" | "100101",  -- Load word instruction
                    '0' when others;

	AluOp <= "0000" when ((opcode="000000" and funct="100000") or               -- ADD
                          (opcode="000000" and funct="100001") or                   -- ADDU
                          (opcode="001000") or                                      -- ADDI
                          (opcode="001001") or                                      -- ADDIU
                          (opcode="100011") or                                      -- LW
                          (opcode="101011") or                                      -- SW
                          (opcode="100000") or                                      -- LB
                          (opcode="100001") or                                      -- LH
                          (opcode="100100") or                                      -- LBU
                          (opcode="100101"))                                        -- LHU
        else "0001" when ((opcode="000000" and funct="100010") or                   -- SUB
                          (opcode="000000" and funct="100011") or                   -- SUBU
                          (opcode="000100") or                                      -- BEQ
                          (opcode="000101"))                                        -- BNE
        else "0010" when ((opcode="000000" and funct="100100") or                   -- AND
                          (opcode="001100"))                                        -- ANDI
        else "0011" when ((opcode="000000" and funct="100110") or                   -- XOR
                          (opcode="001110"))                                        -- XORI
        else "0100" when ((opcode="000000" and funct="100101") or                   -- OR
                          (opcode="001101"))                                        -- ORI
        else "0101" when (opcode="000000" and funct="100111")                       -- NOR
        else "0111" when ((opcode="000000" and funct="000000") or                   -- SLL
                          (opcode="000000" and funct="000100"))                     -- SLLV
        else "1000" when ((opcode="000000" and funct="000010") or                   -- SRL
                          (opcode="000000" and funct="000110"))                     -- SRLV
        else "1001" when ((opcode="000000" and funct="000011") or                   -- SRA
                          (opcode="000000" and funct="000111"))                     -- SRAV
        else "1011" when ((opcode="000000" and funct="101010") or                   -- SLT
                          (opcode="001010"))                                        -- SLTI
        else "1100" when (opcode="001111")                                          -- LUI
        else "1010";                                                                -- Other types (J, JR, JAL)
               


        with opcode  select
        
        LoadWord  <= '1' when ("100011"),
                     '0' when others;
       with opcode  select
        
        LoadType  <= "00" when ("100000"),
                     "01" when ("100001"), 
                     "10" when ("100100"),
                     "11" when ("100101"),
                     "00" when others;

	with opcode  select
        
        MemWrite <= '1' when "101011",  -- Store word instruction
                    '0' when others;

                   
        ALUSrc <= '1' when (opcode="100011") or                  -- LW
                              (opcode="101011") or                  -- SW
                              (opcode="001000") or                  -- ADDI
                              (opcode="001001") or                  -- ADDIU
                              (opcode="001100") or                  -- ANDI
                              (opcode="001111") or                  -- LUI
                              (opcode="001110") or                  -- XORI
                              (opcode="001101") or                  -- ORI
                              (opcode="001010") or                  -- SLTI
                              (opcode="100000") or                  -- LB
                              (opcode="100001") or                  -- LH
                              (opcode="100100") or                  -- LBU
                              (opcode="100101")                     -- LHU 
                 else '0';


	RegWrite <= '0' when (opcode="101011" or      -- SW
                         opcode="000100" or       -- BEQ
                         opcode="000101" or       -- BNE
                         opcode="000010")         -- J
                   else '1';

        Overflow_en <= '1' when ((opcode="000000" and funct="100000") or   -- ADD
                            (opcode="001000") or                           -- ADDI
                            (opcode="000000" and funct="100010"))          -- SUB
                  else '0';
        
end dataflow;

