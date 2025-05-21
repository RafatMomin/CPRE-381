library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
    port (
        iA        : in std_logic_vector(31 downto 0); -- First operand
        iB        : in std_logic_vector(31 downto 0); -- Second operand
        ALUCtrl   : in std_logic_vector(3 downto 0);  -- Control signals for ALU operations
        BNE       : in std_logic;                      --bne flag
        overflow_en   : in std_logic;                 -- Overflow enable from control unit
        shift     : in std_logic;
        resultF   : out std_logic_vector(31 downto 0); -- Result output
        CarryOut  : out std_logic;                   -- Carry-out signal
        Overflow  : out std_logic;                   -- Overflow signal
        Zero      : out std_logic                    -- Zero signal
    );
end ALU;

architecture structural of ALU is
    component Add_Sub_N is
        generic(N : integer := 32);
        port (
            iCLK     : in std_logic;
            iC       : in std_logic;
            iA       : in std_logic_vector(N-1 downto 0);
            iB       : in std_logic_vector(N-1 downto 0);
            oC       : out std_logic;
            overflow : out std_logic;
            oS       : out std_logic_vector(N-1 downto 0)
        );
    end component;

    component BarrelShifter is
        port (
            input      : in std_logic_vector(31 downto 0); -- Data to shift
            shift_amt  : in std_logic_vector(31 downto 0);  -- Shift amount (only lower 5 bits)
            ALUOp      : in std_logic_vector(3 downto 0);  -- ALU operation code
            output     : out std_logic_vector(31 downto 0) -- Shifted output
        );
    end component;

    -- Internal signals for operation results
    signal add_result : std_logic_vector(31 downto 0);
    signal and_result, or_result : std_logic_vector(31 downto 0);
    signal xor_result, nor_result : std_logic_vector(31 downto 0);
    signal shift_result : std_logic_vector(31 downto 0);
    signal slt_result : std_logic_vector(31 downto 0);
    signal lui_result : std_logic_vector(31 downto 0); -- For LUI operation
    signal carry_add : std_logic;
    signal alu_overflow : std_logic;
    signal temp_result : std_logic_vector(31 downto 0); -- Internal temp signal
    signal overflow_enabled : std_logic;  -- Enable Overflow Flag
    signal zero_internal : std_logic; 
    signal s_shiftAmt    : std_logic_vector(31 downto 0);
    signal s_shiftData   : std_logic_vector(31 downto 0);

    -- Constant zero array
    constant ZERO_VECTOR : std_logic_vector(31 downto 0) := (others => '0');

begin

    -- ADD/SUBTRACT MODULE
    alu: Add_Sub_N
        generic map (N => 32)
        port map (
            iCLK => '0',          
            iC => ALUCtrl(0),     -- ALUCtrl(0): 0 = ADD, 1 = SUB
            iA => iA,
            iB => iB,
            oC => carry_add,      -- Carry-out for addition
            overflow => alu_overflow,
            oS => add_result
        );

    -- AND Logic
    and_result <= iA and iB;

    -- OR Logic
    or_result <= iA or iB;

    -- XOR Logic
    xor_result <= iA xor iB;

    -- NOR Logic
    nor_result <= not (iA or iB);

    -- SLT Logic (Fixed)
    slt_result <= (0 => '1', others => '0') when signed(iA) < signed(iB) else (others => '0');

    -- LUI Logic
    lui_result <= iB(15 downto 0) & ZERO_VECTOR(15 downto 0); -- Load upper 16 bits and shift left

    s_shiftAmt <= iA when shift = '1' else iB;

    s_shiftData <= iB when shift = '1' else iA;

    -- SHIFT OPERATIONS MODULE 
    barrel_shifter: BarrelShifter
        port map (
            input      => s_shiftData,         -- The value to be shifted is in iB (rt register)
            shift_amt  => s_shiftAmt,         -- The shift amount is in iA (either from rs or from shamt field)
            ALUOp      => ALUCtrl,    -- Pass ALU control code
            output     => shift_result -- Store the result of the shift operation
        );

    -- Output Multiplexer using temp_result
    with ALUCtrl select
        temp_result <= add_result    when "0000",  -- ADD
                       add_result    when "0001",  -- SUB
                       and_result    when "0010",  -- AND
                       or_result     when "0100",  -- OR 
                       xor_result    when "0011",  -- XOR
                       nor_result    when "0101",  -- NOR
                       shift_result  when "0111",  -- SLL
                       shift_result  when "1000",  -- SRL
                       shift_result  when "1001",  -- SRA
                       slt_result    when "1011",  -- SLT
                       lui_result    when "1100",  -- LUI
                       ZERO_VECTOR   when others;  -- Default: Zero result

    -- Assign temp_result to output resultF
    resultF <= temp_result;

    zero_internal <= '1' when temp_result = ZERO_VECTOR else '0';

    -- Zero Detection for BEQ/BNE
    Zero <= not zero_internal when BNE = '1' else zero_internal;
    
    with ALUCtrl select
        overflow_enabled <= '1' when "0000",  -- ADD
                           '1' when "0001",  -- SUB
                           '0' when others;

    -- Overflow Detection
    Overflow <= alu_overflow and overflow_en;

    -- Carry-out Output
    CarryOut <= carry_add;

end structural;
